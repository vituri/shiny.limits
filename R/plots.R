test_plot = function() {
  ggplot(mpg, aes(class)) + geom_bar()
}

my_gg_theme = function() {
  theme_minimal()
}

plot_whales_by_hour = function(downloads_by_hour) {
  downloads_by_hour |>
    ggplot(aes(hour, downloads, fill = is_whale)) +
    geom_bar(stat = "identity") +
    scale_fill_manual(values = c("#666666", "#88FF99"),
                      labels = c("no", "yes")) +
    ylab("Downloads") +
    xlab("Hour") +
    scale_y_continuous(labels = scales::comma) +
    my_gg_theme()
}

plot_biggest_whales = function(biggest_whales) {
  biggest_whales |>
    ggplot(aes(ip_name, downloads)) +
    geom_bar(stat = "identity") +
    ylab("Downloads on this day") +
    my_gg_theme()
}

plot_downloads_by_hour_whales = function(downloads_by_hour_with_names) {
  downloads_by_hour_with_names |>
    ggplot(aes(hour, downloads)) +
    geom_bar(stat = "identity") +
    facet_wrap(~ip_name) +
    ylab("Downloads") +
    xlab("Hour") +
    my_gg_theme()
}

