#' compile all libraries in a ".R" file, even if is not installed
#'
#' @return
#' @export
#'
#' @examples
libraries<-function(){
  ctx<-rstudioapi::getActiveDocumentContext()
  if (!is.null(ctx)){

    contenido<-ctx[["contents"]]
    contenido<-contenido[nchar(contenido)!= 0]
    libr<-nchar(contenido)-as.integer(sapply(contenido,function(x)nchar(gsub("library","",x))))
    libs<-contenido[libr!=0]
    libs_2<-contenido[libr>7]
    #Create list of packages
    libs_<-sapply(libs,function(x)(gsub("library[()]","",gsub("[)]","",x))))
    installed<-installed.packages()[,1]
    install_cond<-libs_ %in% installed
    libs_installed<-libs_[install_cond]
    libs_check<-libs_[!install_cond]
  }
}
