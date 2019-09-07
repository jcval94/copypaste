#' A function to import excel files as quickly as possible, the use of Addins is also highly recommended
#'
#' @param header parameter to be given to read.table function
#' @param ... extra parameters to be given to read.table function
#'
#' @return A data frame object called "new_df" in .GlobalEnv, if the user closes the notepad the data won't be read or after 15 seconds
#' @export
#'
#' @importFrom utils read.table
#' @importFrom rstudioapi getActiveDocumentContext
#'
#'
#'
#' @examples
#'
#' #Copy (Ctrl+C) an/a excel/google sheets table
#'
#'
#' #Run
#' #copypaste()
#'
#' #Paste (Ctrl+V) int the notepad, save and close your notepad file
#'
#' #Check your data
#' #new_df
#'
copypaste<-function(header=TRUE,...){
  ctx<-rstudioapi::getActiveDocumentContext()
  if (!is.null(ctx)){
    base::writeLines("","Paste.txt")
    file.show('Paste.txt')
    open1<-open<-file.info("Paste.txt")$mtime
    time<-0
    while(open1==open & time < 60){
      Sys.sleep(1/4)
      open<-file.info("Paste.txt")$mtime
      time<-time+1
    }
    assign_to_global <- function(pos=1,header,...){
      assign("new_df", utils::read.table(file = "Paste.txt",sep="\t",header = header,...), envir=as.environment(pos) )
    }
    suppressWarnings(try(expr = assign_to_global()
                         ,silent = TRUE))
    unlink('Paste.txt')
  }
}
