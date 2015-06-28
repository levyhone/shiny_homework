library(shiny)
library(tools)
library(xlsx)
library(xts)

shinyServer(function(input, output){

  output$note<-renderText({
    infile<-input$file
    if(is.null(infile)){
       return(NULL)
    }
    ext<-file_ext(infile$name)
    if(input$dataformat==1){
      date.index="%m/%d/%Y"
    }else if(input$dataformat==2){
      date.index="%m-%d-%Y"
    }
    
    if(input$dataformat!=3){
    
    if(input$filetype=="csv"){
      if(ext!="csv"){
        print("Please re-upload a csv file.")
      }else{
        data<-na.omit(read.csv(infile$datapath,header=TRUE,sep=","))
        if(input$dataformat==1 && !(is.na(as.Date(data[,1],date.index)))){
          print("Please go to next tab to see the interactive graph.")
        }else if(input$dataformat==2 && !(is.na(as.Date(data[,1],date.index)))){
          print("Please go to next tab to see the interactive graph.")
        }else{
          print("Data format is incorrect, please re-upload your file.")
        }
      }
    }else if(input$filetype=="txt"){
      if(ext!="txt"){
        print("Please re-upload a txt file.")
      }else{
        data<-na.omit(read.table(infile$datapath,header=TRUE,sep="\t"))
        if(input$dataformat==1 && !(is.na(as.Date(data[,1],date.index)))){
          print("Please go to next tab to see the interactive graph.")
        }else if(input$dataformat==2 && !(is.na(as.Date(data[,1],date.index)))){
          print("Please go to next tab to see the interactive graph.")
        }else{
          print("Data format is incorrect, please re-upload your file.")
        }
      }
    }
    }else if(input$dataformat==3){
      if(ext=="xlsx" && input$filetype=="xlsx"){
        print("Please go to next tab to see the interactive graph.")
      }else{
        print("Please re-upload file.")
      }
      
    }
  })
  
  output$graph<-renderUI({
    plotOutput("plot", height=300,
               click = "plot_click",
               dblclick = dblclickOpts(
                 id = "plot_dblclick",
                 delay = input$dblclick_delay
               ),
               brush = brushOpts(
                 id = "plot_brush",
                 delay = input$brush_delay,
                 delayType = input$brush_policy,
                 direction = input$brush_dir,
                 resetOnNew = input$brush_reset
               )
    )
  })
  
  output$plot <- renderPlot({
    infile<-input$file
    if(is.null(infile)){
      return(NULL)
    }
    ext<-file_ext(infile$name)
    if(input$dataformat==1){
      date.index="%m/%d/%Y"
    }else if(input$dataformat==2){
      date.index="%m-%d-%Y"
    }
    
    if(input$dataformat!=3){
    if(input$filetype=="csv"){
      if(ext!="csv"){
        plot.new()
      }else{
        data<-na.omit(read.csv(infile$datapath,header=TRUE,sep=","))
        if(input$dataformat==1 && !(is.na(as.Date(data[,1],date.index)))){
          data<-xts(data[,2],order.by=as.Date(data[,1],date.index))
          plot(data,type="p",pch=19,cex=1.5,main="Time Series Data")
        }else if(input$dataformat==2 && !(is.na(as.Date(data[,1],date.index)))){
          data<-xts(data[,2],order.by=as.Date(data[,1],date.index))
          plot(data,type="p",pch=19,cex=1.5,main="Time Series Data")
        }else{
          plot.new()
        }
      }
    }else if(input$filetype=="txt"){
      if(ext!="txt"){
        plot.new()
      }else{
        data<-na.omit(read.table(infile$datapath,header=TRUE,sep="\t"))
        if(input$dataformat==1 && !(is.na(as.Date(data[,1],date.index)))){
          data<-xts(data[,2],order.by=as.Date(data[,1],date.index))
          plot(data,type="p",pch=19,cex=1.5,main="Time Series Data")
        }else if(input$dataformat==2 && !(is.na(as.Date(data[,1],date.index)))){
          data<-xts(data[,2],order.by=as.Date(data[,1],date.index))
          plot(data,type="p",pch=19,cex=1.5,main="Time Series Data")
        }else{
          plot.new()
        }
      }
    }
    }else if(input$dataformat==3){
      if(ext=="xlsx" && input$filetype=="xlsx"){
        data<-na.omit(read.xlsx(infile$datapath,sheetName="sheet1"))
        data<-xts(data[,2],order.by=as.Date(data[,1]))
        plot(data,type="p",pch=19,cex=1.5,main="Time Series Data")            
      }else{
        plot.new()
      }
      
      
    }
  })
  
  output$plot_clickinfo <- renderPrint({
    cat("input$plot_click:\n")
    str(input$plot_click)
  })
  
  output$plot_dblclickinfo <- renderPrint({
    cat("input$plot_dblclick:\n")
    str(input$plot_dblclick)
  })
  
  output$plot_brushinfo <- renderPrint({
    cat("input$plot_brush:\n")
    str(input$plot_brush)
  })
})
