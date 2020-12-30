library(shiny)

##source("make_graph.R",encoding="UTF-8")

# サーバロジックの定義。ヒストグラムを描く
shinyServer(function(input, output) {
  
  #output$text1 <- renderText({ 
   # paste(input$Pref)
  #})
  
  output$graph<-  renderPlot({
    print(substr(input$Pref,0,2))
    pre_nam<-as.integer(substr(input$Pref,0,2))
    make_series(pre_nam,input$date)
  })
  output$bar_graph <- renderPlot({
    print(substr(input$Pref,0,2))
    pre_nam<-as.integer(substr(input$Pref,0,2))
    make_bar_graph(pre_nam,input$date)
  })
    
  output$table <- renderTable({
    print(substr(input$Pref,0,2))
    pre_nam<-as.integer(substr(input$Pref,0,2))
    make_table(pre_nam,input$date)
  })
  
})