#' Release Information
#'
#' @description Returns the latest release date of the data
#' @param dateformat return latest release information as date object
#' @examples
#'\dontrun{
#' release_info(dateformat = FALSE)
#' release_info(dateformat = TRUE)
#'}
#' @return list
#' @export
#' @import httr
#' @importFrom jsonlite fromJSON
#'

release_info <- function(dateformat = FALSE, token = NULL){

  token <- token %||%
    getOption("sarb.token") %||%
    ifelse(Sys.getenv("sarb.token") != "", Sys.getenv("sarb.token"), NULL) %||%
    stop("Token not specified")

  res <- GET(
    "sarbr.daeconomist.com/v1/releaseinfo",
    add_headers(token = token)
  )

  if(res$status_code != 200)
    stop(content(res))

  res <- jsonlite::fromJSON(content(res, "text", encoding = "UTF-8"))

  if(dateformat){
    res <- as.Date(gsub("Latest release info: ", '', res))
  }

  return(res)
}
