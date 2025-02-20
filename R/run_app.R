run_app1 <- function(delete_files = FALSE) {
  if (delete_files) create_dir_and_delete_files()

  runApp(shinyApp(ui1(), server1), port = 8001)
}


run_app2 <- function(delete_files = FALSE) {
  if (delete_files) create_dir_and_delete_files()

  runApp(shinyApp(ui1(), server2), port = 8002)
}
