# read data ---------------------------------------------------------------
create_dir_and_delete_files = function() {
  dir.create(path = 'data_cache', showWarnings = FALSE)
  unlink(x = list.files(path = 'data_cache', full.names = TRUE))
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

# tab 1: all traffic -----------------------------------------------------------
calc_valuebox_size = function(df) {
  df$size |>
    as.numeric() |>
    sum() |>
    gdata::humanReadable()
}

calc_valuebox_rows = function(df) {
  df |> nrow() |> format_number()
}

calc_valuebox_unique_ids = function(df) {
  df$ip_id |> unique() |> length() |> format_number()
}

calc_count_downloads = function(df) {
  df |>
    count(ip_id, country, name = 'downloads') |>
    arrange(desc(downloads))
}

calc_whales_vs_non_whales_by_hour = function(df, whale_ip) {
  whales_vs_non_whales_by_hour =
    df |>
    mutate(
      is_whale = ip_id %in% whale_ip
    ) |>
    count(hour, is_whale, name = 'downloads')

  whales_vs_non_whales_by_hour
}

# tab 2: biggest whales ------------------------------------------------------------------
create_ip_names = function(df_count, n_whales) {
  df_count |>
    slice_head(n = n_whales) |>
    mutate(ip_name = paste0("WHALE_", formatC(x = row_number(), width = 2, flag = '0'), " [", country, "]"))
}

# tab 3: whales by hour ----------------------------------------------------------
calc_whales_by_hour = function(df, df_whales) {
  whales_by_hour =
    df |>
    inner_join(df_whales, by = 'ip_id') |>
    count(hour, ip_name, name = 'downloads')

  whales_by_hour
}


# tab 4: detail view ----------------------------------------------------------
calc_valuebox_unique_packages = function(df) {
  df$package |> unique() |> length() |> format_number()
}


\() {
  create_dir_and_delete_files()
  download_data()
  df = read_data()
}
