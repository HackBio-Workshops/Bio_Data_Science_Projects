# HackBio Bio-Data Science Project.

# Load packages -----------------------------------------------------
library(shiny)
library(ggplot2)
library(readr)
library(dplyr)

# Load data ---------------------------------------------------------
human_genes <- read_csv("mart_export.txt")
View(human_genes)

# Build model
human_genes <- human_genes %>% 
  filter(!is.na(Gene_name))

# Define UI ---------------------------------------------------------
ui <- fluidPage(theme = shinytheme("united"),
                
                # Page header
                headerPanel('For any of the human genes, convert the Ensembl ID to Gene ID:'),
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs: Select variables to plot
    sidebarPanel(
     
      # Show data table
      checkboxInput(inputId = "Ensembl_ID",
                    label = "Ugwu Paschal wants you to check box to see all converted human gene Ensembl_IDs",
                    value = TRUE)
    ),
    
    # Output
    mainPanel(


      # Show data table
      DT::dataTableOutput(outputId = "human_genes")
    )
  )
)

# Define server function --------------------------------------------
server <- function(input, output) {
  
  # Print data table if checked
  output$human_genes <- DT::renderDataTable(
    if(input$Ensembl_ID){
      DT::datatable(data = human_genes[, 1:2], 
                    options = list(pageLength = 10), 
                    rownames = FALSE)
    }
  )
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui, server)
