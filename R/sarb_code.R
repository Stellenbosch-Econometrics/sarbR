#' SARB code
#'
#' @import httr
#' @importFrom jsonlite fromJSON
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
    if(Sys.getenv("sarb.token") == "") NULL %||%
    stop("Token not specified")

  res <- GET(
    glue("http://197.85.7.139:4500/sarb?code={code}"),
    add_headers(token = token)
  )
  res <- jsonlite::fromJSON(content(res, "text", encoding = "UTF-8"))

  if(res$status_code != 200)
    stop(res)

  res %>%
    tbl_df
}
