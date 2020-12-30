library(shiny)


shinyServer(function(input, output) {
  
  output$graph<-  renderPlot({
    print(substr(input$Pref,0,2))
    pre_nam<-as.integer(substr(input$Pref,0,2))
    make_bar_graph(pre_nam)
  })
})