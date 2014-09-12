#this script is running on bioinfo-mite currently: unsure of whether or not to integrate a dynamic user input for number of samples due to issues with keeping and exporting that information, so keeping it static for now

library(shiny)

bcds.p7 <- read.table("barcode_p7_lookup.txt", col.names=F, stringsAsFactors=F, sep=",")
bcds.p5 <- read.table("barcode_p5_lookup.txt", col.names=F, stringsAsFactors=F, sep=",")
bcd_p7 <- (bcds.p7)
bcd_p5 <- (bcds.p5)


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
    br(),
    checkboxInput("DBC", label = h3("Check box for double barcodes")),
    br(),
    selectInput("numSamples", label = h4("Select the number of samples for
                                     sequencing and enter information below:"), choices =list("1-5" = 1, "6-10" = 2, "11-15" = 3, "16-20" =4)),
    br(),
    br(),
    br(),
    wellPanel(textInput("Sample_ID1", label = h5("Enter sample name")),
            selectInput("Index1", label = h5("Select I7 indexing barcode"), choices = bcd_p7),
            conditionalPanel(
              condition = "input.DBC==true",
              selectInput("I5Index1", label = h5("Select I5 indexing barcode"), choices = bcd_p5))),
    wellPanel(textInput("Sample_ID2", label = h5("Enter sample name")),
              selectInput("Index2", label = h5("Select I7 indexing barcode"), choices = bcd_p7),
              conditionalPanel(
                condition = "input.DBC==true",
                selectInput("I5Index2", label = h5("Select I5 indexing barcode"), choices = bcd_p5))),
    wellPanel(textInput("Sample_ID3", label = h5("Enter sample name")),
              selectInput("Index3", label = h5("Select I7 indexing barcode"), choices = bcd_p7),
              conditionalPanel(
                condition = "input.DBC==true",
                selectInput("I5Index3", label = h5("Select I5 indexing barcode"), choices = bcd_p5))),
    wellPanel(textInput("Sample_ID4", label = h5("Enter sample name")),
              selectInput("Index4", label = h5("Select I7 indexing barcode"), choices = bcd_p7),
              conditionalPanel(
                condition = "input.DBC==true",
                selectInput("I5Index4", label = h5("Select I5 indexing barcode"), choices = bcd_p5))),
    wellPanel(textInput("Sample_ID1", label = h5("Enter sample name")),
              selectInput("Index5", label = h5("Select I7 indexing barcode"), choices = bcd_p7),
              conditionalPanel(
                condition = "input.DBC==true",
                selectInput("I5Index5", label = h5("Select I5 indexing barcode"), choices = bcd_p5))),
    conditionalPanel(
     condition = "input.numSamples == 2",
     wellPanel(textInput("Sample_ID6", label = h5("Enter sample 6 name")),
               selectInput("Index6", label = h5("Select I7 indexing barcode"), choices = bcd_p7),
               conditionalPanel(
                 condition = "input.DBC==true",
                 selectInput("I5Index6", label = h5("Select I5 indexing barcode"), choices = bcd_p5)))),
    br(),
    paste("Double-check all barcode assignments!"),
    br(),
    br(),
    downloadButton("downloadData", label=h5("Download the submission sheet")),
    hr()

  ))
))
