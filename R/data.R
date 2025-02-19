format_number = function(x) {
  format(x, big.mark = ".")
}

file_path = function(date) {
  path <- file.path("data_cache", paste0(date, ".csv.gz"))

  path
}

download_data = function(date = today() - days(2)) {
  year = year(date)

  url = glue::glue("http://cran-logs.rstudio.com/{year}/{date}.csv.gz")
  path <- file_path(date)

  # download only if file does not exist
  if (!file.exists(path)) download.file(url = url, destfile = path)

  NULL
}

read_data = function(date = today() - days(2)) {
  path <- file_path(date)

  df =
    readr::read_csv(path, col_types = "Dti---f-fi", progress = FALSE) |>
    filter(!is.na(package)) |>
    mutate(hour = hms::trunc_hms(time, 60*60))

  df
}

download_and_read = function(date = today() - days(2)) {
  download_data(date)
  read_data(date)
}

create_dir_and_delete_files = function() {
  dir.create(path = 'data_cache', showWarnings = FALSE)
  unlink(x = list.files(path = 'data_cache', full.names = TRUE))
}

create_ip_names = function(df_count, n_whales) {
  df_count |>
    slice_head(n = n_whales) |>
    mutate(ip_name = paste0("WHALE_", row_number(), " [", country, "]"))
}

calc_downloads_by_hour = function(df, whale_ip) {
  downloads_by_hour =
    df |>
    mutate(
      is_whale = ip_id %in% whale_ip
    ) |>
    count(hour, is_whale, name = 'downloads')

  downloads_by_hour
}

calc_downloads_by_hour_with_names = function(df, df_whales) {
  downloads_by_hour_with_names =
    df |>
    inner_join(df_whales, by = 'ip_id') |>
    count(hour, ip_name, name = 'downloads')

  downloads_by_hour_with_names
}

\() {
  create_dir_and_delete_files()
  download_data()
  df = read_data()
}
