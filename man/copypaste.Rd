% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/copypaste.R
\name{copypaste}
\alias{copypaste}
\title{A function to import excel files as quickly as possible, the use of Addins is also highly recommended}
\usage{
copypaste(...)
}
\arguments{
\item{...}{extra parameters to be given to read.table function (header = TRUE)}
}
\value{
A data frame object called "new_df" in .GlobalEnv, if the user closes the notepad the data won't be read or after 15 seconds
}
\description{
A function to import excel files as quickly as possible, the use of Addins is also highly recommended
}
\examples{

#Copy (Ctrl+C) a excel/google sheets/ online table such as:
#https://en.wikipedia.org/wiki/Standard_normal_table

#Run
#copypaste()

#Paste (Ctrl+V) int the notepad, save and close your notepad file

#Check your data
#new_df

}
