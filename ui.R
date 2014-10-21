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
                   10),
      br(),
      br(),
      downloadButton('abcBarcodes', "Download the GRC barcode lookup sheets.")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Shotgun Sequencing", value = 1, tableOutput("sg"), helpText("Follow the above format when generating your sample sheet.")),
        tabPanel("Amplicon Sequencing", value = 2, tableOutput("amp"), helpText("The Barcode IDs are dual-indexes provided by the GRC in 96-well plate layout; the barcode ID corresponds to its location on the plate.")), id = 1),
      verbatimTextOutput('out1'),
      tableOutput('contents')
    )
  )
))