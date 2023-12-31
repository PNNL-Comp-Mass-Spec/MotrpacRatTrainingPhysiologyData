% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{MUSCLES_STATS}
\alias{MUSCLES_STATS}
\title{Statistical analysis results of muscle-specific measures}
\format{
An object of class \code{data.frame} with 224 rows and 22 columns:

\describe{
\item{response}{character; the muscle-specific measurement being tested.}
\item{age}{factor; the age of the rat at the beginning of the training
protocol. Levels: "6M" (Adult) and "18M" (Aged).}
\item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
\item{muscle}{factor; the muscle that was sampled with levels "LG" (lateral
gastrocnemius), "MG" (medial gastrocnemius), "PL" (plantaris), and "SOL"
(soleus).}
\item{contrast}{factor; the comparison between groups. All contrasts are
ratios between the trained and SED group means (levels "1W / SED", "2W /
SED", "4W / SED", "8W / SED").}
\item{estimate_type}{character; interpretation of the value in the
\code{estimate} column. All "ratio" (ratio between group means, as
specified by \code{contrast}).}
\item{null}{numeric; the value of the estimate under the null hypothesis.}
\item{estimate}{numeric; ratio between the means of the groups as specified
by \code{contrast}.}
\item{SE}{numeric; the standard error of the estimate.}
\item{lower.CL}{numeric; lower bound of the 95\% confidence interval.}
\item{upper.CL}{numeric; upper bound of the 95\% confidence interval.}
\item{statistic_type}{character; the type of statistical test. All "t"
(Student's t-statistic).}
\item{statistic}{numeric; the value of the test statistic.}
\item{df}{numeric; the number of residual degrees of freedom.}
\item{p.value}{numeric; the p-value associated with the statistical
test.}
\item{p.adj}{numeric; the adjusted p-value.}
\item{signif}{logical; \code{TRUE} if \code{p.adj} < 0.05.}
\item{model_type}{character; the statistical model used for testing. All
"lme" (linear mixed effects model).}
\item{fixed}{character; the fixed-effects component of the model formula.
Describes the response variable (and any transformations) and all predictor
variables that were included. Equivalent to \code{formula}.}
\item{random}{character; the random component of the model formula.
Specifies the random effects for mixed effects models. All "~1 | pid"
(random intercept for each rat).}
\item{weights}{character; if reciprocal group variances were used as
weights to account for heteroscedasticity (nonconstant residual variance),
this is noted here.}
\item{obs_removed}{character; if any observations were omitted during the
analysis, they are listed here.}
}
}
\usage{
MUSCLES_STATS
}
\description{
Statistical analysis results of muscle-specific measures:
terminal muscle mass, mean cross-sectional area (CSA), glycogen, capillary
contacts, and citrate synthase.
}
\examples{
unique(MUSCLES_STATS$response) # available measures

head(MUSCLES_STATS)

}
\seealso{
\code{\link{MUSCLES}}, \code{\link{MUSCLES_EMM}}
}
\keyword{datasets}
