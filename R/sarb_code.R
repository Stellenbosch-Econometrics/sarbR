#' SARB code
#'
#' @import httr
#' @importFrom jsonlite fromJSON
#' @importFrom rlang `%||%`
#' @description Request SARB data using the designated code with format KBPXXXX
#' @examples
#'
#' token <- token_request()
#' print(token)
#' @return list
#' @export
#'

sarb_code <- function(code, token = NULL){

  token %||%
    getOption("sarb.token") %||%
    Sys.getenv("sarb.token") %||%
    stop("Token not specified")

  xxx <- GET(
    glue("http://197.85.7.139:4500/sarb?code={code}"),
    add_headers(token = "cb9466d5305a0db2e7171cd9f83e")
  )
  res_x <- jsonlite::fromJSON(content(xxx, "text", encoding = "UTF-8"))

  if(xxx$status_code != 200)
    stop(res_x)

  res_x %>%
    tbl_df
}
