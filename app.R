# HackBio First BioData Science Project

# Load packages -----------------------------------------------------
library(shiny)
library(ggplot2)
library(readr)

# Load data ---------------------------------------------------------
microbe <- read_csv("microbial_stationary_phase.txt")

# Define UI ---------------------------------------------------------
ui <- fluidPage(theme = shinytheme("united"),
                
                # Page header
                headerPanel('Compare microbial growth between microbial samples:'),
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs: Select variables to plot
    sidebarPanel(
      
      # Select variable for y-axis
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12"), 
                  selected = "A3"),
      
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12"), 
                  selected = "A5")
    ),
    
    # Output: Show scatterplot
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server function --------------------------------------------
server <- function(input, output) {

  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = microbe, aes_string(x = input$x, y = input$y)) +
      geom_point()
  })
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui = ui, server = server)
