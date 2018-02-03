context("use_r")

test_that("use_r() creates a .R file below R/", {
  pkg <- scoped_temporary_package()
  capture_output(use_r("foo"))
  expect_true(file.exists(proj_path("R/foo.R")))
})


test_that("use_rmd() creates a .Rmd file below app/data-set-up/", {
  pkg <- scoped_temporary_package()
  capture_output(use_rmd("foo"))
  expect_true(file.exists(proj_path("app/data-set-up/foo.Rmd")))
})
