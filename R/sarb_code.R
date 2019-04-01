#' SARB code
#'
#' @import httr
#' @importFrom jsonlite fromJSON
#' @description Request SARB data using the designated code with format KBPXXXX
#' @examples
#'
#' sarb_code(code = "KBP1434D", token = "your token here")
#'
#' options(sarb.token = "your token here")
#' sarb_code(code = "KBP1434D")
#'
#' Sys.setenv("sarb.token" = "your token here")
#' sarb_code(code = "KBP1434D")
#' @return list
#' @export
#'

sarb_code <- function(code, token = NULL){

  token %||%
    getOption("sarb.token") %||%
    if(Sys.getenv("sarb.token") == "") NULL %||%
    stop("Token not specified")

  res <- GET(
    glue("https://197.85.7.139/sarb?code={code}"),
    authenticate(get("user"), get("passw")),
    add_headers(token = token),
    config(ssl_verifypeer = 0)
  )

  res <- jsonlite::fromJSON(content(res, "text", encoding = "UTF-8"))

  if(res$status_code != 200)
    stop(res)

  res %>%
    tbl_df
}
