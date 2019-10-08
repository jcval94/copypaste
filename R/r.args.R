#' Title
#'
#' @return
#' @export
#'
#' @examples
r.args<-function(){
  ctx <- rstudioapi::getActiveDocumentContext()
  if (!is.null(ctx)) {
    if (ctx$selection[[1]]$text != "") {

      bits <- utils::read.csv(text = ctx$selection[[1]]$text,
                               stringsAsFactors = FALSE, header = FALSE)
      bits <- unlist(bits, use.names = FALSE)
      #REMOVE PARENTHESIS
      fun<-strsplit(bits,split = "[(]")[[1]]
      EVALU<-text_eval(fun[1])
      if(is.function(EVALU)){
        args<-formalArgs(EVALU)
        args<-args[args != "..."]
        if(!is.null(args)){
          fun[2]<-substr(fun[2],1,nchar(fun[2])-1)
          values<-strsplit(fun[2],",")[[1]]
          values2<-strsplit(values,"=")
          len_val<-sapply(values2,length)
          cond<-len_val==2
          #Le pongo el argumento a los que tienen 1 de long
          if(all(cond)){
            run<-paste0(values,collapse = ";")
          }else{
            if(!any(cond)){
              run<-paste0(args,"=",values2,collapse = ";")
            }else{#Descubrir qué argumentos faltan
              vl<-c(paste0(values,collapse = ";"),paste0(args[!cond],"=",values2[!cond],collapse = ";"))
              run=paste0(vl,collapse=";")
            }
          }
          run<-paste0(run,"\n")
          rstudioapi::modifyRange(ctx$selection[[1]]$range,
                                  run)


        }
      }
    }
  }
}
