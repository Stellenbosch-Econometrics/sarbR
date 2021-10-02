#' All SARB available codes
#'
#' @description Returns all available codes in the DB
#' @examples
#'\dontrun{
#' all_codes()
#'}
#' @return list
#' @export
#' @import httr
#' @importFrom jsonlite fromJSON
#'

all_codes <- function(dateformat = FALSE, token = NULL){

  token <- token %||%
    getOption("sarb.token") %||%
    ifelse(Sys.getenv("sarb.token") != "", Sys.getenv("sarb.token"), NULL) %||%
    stop("Token not specified")

  res <- GET(
    "sarbr.daeconomist.com/v1/all_codes",
    add_headers(token = token)
  )

  if(res$status_code != 200)
    stop(content(res))

  res <- jsonlite::fromJSON(content(res, "text", encoding = "UTF-8"))

  res %>%
    as_tibble()
}
