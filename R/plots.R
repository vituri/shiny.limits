test_plot <- function() {
  ggplot(mpg, aes(class)) +
    geom_bar()
}

my_gg_theme <- function() {
  theme_minimal()
}

# tab 1: all traffic -------------------------------------------------------------
plot_whales_vs_non_whales_by_hour <- function(whales_vs_non_whales_by_hour) {
  whales_vs_non_whales_by_hour |>
    ggplot(aes(hour, downloads, fill = is_whale)) +
    geom_bar(stat = "identity") +
    scale_fill_manual(
      values = c("#666666", "#88FF99"),
      labels = c("no", "yes")
    ) +
    ylab("Downloads") +
    xlab("Hour") +
    scale_y_continuous(labels = scales::comma) +
    my_gg_theme()
}

# tab 2: biggest whales ------------------------------------------------------------------
plot_biggest_whales <- function(biggest_whales) {
  biggest_whales |>
    ggplot(aes(ip_name, downloads)) +
    geom_bar(stat = "identity") +
    ylab("Downloads on this day") +
    my_gg_theme()
}

# tab 3: whales by hour ----------------------------------------------------------
plot_downloads_by_hour_whales <- function(downloads_by_hour_with_names) {
  downloads_by_hour_with_names |>
    ggplot(aes(hour, downloads)) +
    geom_bar(stat = "identity") +
    facet_wrap(~ip_name) +
    ylab("Downloads") +
    xlab("Hour") +
    my_gg_theme()
}

# tab 4: detail view ----------------------------------------------------------
plot_whale_data <- function(whale_data) {
  pkg <- levels(whale_data$package)
  breaks <- pkg[seq(from = 1, to = length(pkg), length.out = 50) %>%
    as.integer() %>%
    c(1, length(pkg)) %>%
    unique()]

  whale_data |>
    ggplot(aes(time, package)) +
    geom_point() +
    scale_x_time(
      breaks = seq(hms::hms(0, 0, 0), by = 60 * 60 * 3, length.out = 9),
      limits = c(hms::hms(0, 0, 0), hms::hms(0, 0, 24))
    ) +
    scale_y_discrete(breaks = breaks)
}
