#' A function to import excel files as quickly as possible, the use of Addins is also highly recommended
#'
#' @param header parameter to be given to read.table function
#'
#' @return A data frame object called "new_df" in .GlobalEnv, if the user closes the notepad the data won't be read or after 15 seconds
#' @export
#'
#' @examples
#'
#' #Copy an/a excel/google sheets table
#'
#' #Run
#' #copypaste()
#'
#' #Save and close your notepad file
#'
#' #Check your data
#' #new_df
#'
copypaste<-function(header=TRUE,...){
  base::writeLines("","Paste.txt")
  file.show('Paste.txt')
  open1<-open<-file.info("Paste.txt")$mtime
  time<-0
  while(open1==open | time < 60){
    Sys.sleep(1/4)
    open<-file.info("Paste.txt")$mtime
    time<-time+1
  }
  suppressWarnings(try(assign("new_df",read.table("Paste.txt",sep="\t",header = header,...),.GlobalEnv)
                       ,silent = TRUE))
  unlink('Paste.txt')
}
