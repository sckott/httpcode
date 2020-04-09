#' Find out about http status codes
#'
#' @name http
#' @param code (character) An http status code, or a regex search for HTTP
#' status codes.
#' @param text (character) A text string to search the messages or descriptions
#' of HTTP status codes.
#' @param verbose (logical) include verbose status code explanation.
#' Default: `FALSE`
#'
#' @return on S3 object of class `http_code`, that is inside a list
#' of the form:
#' 
#' - status_code - the status code
#' - message - very brief message explaining the code
#' - explanation - more verbose explanation, but still short
#' - explanation_verbose - the complete explanation
#'
#' @examples
#' # search by code
#' http_code(100)
#' http_code(400)
#' http_code(503)
#' ## verbose explanation
#' http_code(100, verbose = TRUE)
#' http_code(400, verbose = TRUE)
#' http_code(503, verbose = TRUE)
#'
#' # fuzzy code search
#' http_code('1xx')
#' http_code('3xx')
#' http_code('30[12]')
#' http_code('30[34]')
#' http_code('30[34]')
#' ## verbose explanation
#' http_code('1xx', verbose = TRUE)
#' http_code('3xx', verbose = TRUE)
#'
#' # search by text message
#' http_search("request")
#' http_search("forbidden")
#' http_search("too")
#' ## verbose explanation
#' http_search("request", verbose = TRUE)
#'
#' @examples \dontrun{
#' http_search("birds")
#' http_code(999)
#' }

#' @export
#' @rdname http
http_code <- function(code = NULL, verbose = FALSE) {
  code <- as.character(code)
  if (is.null(code)) {
    print_codes()
  } else {
    if (is_three_digit_code(code)) {
      print_code(code, verbose)
    } else {
      print_filtered_codes(code, verbose)
    }
  }
}

#' @export
#' @rdname http
http_search <- function(text = NULL, verbose = FALSE) print_search(text, verbose)


# helpers -------------------------------
print_filtered_codes <- function(code, verbose){
  code2 <- paste0(gsub("x", "\\\\d", code), "$")
  found_codes <- nozero(sapply(names(status_codes), function(x) grep(code2, x, value = TRUE)))
  if (length(found_codes) == 0) stopcode('No code found corresponding to', code)
  print_codes(found_codes, verbose)
}

print_codes <- function(codes = names(status_codes), verbose) {
  lapply(sort(codes), print_code, verbose = verbose)
}

print_code <- function(code, verbose) {
  twocodes <- status_codes[code]
  if (length(twocodes[[1]]) != 3) stopcode('No description found for code', code)
  structure(
    msg_list(
      code,
      twocodes[[1]][[1]],
      twocodes[[1]][[2]],
      if (verbose) twocodes[[1]][[3]] else NULL
    ),
    class = "http_code"
  )
}

#' @export
print.http_code <- function(x, ...){
  cat(sprintf("<Status code: %s>", x$status_code), sep = "\n")
  cat(sprintf("  Message: %s", x$message), sep = "\n")
  cat(sprintf("  Explanation: %s", x$explanation), sep = "\n")
  if (!is.null(x$verbose_explanation)) {
    cat(
      strwrap(
        sprintf("  Verbose Explanation: %s", x$verbose_explanation),
        getOption("width"),
        indent = 2,
        exdent = 4
      ),
      sep = "\n"
    )
  }
}

print_search <- function(text, verbose) {
  found_codes <- vapply(status_codes, function(x){
    any(vapply(x, function(y) grepl(text, y %||% "", ignore.case = TRUE), logical(1)))
  }, logical(1))
  if (any(found_codes)) {
    print_codes(names(status_codes[found_codes]), verbose)
  } else {
    stopcode('No status code found for search', text)
  }
}
