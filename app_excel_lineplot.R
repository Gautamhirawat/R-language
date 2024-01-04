# app_excel_lineplot.R
library(shiny)
library(readxl)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Excel Data Line Plot"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose Excel File", accept = c(".xlsx")),
      selectInput("column", "Choose Column", ""),
      actionButton("plot_button", "Plot")
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
    req(input$column)
    
    column_data <- data()[[input$column]][-1]  # Exclude the heading
    index <- seq_along(column_data)
    
    ggplot(data.frame(index = index, value = column_data), aes(x = index, y = value)) +
      geom_line(color = "blue") +
      geom_point(color = rainbow(length(column_data))) +
      labs(title = paste("Line Plot of", input$column),
           x = "Index", y = input$column) +
      ylim(min(column_data), max(column_data))  # Fix y-axis range
  })
}

# Run the Shiny app
shinyApp(ui, server)
