#' use_r() creates a new .R file in the R directory and use_rmd() creates a new .Rmd file in the app/data-set-up directory.
#'
#' @param name File name, without extension; will create if it doesn't already
#'   exist. If not specified, and you're currently in a test file, will guess
#'   name based on test name.
#' @seealso [use_test()]
#' @export
use_r <- function(name = NULL) {
  name <- find_r_name(name)

  use_directory("R")
  edit_file(proj_get(), paste0("R/", name))

  invisible(TRUE)
}

check_file_name <- function(name) {
  if (!valid_file_name(name)) {
    stop(
      value(name), " is not a valid file name. It should:\n",
      "* Contain only ASCII letters, numbers, '-', and '_'\n",
      call. = FALSE
    )
  }
}

valid_file_name <- function(x) {
  grepl("^[[:alnum:]_-]+$", x)
}

find_r_name <- function(name = NULL) {
  if (!is.null(name)) {
    check_file_name(name)
    return(slug(name, ".R"))
  }

  if (!rstudioapi::isAvailable()) {
    stop("Argument ", code("name"), " is missing, with no default", call. = FALSE)
  }
  active_file <- rstudioapi::getSourceEditorContext()$path

  dir <- basename(dirname(active_file))
  if (dir != "testthat") {
    stop("Open file not in `tests/testthat/` directory", call. = FALSE)
  }

  if (!grepl("\\.[Rr]$", active_file)) {
    stop("Open file is does not end in `.R`", call. = FALSE)
  }

  gsub("^test-", "", basename(active_file))
}


#' @export
#' @rdname use_r
use_rmd <- function(name = NULL) {
  if (!is.null(name)) {
    check_file_name(name)
    use_directory("app/data-set-up")
    edit_file(proj_get(), paste0("app/data-set-up/", name, '.Rmd'))

  } else {
    stop('invalid names')
  }

  invisible(TRUE)
}
