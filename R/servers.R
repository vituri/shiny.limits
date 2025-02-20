server1 = function(input, output, session) {

  # rc.data: read data ------------------------------------------------------
  rc.data = reactive({
    download_and_read(input$date)
  }) |>
    bindEvent(input$date)


  # Tab 1: All traffic ------------------------------------------------------
  # rc.count: simple counting -----------------------------------------------
  rc.count = reactive({
    df_count = calc_count_downloads(rc.data())
  })

  # rc.whales: separate the whales ------------------------------------------
  rc.whales = reactive({
    df_whales = create_ip_names(rc.count(), input$n_whales)
  }) |>
    bindEvent(input$n_whales, rc.count())

  rc.whales_vs_non_whales_by_hour = reactive({
    whales_vs_non_whales_by_hour =
      calc_whales_vs_non_whales_by_hour(df = rc.data(), whale_ip = rc.whales()$ip_id)
  })

  # rc.valueboxes ------------------------------------------------------------
  rc.valuebox1 = reactive({
    calc_valuebox_size(rc.data())
  })

  rc.valuebox2 = reactive({
    calc_valuebox_rows(rc.data())
  })

  rc.valuebox3 = reactive({
    calc_valuebox_unique_ids(rc.data())
  })

  rc.whale_downloads <- reactive({
    calc_whales_by_hour(rc.data(), rc.whales())
  })


  # Tab 2: Biggest whales ---------------------------------------------------
  # reuse rc.whales


  # Tab 3: Whales by hour ---------------------------------------------------
  # rc.downloads_by_hour_with_names -----------------------------------------
  rc.downloads_by_hour_with_names = reactive({
    calc_whales_by_hour(rc.data(), rc.whales())
  })


  # Tab 4: Detail view ------------------------------------------------------
  # uses rc.data and rc.whales

  # modules -----------------------------------------------------------------
  md1.all_traffic_server(
    rc.valuebox1 = rc.valuebox1, rc.valuebox2 = rc.valuebox2, rc.valuebox3 = rc.valuebox3,
    rc.whales_vs_non_whales_by_hour = rc.whales_vs_non_whales_by_hour
  )

  md1.biggest_whales_server(rc.biggest_whales = rc.whales)
  md1.whales_by_hour_server(rc.downloads_by_hour_with_names = rc.downloads_by_hour_with_names)
  md1.detail_view_server(rc.data = rc.data, rc.whales = rc.whales)
}
