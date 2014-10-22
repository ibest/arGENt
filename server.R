library(shiny)

sg1 <- read.csv("shotgun_examplesheet.csv", header=T)
sg2 <- read.csv("shotgun_examplesheet.csv", quote="")
amp1 <- read.csv("dbcamplicon_examplesheet.csv", header=T)
amp2 <- read.csv("dbcamplicon_examplesheet.csv", quote="")
abcBarcodes <- readLines(con="clientplate.barcodelocations.csv", warn=F)

shinyServer(function(input, output) {
  
  output$out1 <- renderPrint({
    inFile <- input$file
    inFile$name})
  
  output$out2 <- renderPrint({
    inFile <- input$file
    inFile$datapath})
  
  output$abcBarcodes <- downloadHandler("barcodes.xlsx",
                                        content= function(file){
                                         writeLines(abcBarcodes, con=file)
                                        })
  
  output$blank.dbc <- downloadHandler("AmpliconsSheet.csv",
                                        content=function(file){
                                          write.csv(amp2, file)
                                          })
  
  output$blank.sgun <- downloadHandler("ShotgunSheet.csv",
                                       content = function(file){
                                         write.csv(sg2, file)
                                       })
  
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