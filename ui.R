library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Sample Sheet Viewer"),
  
  #Sidebar with controls to select user-supplied sheet and specify the number of observations to view
  sidebarLayout(
    sidebarPanel(
      fileInput("file", 
                'Upload a .csv file to the core and view it here alongside the example templates:', 
                multiple=TRUE, 
                accept=c(".csv")),
      numericInput("obs", 
                   "Number of lines to view:",
                   10),
      br(),
      br(),
      downloadButton('abcBarcodes', "Download the GRC barcode lookup sheets."),
      br(),
      br(),
      downloadButton('blank.dbc', "Download the pictured template sheet for amplicon sequencing."),
      br(),
      br(),
      downloadButton('blank.sgun', "Download the pictured template sheet for shotgun sequencing.")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Shotgun Sequencing", value = 1, tableOutput("sg"), helpText("Follow the above format when generating your sample sheet.")),
        tabPanel("Amplicon Sequencing", value = 2, tableOutput("amp"), helpText("Please include the sequences of the CS-tags with the template-specific primer sequences. The Barcode IDs are dual-indexes provided by the GRC in 96-well plate layout; the barcode ID corresponds to its location on the plate.")), id = 1),
      verbatimTextOutput('out1'),
      tableOutput('contents')
    )
  )
))