#this script is running on bioinfo-mite currently, most updated version

library(shiny)

shinyServer(function(input, output) {
  
  # the reactive ext in the sidebar that changes when a user makes a selection
  output$Name <- renderText({ 
    paste(input$Name, "is the project leader.")})
  
  output$ProjID <- renderText({
    paste(input$ProjID, "is the project name.")})
  
  output$Assay <- renderText({
    paste(input$Assay, "was used to prepare the libraries.")})
  
  output$Reads <- renderText ({ 
    paste("You have selected", input$Reads, "sequencing.")})

  output$Length <- renderText({
    paste("You have selected", input$Length, "bp reads.")})
  
  output$Samples <- renderText({
    paste(input$Samples, "samples will be sequenced.")})
    

  sequences <- function(x){
    x <- input$Reads
    if (x == "Single-end")
    print(c(input$Length, "0"), sep="")
    else if (x != "Single-end")
      print(c(input$Length, input$Length), sep="")
  }

date.input <- Sys.Date()
today.date <- format(date.input, format="%D")
  
#a reactive function that takes the user-supplied input and writes a .csv when downloads are requested
datasetInput <- reactive({
  c("[Header]", "IEMFileVersion,4", paste("Investigator Name", input$Name, sep=","), 
    paste("Experiment Name", input$ProjID, sep=","), paste("Date", today.date, sep=","), "Workflow,GenerateFASTQ", 
    "Application", paste("Assay", input$Assay, sep=","), "Description", "Chemistry,Default", "", 
    "[Reads]", sequences(x), "",
    "[Settings]", "ReverseComplement,0", "", "[Data]", c("Sample_ID,Sample_Name,Sample_Plate,Sample_Well,I7_Index_ID,index,Sample_Project,Description"),
  c(paste(input$Sample_ID1, input$Sample_ID1, ",,", input$Index1, input$ProjID, input$ProjID, sep=","))
  )})


# downloads a .csv file in the correct format to pass to the Miseq using variables determined above
output$downloadData <- downloadHandler(
  filename = function() {
    paste(input$Name, today.date, '.csv', sep='')
    },
    content = function(file) {
      write.table(datasetInput(), file, quote=F, row.names=F, col.names=F)
    }
)

})