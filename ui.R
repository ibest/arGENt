#this script is running on bioinfo-mite currently, most updated version

bcds <- read.table("/home/alida/Documents/Idaho/R/sample_sheet/toposheet/grc.barcodes.csv", header=T,
                   stringsAsFactors=F)
bcd.name <- (bcds$grc.name)

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
                textOutput("Samples"),
                br()),
                
  mainPanel(h2("Genomics Resources Core Sequencing Manager", align="center"),
            
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
  br(),

  numericInput("Samples", label = h5("Input the number of samples for
                                     sequencing:"), value = NA, step=NA),
  br(),
  br(),
  br(),
  wellPanel(textInput("Sample_ID1", label = h5("Enter sample 1 name")),
            selectInput("Index1", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID2", label = h5("Enter sample 2 name")),
            selectInput("Index2", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID3", label = h5("Enter sample 3 name")),
            selectInput("Index3", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID4", label = h5("Enter sample 4 name")),
            selectInput("Index4", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID5", label = h5("Enter sample 5 name")),
            selectInput("Index5", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID6", label = h5("Enter sample 6 name")),
            selectInput("Index6", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID7", label = h5("Enter sample 7 name")),
            selectInput("Index7", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID8", label = h5("Enter sample 8 name")),
            selectInput("Index8", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID9", label = h5("Enter sample 9 name")),
            selectInput("Index9", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  wellPanel(textInput("Sample_ID10", label = h5("Enter sample 10 name")),
            selectInput("Index10", label = h5("Select I7 indexing barcode"), choices = bcd.name)),
  br(),
  br(),
  downloadButton("downloadData", "Download the submission sheet"),
  hr()
                )

  
)))
