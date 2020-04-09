msg_format <-
  "<Status code: %s>
  Message: %s
  Explanation: %s,
  Verbose Explanation: %s"

msg_list <- function(a, b, c, d){
  comp(list(
    status_code = a,
    message = b,
    explanation = c,
    verbose_explanation = d
  ))
}

is_three_digit_code <- function(x) grepl("\\d{3}", x)

nozero <- function(x) names(x[sapply(x, length) > 0])

stopcode <- function(x, y) stop(sprintf('%s: %s\n', x, y), call. = FALSE)

`%||%` <- function(x, y) if (is.null(x)) y else x

comp <- function(l) Filter(Negate(is.null), l)

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}
