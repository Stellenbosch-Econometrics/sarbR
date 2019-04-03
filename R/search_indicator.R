#' Seach Indicator
#'
#' @import dplyr
#' @description A function that searches all available indicators based on description input or code. If both are given then parameter code will take preference
#' @param description description of indicator to look up
#' @param code code of indicator to look up
#' @examples
#'
#' search_indicator(description = "GDP")
#' search_indicator(time_series_code = "KBP1000")
#' @return data.frame
#' @export
#'

search_indicator <- function(description, time_series_code){

  data("indicator_codes", envir=environment())
  if(!missing(time_series_code)){

    if(!is.character(time_series_code)) stop("Please provide code as a character")

    ind <- indicator_codes %>%
      filter(time_series == time_series_code) %>%
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


