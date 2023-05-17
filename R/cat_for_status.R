#' Use cat or dog or goat pictures for various HTTP status codes
#'
#' @export
#' @name cat_for_status
#'
#' @param code An http status code
#' @param browse (logical) If `TRUE`, opens image in default browser. If
#' `FALSE`, returns the URL of the image.
#' @details uses a service for cats (https://http.cat) and
#' dogs (https://http.dog) and goats (https://httpgoats.com)
#' @return Opens image in your default browser, or returns URL
#' @examples \dontrun{
#' # give back url
#' cat_for_status(100)
#' dog_for_status(100)
#' goat_for_status(100)
#' cat_for_status(301)
#' dog_for_status(301)
#' goat_for_status(301)
#' cat_for_status(400)
#' dog_for_status(400)
#' goat_for_status(400)
#'
#' # open image in default browser
#' cat_for_status(400, browse=TRUE)
#'
#' # not found
#' # cat_for_status(555)
#' }
cat_for_status <- function(code, browse = FALSE) {
  assert(code, c("numeric", "integer", "character"))
  stopifnot(length(code) == 1)
  assert(browse, "logical")
  code <- as.character(code)
  if (code %in% names(status_codes)) {
    url <- sprintf('https://http.cat/%s', code)
    if (browse) utils::browseURL(url) else url
  } else {
    stopcode("No cat code found", code)
  }
}

#' @export
#' @rdname cat_for_status
dog_for_status <- function(code, browse = FALSE) {
  assert(code, c("numeric", "integer", "character"))
  stopifnot(length(code) == 1)
  assert(browse, "logical")
  code <- as.character(code)
  if (code %in% names(status_codes)) {
    url <- sprintf('https://http.dog/%s.jpg', code)
    if (browse) utils::browseURL(url) else url
  } else {
    stopcode("No dog code found", code)
  }
}

#' @export
#' @rdname cat_for_status
goat_for_status <- function(code, browse = FALSE) {
  assert(code, c("numeric", "integer", "character"))
  stopifnot(length(code) == 1)
  assert(browse, "logical")
  code <- as.character(code)
  if (code %in% names(status_codes)) {
    url <- sprintf('https://httpgoats.com/%s.jpg', code)
    if (browse) utils::browseURL(url) else url
  } else {
    stopcode("No goat code found", code)
  }
}
