library(shiny)

shinyUI(fluidPage(
  
  #Application title
  titlePanel("Sample Sheet Viewer"),
  
  #Sidebar with controls to select a dataset and specify the number of observations to view
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file", 
                'Upload a .csv file to the core and view it here:', 
                multiple=TRUE, 
                accept=c(".csv")),
      numericInput("obs", 
                   "Number of lines to view:",
                   10)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Shotgun Sequencing", value = 1, tableOutput("sg"), helpText("Follow the format listed")),
        tabPanel("Amplicon Sequencing", value = 2, tableOutput("amp"), helpText("The Barcode IDs are provided by the GRC; refer to the barcode lookup tables to determine the appropriate IDs.")), id = 1),
      verbatimTextOutput('out1'),
      tableOutput('contents')
    )
  )
))