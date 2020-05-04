#' Seach Indicator
#'
#' @description A function that searches all available indicators based on description input or code. If both are given then parameter code will take preference
#' @param description description of indicator to look up
#' @param time_series time series to look for
#' @param code code of indicator to return meta data from
#' @examples
#'
#' search_indicator(description = "GDP")
#' search_indicator(time_series = "KBP1000")
#' search_indicator(code = "KBP1000J")
#' @return data.frame
#' @export
#' @importFrom dplyr filter tbl_df
#'

search_indicator <- function(description, time_series, code = NULL){

  data("indicator_codes", envir=environment())

  if(!is.null(code))
  {
    stopifnot(is.character(code))

    ind <- indicator_codes %>%
      filter(code == !!code) %>%
      tbl_df

    return(ind)

  }

  if(!missing(time_series)){

    if(!is.character(time_series)) stop("Please provide code as a character")

    ind <- indicator_codes %>%
      filter(time_series == !!time_series) %>%
      tbl_df
    return(ind)
  } else if(!missing(description)){

    if(!is.character(description)) stop("Please provide description as a character")

    indicator_codes %>%
      filter(grepl(description, description_and_version)) %>%
      tbl_df
  } else {
    stop("Neither description or code was provided. Please provide valid input, or refer to documentation for examples")
  }
}


