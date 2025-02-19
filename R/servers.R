server1 = function(input, output, session) {

  # rc.data: read data ------------------------------------------------------
  rc.data = reactive({
    df = download_and_read(input$date)

    df
  }) |>
    bindEvent(input$date)

  # rc.count: simple counting -----------------------------------------------
  rc.count = reactive({
    df = rc.data()
    req(df)

    df_count =
      df |>
      count(ip_id, country, name = 'downloads') |>
      arrange(desc(downloads))

    df_count
  })

  # rc.whales: separate the whales ------------------------------------------
  rc.whales = reactive({
    df_count = rc.count()
    req(df_count)
    n_whales = input$n_whales

    df_whales =
      df_count |>
      create_ip_names(n_whales)

    df_whales
  }) |>
    bindEvent(input$n_whales, rc.count())

  rc.downloads_by_hour = reactive({
    df_whales = rc.whales()
    whale_ip <- df_whales$ip_id

    df = rc.data()

    downloads_by_hour = calc_downloads_by_hour(df = df, whale_ip = whale_ip)

    downloads_by_hour
  })

  # rc.valueboxes ------------------------------------------------------------
  rc.valuebox1 = reactive({
    rc.data()$size |>
      as.numeric() |>
      sum() |>
      gdata::humanReadable()
  })

  rc.valuebox2 = reactive({
    rc.data() |> nrow() |> format_number()
  })

  rc.valuebox3 = reactive({
    rc.data()$ip_id |> unique() |> length() |> format_number()
  })

  rc.whale_downloads <- reactive({
    rc.downloads_by_hour() |>
      inner_join(rc.whales(), "ip_id") %>%
      select(-downloads)
  })

# rc.downloads_by_hour_with_names -----------------------------------------
  rc.downloads_by_hour_with_names = reactive({
    df_whales = rc.whales()
    df = rc.data()

    downloads_by_hour_name = calc_downloads_by_hour_with_names(df = df, df_whales = df_whales)

    downloads_by_hour_name
  })



  # modules -----------------------------------------------------------------
  md1.all_traffic_server(
    rc.valuebox1 = rc.valuebox1, rc.valuebox2 = rc.valuebox2, rc.valuebox3 = rc.valuebox3,
    rc.downloads_by_hour = rc.downloads_by_hour
  )

  md1.biggest_whales_server(rc.biggest_whales = rc.whales)
  md1.whales_by_hour_server(rc.downloads_by_hour_with_names = rc.downloads_by_hour_with_names)
  md1.detail_view_server()
}
