ui1 <- function() {
  ui <- page_navbar(
    title = "CRAM whales 2.0",
    theme = bs_theme(bootswatch = "flatly"),
    sidebar = sidebar(
      dateInput(inputId = "date", label = "Date", value = today() - days(2), max = today() - days(2)),
      numericInput(inputId = "n_whales", label = "Show top N downloaders:", 6, min = 1, max = 25, step = 1)
    ),
    nav_panel(title = "All traffic", md1.all_traffic_UI()),
    nav_panel(title = "Biggest whales", md1.biggest_whales_UI()),
    nav_panel(title = "Whales by hour", md1.whales_by_hour_UI()),
    nav_panel(title = "Detail view", md1.detail_view_UI())
  )

  ui
}
