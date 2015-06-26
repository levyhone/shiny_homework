library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Time Series Data Visualization"),
  
  sidebarLayout(
    sidebarPanel(img(src = "cfrm-logo.png", height = 70, width = 370),
                 
                 br(), br(),
                 
                 selectInput("filetype",label="File Type:",
                             choices=c("csv","txt","xls","xlsx"),
                             selected="csv"),
                 
                 selectInput("dataformat",label="Data Format:",
                             choices=c("Single Column Time Series Data","Multiple Column Time Series Data"),
                             selected="Single Column Time Series Data"),
                 
                 fileInput("file",label="Input a File:",multiple=FALSE,
                           accept = c(
                             'text/csv',
                             'text/comma-separated-values',
                             'text/tab-separated-values',
                             'text/plain',
                             '.csv',
                             '.xls',
                             '.xlsx'
                           )),
                 
                 tags$hr(),
                 
                 checkboxInput('header', 'Header', TRUE),
                 
                 radioButtons('sep', 'Separator',
                              c(Comma=',',
                                Semicolon=';',
                                Tab='\t'),
                              ','),
                 
                 radioButtons('quote', 'Quote',
                              c(None='',
                                'Double Quote'='"',
                                'Single Quote'="'"),
                              '"')
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Data Instruction", textOutput("data")), 
        tabPanel("Interactive Base Graphic", plotOutput("graph"))
      )
    )
  )
))


?datasets
library(help="datasets")
