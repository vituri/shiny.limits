# app1 --------------------------------------------------------------------
md1.all_traffic_UI <- function(id = 'all_traffic') {
  ns <- NS(id)
  page_fillable(
    layout_column_wrap(
      width = 1/3,
      value_box(title = "Bandwidth consumed", value = textOutput(outputId = ns("value_box1")), showcase = bs_icon('database')),
      value_box(title = "Files downloaded", value = textOutput(outputId = ns("value_box2")), showcase = bs_icon('file-arrow-down')),
      value_box(title = "Unique downloaders", value = textOutput(outputId = ns("value_box3")), showcase = bs_icon('person')),
      max_height = '120px'
    ),
    card(
      card_header("Downloads by hour"),
      plotOutput(outputId = ns("plot"))
    )
  )
}

md1.all_traffic_server <- function(id = 'all_traffic', rc.valuebox1, rc.valuebox2, rc.valuebox3, rc.downloads_by_hour) {
  moduleServer(
    id,
    function(input, output, session) {
      output$value_box1 = renderText({
        rc.valuebox1()
      })

      output$value_box2 = renderText({
        rc.valuebox2()
      })

      output$value_box3 = renderText({
        rc.valuebox3()
      })

      output$plot = renderPlot({
        downloads_by_hour = rc.downloads_by_hour()
        req(downloads_by_hour)

        plot_whales_by_hour(downloads_by_hour)
      })
    }
  )
}


md1.biggest_whales_UI <- function(id = 'biggest_whales') {
  ns <- NS(id)
  page_fillable(
    plotOutput(outputId = ns('plot'))
  )
}

md1.biggest_whales_server <- function(id = 'biggest_whales', rc.biggest_whales) {
  moduleServer(
    id,
    function(input, output, session) {
      output$plot = renderPlot({
        biggest_whales = rc.biggest_whales()

        plot_biggest_whales(biggest_whales)
      })
    }
  )
}


md1.whales_by_hour_UI <- function(id = 'whales_by_hour') {
  ns <- NS(id)
  page_fillable(
    plotOutput(outputId = ns('plot'))
  )
}

md1.whales_by_hour_server <- function(id = 'whales_by_hour', rc.downloads_by_hour_with_names) {
  moduleServer(
    id,
    function(input, output, session) {
      output$plot = renderPlot({
        rc.downloads_by_hour_with_names() |>
          plot_downloads_by_hour_whales()
      })
    }
  )
}



md1.detail_view_UI <- function(id = 'detail_view') {
  ns <- NS(id)
  page_fillable(
    selectInput(inputId = ns('downloader_name'), label = 'Downloader name', choices = letters[1:5], selected = letters[1]),
    plotOutput(outputId = ns('plot'))
  )
}

md1.detail_view_server <- function(id = 'detail_view') {
  moduleServer(
    id,
    function(input, output, session) {
      output$plot = renderPlot({
        test_plot()
      })
    }
  )
}
