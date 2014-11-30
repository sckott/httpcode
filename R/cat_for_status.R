#' Use cat pictures for various HTTP status codes
#'
#' @export
#' @name cat_for_status
#' @param code An http status code
#' @examples \donttest{
#' cat_for_status(100)
#' dog_for_status(100)
#' cat_for_status(301)
#' dog_for_status(301)
#' cat_for_status(400)
#' dog_for_status(400)
#' # not found
#' cat_for_status(555)
#' }
cat_for_status <- function(code){
  code <- as.character(code)
  if(code %in% names(status_codes)){
    url <- sprintf('http://httpcats.herokuapp.com/%s', code)
    browseURL(url)
  } else { stopcode("No cat code found", "") }
}

#' @export
#' @rdname cat_for_status
dog_for_status <- function(code){
  code <- as.character(code)
  if(code %in% names(status_codes)){
    url <- sprintf('http://httpstatusdogs.com/wp-content/uploads/%s.jpg', code)
    browseURL(url)
  } else { stopcode("No dog code found", "") }
}
