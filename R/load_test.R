load_test_command <- function(url, output_dir, workers = 5, loaded_duration = 5, log_file = 'recording.log') {
  if (is.integer(url)) url <- paste0("http://127.0.0.1:", url)

  glue::glue("shinycannon {log_file} {url} --workers {workers} --loaded-duration-minutes {loaded_duration} --output-dir {output_dir} --overwrite-output")
}

record_test = function(port = 8001) {
  shinyloadtest::record_session(glue::glue("http://127.0.0.1:{port}"), output_file = "app1")
}

analyze_results <- function(run_name = "my_runs") {
  df <- shinyloadtest::load_runs(
    `app1 5 users` = "run_app1w5"
    # ,`app1 20 users` = "app1run20"
  )
  shinyloadtest::shinyloadtest_report(df, paste0(run_name, ".html"))
}

