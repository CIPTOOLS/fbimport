library(shinydashboard)
library(shiny)
#library(data.table)
library(rhandsontable)
library(traittools)
library(sbformula)
library(openxlsx)
library(shinyFiles)
library(doBy)
library(DT)
library(sqldf)
library(shinysky)
library(shinyBS)

shinyUI( 
  shinydashboard::dashboardPage(
    skin="yellow",
    dashboardHeader(title = "Import Data"),
    dashboardSidebar(
      sidebarMenu(
        id = "tabs",
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Phenotyping Dashboard", icon = icon("dashboard"),
                 menuSubItem(text = "Import Data", tabName = "import_data")
        )
      ) 
    ),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "dashboard",
                h2("HIDAP Modules"),
                p(
                  class = "text-muted",
                  paste("Building..."
                  ))
        ),
        ###########
        #begin data_processing tabItem
        tabItem(tabName = "import_data",
                h2("Import Data"),   
                
                
                tabsetPanel(
                  tabPanel("Import Data", #begin tabset "CHECK"
                           fluidRow(
                             
                             #shinyFilesButton('file', 'File select', 'Please select a file',FALSE),
                             actionButton("tabBut", "Import Fieldbook"),
                             
                             bsModal("modalExample", "File Selection", "tabBut", size = "large",
                                     h2("Import your Excel files"),
                                     shinyFilesButton('file', 'File select', 'Please select a file',FALSE),
                                     #DT::dataTableOutput("the_data") ,width = NULL, height = NULL)
                                     actionButton("id_success","Save",styleclass="success",icon = "ok"),
                                     shinyalert("shinyalert1", FALSE,auto.close.after = 5)
                                     ),
                             br(),
                             box(
                             #actionButton("calculate", "Calculate",icon("play-circle-o")),
                             #HTML('<div style="float: right; margin: 0 5px 5px 10px;">'),
                             #actionLink('exportButton', 'Download data'),
                             #HTML('</div>'),
                             #p(),
                             DT::dataTableOutput("the_data") ,width = NULL, height = NULL)
                           )
                          ),
                          
                          tags$style(type='text/css', "#tabBut { width:250px; margin-top: 25px;}"),
                          tags$style(HTML('#tabBut {background-color:#0099cc; color: #ffffff}')),   
                          tags$style(type='text/css', "#file { width:150px; margin-top: 25px;}"),
                          tags$style(HTML('#file {background-color:#0099cc; color: #ffffff}'))  
                          #tags$style(type='text/css', "#exportButton { width:50%; margin-top: 25px;}"),
                          #tags$style(HTML('#exportButton {background-color:#30c9ae; color: #ffffff}')),
                           
                  )#end tab Panel "CHECK"
                  
#                   tabPanel("Trait List", #begin Trait List Panel"
#                            fluidRow(
# #                              box(rHandsontableOutput("hot_td_trait",height = "1400px",width = "1400px"),
# #                                  height = "3400px",width ="2400px")
#                              
#                            )#end fluidRow
#                   )
                  
                  
                  
                )
        )#End data_processing tabItem
        
      )
    )
    
  )


