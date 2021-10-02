#' Token Request
#'
#' @description Request a token from the server to use the api service
#' @examples
#'\dontrun{
#' token <- token_request()
#' print(token)
#'}
#' @return list
#' @export
#' @import httr
#' @importFrom jsonlite fromJSON
#'

token_request <- function(){

  res <- GET(
    "sarbr.daeconomist.com/v1/token_pls",
    add_headers(token = "token_request")
  )

  if(class(res) != "response")
    stop(res)

  res <- fromJSON(content(res, "text", encoding = "UTF-8"))
  message(res$msg)

  return(res)
}
