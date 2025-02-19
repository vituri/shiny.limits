# app1 --------------------------------------------------------------------
md1.all_trafic_UI <- function(id = 'all_trafic') {
  ns <- NS(id)
  page_fillable(
    layout_column_wrap(
      width = 1/3,
      value_box(title = "bandwidth consumed", value = textOutput(outputId = ns("value_box1"))),
      value_box(title = "files downloaded", value = textOutput(outputId = ns("value_box2"))),
      value_box(title = "unique downloaders", value = textOutput(outputId = ns("value_box3"))),
    ),
    card(
      card_header("Downloads by hour"),
      plotOutput(outputId = ns("plot"))
    )
  )
}

md1.all_trafic_server <- function(id = 'all_trafic') {
  moduleServer(
    id,
    function(input, output, session) {
      output$value_box1 = renderText({
        "1"
      })

      output$value_box1 = renderText({
        "2"
      })

      output$value_box1 = renderText({
        "3"
      })

      output$plot = renderPlot({
        test_plot()
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

md1.biggest_whales_server <- function(id = 'biggest_whales') {
  moduleServer(
    id,
    function(input, output, session) {
      output$plot = renderPlot({
        test_plot()
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

md1.whales_by_hour_server <- function(id = 'whales_by_hour') {
  moduleServer(
    id,
    function(input, output, session) {
      output$plot = renderPlot({
        test_plot()
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
