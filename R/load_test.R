load_test_command <- function(url, output_dir, workers = 5, loaded_duration = 2) {
  if (is.integer(url)) url <- paste0("http://127.0.0.1:", url)

  glue::glue("shinycannon recording.log {url} --workers {workers} --loaded-duration-minutes {loaded_duration} --output-dir {output_dir}")
}

analyze_results <- function(run_name = "my_runs") {
  df <- shinyloadtest::load_runs(
    `app1 5 users` = "app1run5",
    `app1 20 users` = "app1run20"
  )
  shinyloadtest::shinyloadtest_report(df, paste0(run_name, ".html"))
}

\() {
  analyze_results()
}
