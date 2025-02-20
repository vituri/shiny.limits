format_number <- function(x) {
  format(x, big.mark = ".", decimal.mark = ",")
}

app_start_date <- function() {
  lubridate::today() - days(2)
}

my_bs_theme <- function() {
  bs_theme(bootswatch = "flatly")
}
