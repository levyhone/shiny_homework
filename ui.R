library(shiny)

shinyUI(fluidPage(
  titlePanel("Time Series Data Visualization"), 
  sidebarLayout(
    sidebarPanel(img(src = "cfrm-logo.png", height = 70, width = 370), 
                 br(), br(),
                 strong("Data Uploading Options:"),
                 br(),br(),
                 selectInput("filetype",label="File Type:",
                             choices=c("csv","txt","xlsx"),
                             selected="csv"),
                 selectInput("dataformat",label="Date Index Format(Data Format):",
                             choices=c("mon/day/year"=1,"mon-day-year"=2,"number of days"=3),
                             selected=1),
                 fileInput("file",label="Input a File:",multiple=FALSE,
                           accept = c(
                             ".csv",".txt",".xlsx"
                           )),
                 tags$hr(),
                 strong("Interactive Graph Options:"),
                 br(),br(),
                 div(class = "option-group",
                     div(class = "option-header", strong("Double-click")),
                     sliderInput("dblclick_delay", "Delay", min=100, max=1000, value=400,
                                 step=100)),
                 br(),
                 div(class = "option-group",
                     div(class = "option-header", strong("Brush")),
                     radioButtons("brush_dir", "Direction(s)",
                                  c("xy", "x", "y"), inline = TRUE),
                     radioButtons("brush_policy", "Input rate policy",
                                  c("debounce", "throttle"), inline = TRUE),
                     sliderInput("brush_delay", "Delay", min=100, max=1000, value=200,
                                 step=100),
                     checkboxInput("brush_reset", "Reset on new image"))

    ),
    mainPanel(
      tabsetPanel(
        tabPanel(title="Data Instruction", value="data",
                 fluidRow(
                   column(9,
                       h5(tags$u('Application Instruction')),
                       p("This application is aimed for time series data visualization using interactive base graph. Users
                          need to upload their time series data. And this application can be accessed on GitHub with the ",
                       a("repository.",href='https://github.com/levyhone/shiny_homework'),target="_blank"),
                                 
                       h5(tags$u('Uploaded Data Requirements')),
                       p("There are some file type and data format constraints for the uploaded data. Specifically speaking, the
                          file types should be: .csv, .txt, .xls, .xlsx"),
                       p("And the time series data should include a column of date index. The data format should be ",
                         strong("(example conditional on data format choice):")),
                       tags$ul(
                         tags$li(p("mon/day/year"),
                                 conditionalPanel(condition='input.dataformat==1',
                                 fluidRow(
                                 column(8,
                                 tags$pre(id='ex1',
                                          'DATE           DJIA
12/02/1991	33.43
12/03/1991	32.28'
                                   ))))),
                         tags$li(p("mon-day-year"),
                                 conditionalPanel(condition='input.dataformat==2',
                                 fluidRow(
                                   column(11,
                                          tags$pre(id="ex2",
                                                   'DATE           DJIA
12-02-1991      33.43
12-03-1991	32.28'))))),
                         tags$li(p("number of days"),
                                 conditionalPanel(condition='input.dataformat==3',
                                                  fluidRow(
                                                    column(11,
                                                           tags$pre(id="ex2",
                                                                    'DATE         DJIA
33574      33.43
33575      32.28')))))
                      ),
                      h5(tags$u("Uploaded Data Notification:")),
                      p("If the user uploaded data with a wrong file type or data format, then shiny would remind the user below with: "),
                      em("Please re-upload your file."),
                      br(),br(),
                      p("If the file uploaded is in a right file type and data format, then shiny would display the message below:"),
                      em("Please go to next tab to see the interactive graph."),
                      br(),br(),
                      strong(em(textOutput("note")))
            
                   )        
                )
        ),
        tabPanel("Interactive Base Graphic", 
                 fluidRow(
                   column(10,offset=1,uiOutput("graph"))),
                 fluidRow(
                   column(4,verbatimTextOutput("plot_clickinfo")),
                   column(4,verbatimTextOutput("plot_dblclickinfo")),
                   column(4,verbatimTextOutput("plot_brushinfo"))
                 )
      )
    )
  )
 )
)
)


