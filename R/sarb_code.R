#' SARB code
#'
#' @import httr
#' @importFrom jsonlite fromJSON
#' @importFrom glue glue
#' @description Request SARB data using the designated code with format KBPXXXX. This function is the worker function of the `sarbR` package and is used to interact with an API linked to the main dataabse
#' @examples
#'
#' sarb_code(code = "KBP1434D", token = "f84d879ce6537dbacd93ac3dc073e364")
#'
#' options(sarb.token = "f84d879ce6537dbacd93ac3dc073e364")
#' sarb_code(code = "KBP1434D")
#'
#' Sys.setenv("sarb.token" = "f84d879ce6537dbacd93ac3dc073e364")
#' sarb_code(code = "KBP1434D")
#' @return list
#' @export
#'

sarb_code <- function(code, token = NULL){

  token <- token %||%
    getOption("sarb.token") %||%
    if(Sys.getenv("sarb.token") == "") NULL %||%
    stop("Token not specified")

  res <- GET(
    glue("api.daeconomist.com/service/sarbr/sarb?code={code}"),
    authenticate(get("user"), get("passw")),
    add_headers(token = token),
    config(ssl_verifypeer = 0)
  )

  if(res$status_code != 200)
    stop(content(res))

  res <- jsonlite::fromJSON(content(res, "text", encoding = "UTF-8"))


  res %>%
    tbl_df
}
