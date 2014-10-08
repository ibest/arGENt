library(shiny)

sg1 <- read.csv("shotgun_examplesheet.csv", header=T)
amp1 <- read.csv("dbcamplicon_examplesheet.csv", header=T)

shinyServer(function(input, output) {
  
  output$out1 <- renderPrint({
    inFile <- input$file
    inFile$name})
  
  output$out2 <- renderPrint({
    inFile <- input$file
    inFile$datapath})
  
  output$contents <- renderTable({
    
    inFile <- input$file
    
    if (is.null(inFile))
      return(NULL)
    
    data <- do.call(rbind, lapply(inFile$datapath, function(M){
      ws <-read.csv(M, header=TRUE)
    }))
    head(data, n = input$obs)
  })
  
  output$sg <- renderTable({sg1})
  output$amp <- renderTable({amp1})
})