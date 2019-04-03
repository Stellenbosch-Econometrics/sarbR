#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

#' Pipe OR operator
#' @name %||%
#' @export
#' @rdname pipe_or
#' @keywords internal
`%||%` <- function (x, y)
{
  if (is.null(x))
    y
  else x
}
