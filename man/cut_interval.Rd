% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilities-break.r
\name{cut_interval}
\alias{cut_interval}
\alias{cut_number}
\alias{cut_width}
\title{Discretise numeric data into categorical}
\usage{
cut_interval(x, n = NULL, length = NULL, ...)

cut_number(x, n = NULL, ...)

cut_width(x, width, center = NULL, boundary = NULL, closed = "right", ...)
}
\arguments{
\item{x}{numeric vector}

\item{n}{number of intervals to create, OR}

\item{length}{length of each interval}

\item{...}{
  Arguments passed on to \code{\link[base:cut]{base::cut.default}}
  \describe{
    \item{\code{breaks}}{either a numeric vector of two or more unique cut points or a
    single number (greater than or equal to 2) giving the number of
    intervals into which \code{x} is to be cut.}
    \item{\code{labels}}{labels for the levels of the resulting category.  By default,
    labels are constructed using \code{"(a,b]"} interval notation.  If
    \code{labels = FALSE}, simple integer codes are returned instead of
    a factor.}
    \item{\code{right}}{logical, indicating if the intervals should be closed on
    the right (and open on the left) or vice versa.}
    \item{\code{dig.lab}}{integer which is used when labels are not given.  It
    determines the number of digits used in formatting the break numbers.}
    \item{\code{ordered_result}}{logical: should the result be an ordered factor?}
  }}

\item{width}{The bin width.}

\item{center, boundary}{Specify either the position of edge or the center of
a bin. Since all bins are aligned, specifying the position of a single bin
(which doesn't need to be in the range of the data) affects the location of
all bins. If not specified, uses the "tile layers algorithm", and sets
the boundary to half of the binwidth.

To center on integers, \code{width = 1} and \code{center = 0}.
\code{boundary = 0.5}.}

\item{closed}{One of \code{"right"} or \code{"left"} indicating whether right
or left edges of bins are included in the bin.}
}
\description{
\code{cut_interval()} makes \code{n} groups with equal range, \code{cut_number()}
makes \code{n} groups with (approximately) equal numbers of observations;
\code{cut_width()} makes groups of width \code{width}.
}
\examples{
table(cut_interval(1:100, 10))
table(cut_interval(1:100, 11))

set.seed(1)

table(cut_number(runif(1000), 10))

table(cut_width(runif(1000), 0.1))
table(cut_width(runif(1000), 0.1, boundary = 0))
table(cut_width(runif(1000), 0.1, center = 0))
table(cut_width(runif(1000), 0.1, labels = FALSE))
}
\author{
Randall Prium contributed most of the implementation of
\code{cut_width()}.
}
