% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{MUSCLES_STATS}
\alias{MUSCLES_STATS}
\title{Statistical analysis results of muscle-specific measures}
\format{
An object of class \code{tbl_df} (inherits from \code{tbl}, \code{data.frame}) with 224 rows and 19 columns.
}
\usage{
MUSCLES_STATS
}
\description{
A \code{data.frame} containing statistical analysis results of
  muscle-specific measures: terminal muscle mass, mean cross-sectional area
  (CSA), glycogen, capillary contacts, and citrate synthase.
}
\examples{
unique(MUSCLES_STATS$response)

print.data.frame(head(MUSCLES_STATS))

}
\seealso{
\code{\link{MUSCLES}}, \code{\link{MUSCLES_EMM}}
}
\keyword{datasets}