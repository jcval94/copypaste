bits<-"rnorm(n=1000,sd=29)"
Cont=TRUE;crit=2;DPQR=TRUE;gen=1;p.val_min=0.05;plot=FALSE;X=rnorm(10)

bits<-"rnorm(n=1000,mean=29)"

bits<-"rnorm(10,11)"

bits<-"rnorm(10)"

bits<-"rnorm(n=10)"

bits<-"rnorm(10,mean=2)"

bits<-"rnorm(10,sd=2)"

bits<-"rnorm(10,sd=2,100)"

bits<-"rnorm(n=10,2,100)"

bits<-"rnorm(n=10,mean=2,100)"

bits<-"FDist(X=rnorm(10), gen = 1, Cont = TRUE, inputNA, plot = FALSE,
  p.val_min = 0.05, crit = 2, DPQR = TRUE)"
#' Write the arguments of a function selected
#'
#' @return arguments ready to run
#' @export
#'
#' @examples
#'
#' rnorm(n=100)
#'
#'
#' n=100;mean=1,sd=0
#'
#'
r.args<-function(){
  ctx <- rstudioapi::getActiveDocumentContext()
if (!is.null(ctx)) {
    if (ctx$selection[[1]]$text != "") {

      bits <- utils::read.csv(text = ctx$selection[[1]]$text,
                               stringsAsFactors = FALSE, header = FALSE)
      bits <- unlist(bits, use.names = FALSE)
      #REMOVE PARENTHESIS
      fun<-strsplit(bits,split = "[(]")[[1]]
      if(length(fun)>2){
        fun[2]<-paste0(fun[-1],collapse = "(")
        fun<-fun[1:2]
      }
      fun[2]<-gsub(" ","",gsub("\n","",fun[2]))
      EVALU<-eval(parse(text = (fun[1])))
      if(is.function(EVALU)){
        comp_args<-formals(fun)
        args<-names(comp_args)
        args<-args[args != "..."]
        if(!is.null(args)){
          cond_pred<-sapply(comp_args,nchar) != 0
          args_n<-comp_args[cond_pred]
          args_predef<-names(args_n)
          args_n<-paste0(names(args_n),"=",sapply(args_n,function(x){as.character(x[[1]])}))
          if(substr(fun[2],nchar(fun[2]),nchar(fun[2]))==")"){
            fun[2]<-substr(fun[2],1,nchar(fun[2])-1)
          }
          #Separa las comas sii no están entre paréntesis

          values<-strsplit(fun[2],",")[[1]]
          values2<-strsplit(values,"=")

          len_val<-sapply(values2,length)
          cond<-len_val==2
          args_writ<-sapply(values2,function(x){x[[1]][1]})[cond]
          args_no_escritos<-args[!args %in% args_writ]
          #args_tofill<-args_no_escritos[!args_no_escritos %in% args_predef]
          pred<-data.frame(A=args_predef,B=args_n)
          writ<-data.frame(A=args_writ,B=values[cond])
          if(length(args_no_escritos)==length(values[!cond])){
            extr<-data.frame(A=args_no_escritos,B=paste0(args_no_escritos,"=",values[!cond]))
          }else{
            args_no_escritos<-args_no_escritos[1:length(values[!cond])]
              if(length(values[!cond])>0){
                extr<-data.frame(A=args_no_escritos[!cond],B=paste0(args_no_escritos[!cond],"=",values[!cond]))
              }

          }
          if(length(values[!cond])>0){
            we<-rbind(writ,extr)
          }else{we<-writ}

          run<-(rbind(we,pred[!pred[[1]] %in% we[[1]],]))
          levels(run[[1]])<-args
          run<-run[order(run[[1]]),]

          #print(bits)
          run<-(paste0(run[[2]],collapse=";"))
          # cond_eq<-(args_no_escritos == sapply(values2,function(x){x[1]}))


          #reemplazo
          # if(cond_eq){
          #   pred<-pred[!pred[[1]] %in% writ[[1]],]
          # }

          # pred<-pred[!pred[[1]] %in% writ[[1]],]
          # #adición
          # writ<-rbind(writ,pred)
          #
          # if(length(args_tofill)>0 && !args_tofill %in% writ[[1]]){
          #   fill<-data.frame(A=args_tofill,B=paste0(args_tofill,"=",values))
          #   writ<-rbind(writ,fill)
          # }


          #args_predef_inactivos<-args_predef[!args_predef %in% args_no_escritos]
          #args_predef_activos les daremos sus valores

          #incl<-comp_args[names(comp_args) %in% args[args %in% args_no_escritos & args %in% args_predef_activos]]

          #si el valor ya está predefinido incluirlo en valores
          #excepto si ya existe
          #Le pongo el argumento a los que tienen 1 de long
          # if(all(cond)){
          #   run<-paste0(values,collapse = ";")
          # }else{
          #   if(!any(cond)){
          #     run<-paste0(args,"=",values2,collapse = ";")
          #   }else{#Descubrir qué argumentos faltan
          #
          #     # if(!duplicated(c())){
          #     #   vl<-c(paste0(values,collapse = ";"),paste0(args[!cond],"=",values2[!cond],collapse = ";"))
          #     #   run<-paste0(vl,collapse=";")
          #     # }else{
          #       run<-paste0(c(values[cond],paste0(args_no_escritos,"=",values[!cond])),collapse = ";")
          #     # }
          #   }
          # }
          run<-paste0(run,"\n")
          rstudioapi::modifyRange(ctx$selection[[1]]$range,
                                  run)


        }
      }
    }
  }
}
