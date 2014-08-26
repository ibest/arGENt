
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
    paste("You have selected", input$Length, "reads.")})
  
  output$Indices <- renderText({
    paste(input$Indices, "barcodes were selected as your indices.")})

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
    paste("Experiment Name", input$ProjID, sep=","), paste("Date", today.date, sep=","), "Workflow", 
    "Application", paste("Assay", input$Assay, sep=","), "Description", "Chemistry,Default", "", 
    "[Reads]", sequences(x), "",
    "[Settings]", "ReverseComplement,0", "", "[Data]")
})


# downloads a .csv file in the correct format to pass to the Miseq using variables determined above
output$toMiSeq <- downloadHandler(
  filename = function() {
    paste(input$Name, '.csv', sep='') },
    content = function(con) {writeLines(datasetInput(), "Alida.csv");
      write.csv(datasetInput(), con)}
)
})