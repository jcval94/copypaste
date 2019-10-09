**bits<-"rnorm(n=1000,sd=29)"
n=1000;sd=29
**bits<-"rnorm(n=1000,mean=29)"
n=1000;mean=29
**bits<-"rnorm(10)"
n=100;mean=100;sd=100
**bits<-"rnorm(n=10)"
n=100
**bits<-"rnorm(10,mean=2)"
mean=2;n=100;sd=100
**bits<-"rnorm(10,sd=2)"
sd=2;n=100;mean=100
bits<-"rnorm(10,sd=2,100)"-
sd=2;n=100;mean=100
bits<-"rnorm(n=10,2,100)"<
n=100;mean=2;sd=100
bits<-"rnorm(n=10,mean=2,100)"<


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

          fun[2]<-substr(fun[2],1,nchar(fun[2])-1)
          values<-strsplit(fun[2],",")[[1]]
          values2<-strsplit(values,"=")

          len_val<-sapply(values2,length)
          cond<-len_val==2
          args_writ<-sapply(values2,function(x){x[[1]][1]})[cond]
          args_no_listos<-args[!args %in% args_writ]
          args_tofill<-args_no_listos[!args_no_listos %in% args_predef]
          pred<-data.frame(A=args_predef,B=args_n)
          writ<-data.frame(A=args_writ,B=values[cond])

          if(length(args_no_listos)>0){
            writ<-rbind(writ[cond,],data.frame(
              A=args_no_listos,B=paste0(args_no_listos,"=",values[!cond])))
          }
          #reemplazo
          pred<-pred[!pred[[1]] %in% writ[[1]],]
          #adición
          writ<-rbind(writ,pred)

          if(length(args_tofill)>0){
            fill<-data.frame(A=args_tofill,B=paste0(args_tofill,"=",values))
            writ<-rbind(writ,fill)
          }

          print(writ)
          #args_predef_inactivos<-args_predef[!args_predef %in% args_no_listos]
          #args_predef_activos les daremos sus valores

          #incl<-comp_args[names(comp_args) %in% args[args %in% args_no_listos & args %in% args_predef_activos]]

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
          #       run<-paste0(c(values[cond],paste0(args_no_listos,"=",values[!cond])),collapse = ";")
          #     # }
          #   }
          # }
          # run<-paste0(run,"\n")
          # rstudioapi::modifyRange(ctx$selection[[1]]$range,
          #                         run)


        }
      }
    }
  }
}
