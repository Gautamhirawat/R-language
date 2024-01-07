library(shiny)
library(readxl)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Excel Data Plot"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose Excel File", accept = c(".xlsx")),
      selectInput("column", "Choose Column", ""),
      actionButton("plot_button", "Plot"),
      selectInput("plot_type", "Select Plot Type",
                  choices = c("Scatter Plot", "Line Plot", "Bar Plot", "Histogram",
                              "Box Plot", "Violin Plot", "Heatmap", "Bubble Plot",
                              "Scatter Plot Matrix", "Ridgeline Plot"),
                  selected = "Line Plot")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  data <- reactive({
    req(input$file)
    read_excel(input$file$datapath)
  })
  
  observe({
    if (!is.null(input$file)) {
      updateSelectInput(session, "column", choices = names(data()))
    }
  })

  output$plot <- renderPlot({
    req(input$plot_button)
    
    column_data <- data()[[input$column]][-1]  # Exclude the heading
    index <- seq_along(column_data)
    
    ggplot(data.frame(index = index, value = column_data), aes(x = index, y = value)) +
      switch(input$plot_type,
             "Scatter Plot" = geom_point(),
             "Line Plot" = geom_line(),
             "Bar Plot" = geom_bar(stat = "identity"),
             "Histogram" = geom_histogram(binwidth = 1),
             "Box Plot" = geom_boxplot(),
             "Violin Plot" = geom_violin(),
             "Heatmap" = geom_tile(aes(fill = ..value..)),
             "Bubble Plot" = geom_point(aes(size = ..value..)),
             "Scatter Plot Matrix" = {
               p <- ggplot(data.frame(index = rep(index, length(index)), value = rep(column_data, each = length(index))),
                           aes(x = index, y = value, color = factor(index)))
               p <- p + geom_point() + facet_grid(index ~ .)
               p
             },
             "Ridgeline Plot" = ggridges::ggridges(data.frame(value = column_data), aes(x = value))
      ) +
      labs(title = paste("Plot of", names(data())[which(names(data()) == input$column)]),
           x = "Index", y = input$column) +
      theme_minimal()  # Use a minimal theme for a cleaner look
  })
}

# Run the Shiny app
shinyApp(ui, server)
