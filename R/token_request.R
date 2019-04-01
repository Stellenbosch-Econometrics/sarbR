#' Token Request
#'
#' @import httr
#' @import jsonlite
#' @description Request a token from the server to use the api service
#' @examples
#'
#' token <- token_request()
#' print(token)
#' @return list
#' @export
#'

token_request <- function(){
  x <- GET(
    "http://197.85.7.139:4500/token_pls",
    add_headers(token = "token_request")
  )
  x <- jsonlite::fromJSON(content(x, "text", encoding = "UTF-8"))
  message(x$msg)

  return(x)
}
