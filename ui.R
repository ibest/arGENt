
library(shiny)

shinyUI(fluidPage(
  
  titlePanel(img(src="ibest_logo.jpg", align="center")),
  
  sidebarLayout(position="right",
                sidebarPanel(
                  br(),
                textOutput("Name"),
                textOutput("ProjID"),
                textOutput("Assay"),
                textOutput("Reads"),
                textOutput("Length"),
                textOutput("Indices"),
                br()),
                
  mainPanel(h2("Genomics Resources Core MiSeq Sequencing Submissions", align="center"),
            
  textInput("Name", label = h3("Project Leader Name"), value = ""),
  textInput("ProjID", label = h3("Project Name"), value = ""),
  selectInput("Assay", label = h3("Select Assay Type"), 
              choices = list("TruSeq HT", "TruSeq LT", "Nextera XT"), 
              selected = 1),
  radioButtons("Reads", label = h3("Single/Paired"),
               choices = list("Single-end", "Paired-end"), 
               selected = 1),
  selectInput("Length", label = h3("Select Length of Reads"), 
              choices = list("50", "75", "100", "150", "200", "300"), 
              selected = 1),
  selectInput("Indices", label = h3("Select indexing barcodes"), 
              choices = list("Alpha", "Bravo", "Charlie", "Delta", "Echo",
                             "Foxtrot", "Golf", "Hotel", "India", "Juliet",
                             "Lima"), selected = 1),
  fileInput("Barcodes", label = h3("Barcode File Input")),
  actionButton("Submit", label = "Submit to GRC"),
  downloadButton("toMiSeq", label = "Download a MiSeq submission sheet"),
  hr()
                )

  
)))
