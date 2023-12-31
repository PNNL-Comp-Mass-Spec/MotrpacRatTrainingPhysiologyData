% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fiber_donut_chart.R
\name{fiber_donut_chart}
\alias{fiber_donut_chart}
\title{Muscle fiber percentage donut charts}
\usage{
fiber_donut_chart(x)
}
\arguments{
\item{x}{a \code{data.frame} with columns \code{"group"} ("SED", "8W"),
\code{"type"} ("I", "IIa", "IIx", "IIb"), and \code{"fiber_count"}
(numeric).}
}
\value{
A \code{ggplot2} object.
}
\description{
Donut charts of mean fiber type percentages.
}
\details{
Fiber counts are summed across the biological replicates for each
combination of group (SED, 8W) and fiber type (I, IIa, IIx, IIb). Then,
each of these summed counts are divided by the total fiber count for that
group and multiplied by 100 to obtain percentages.
}
