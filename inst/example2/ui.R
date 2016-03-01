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
               actionButton("tabBut", "Import Fieldbook"),
               bsModal("modalExample", "File Selection", "tabBut", size = "large",
               h2("Import your Excel files"),
               shinyFilesButton('file', 'File select', 'Please select a file',FALSE),
               #DT::dataTableOutput("the_data") ,width = NULL, height = NULL)
               actionButton("id_success","Save",styleclass="success",icon = "ok"),
               shinyalert("shinyalert1", FALSE,auto.close.after = 5)),
                #        textInput("text1", "Column 1"),
                 #       textInput("text2", "Column 2"),
                  #      actionButton("update", "Update Table"),
                        DT::dataTableOutput("table1")
                             
                           )
                  ) 
                   
                )#end tab Panel "CHECK"
                
        )
      )#End data_processing tabItem
      
    )
  )
  
)