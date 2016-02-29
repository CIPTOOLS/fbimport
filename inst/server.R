library(shinydashboard)
library(shiny)
#library(data.table)
library(rhandsontable)
library(traittools)
library(sbformula)
library(openxlsx)
library(shinyFiles)
library(date)
library(agricolae)
library(DT)
library(sqldf)
library(RSQLite)

# import_fb_db <- dbConnect(SQLite(), dbname="Import_fb_db.sqlite")
# db <- RSQLite::dbReadTable(import_fb_db,name = "Import_fb_table")
# print(db)
# print(getwd())

shinyServer( function(input, output, session) {
  
  volumes <- shinyFiles::getVolumes()
   shinyFileChoose(input, 'file', roots=volumes, session=session,
                   restrictions=system.file(package='base'),filetypes=c('xlsx'))
  #shinyFileSave(input, 'save', roots=volumes, session=session, restrictions=system.file(package='base'))
#   
    db <- reactive({
      import_fb_db <- dbConnect(SQLite(), dbname="Import_fb_db.sqlite")
      db <- RSQLite::dbReadTable(import_fb_db,name = "Import_fb_table")
    })
#     
#     
    output$the_data <- renderDataTable({
      
      #print(db())
      DT::datatable(db())
      
    })
  
  
  
#   hot_path <- reactive ({
#     
#     validate(
#       need(input$file != "", label = "Please enter an XLSX file. XLS files are forbidden")
#     )
#     
#     if(length(input$file)==0){return (NULL)}
#     if(length(input$file)>0){
#       hot_file <- as.character(parseFilePaths(volumes, input$file)$datapath)
#     }
#   })
#   
#   hot_bdata <- reactive({
#     hot_file <- hot_path()
#     if(length(hot_file)==0){return (NULL)}
#     if(length(hot_file)>0){
#       hot_bdata <- readxl::read_excel(path=hot_file , sheet = "Fieldbook")
#     }
#   })
#   
#   hot_mtl <- reactive({
#     hot_file <- hot_path()
#     if(length(hot_file)==0){return (NULL)}
#     if(length(hot_file)>0){
#       #hot_mtl <- reactive_excel_metadata(file_id =hot_file , "Material List")
#       hot_mtl <- openxlsx::read.xlsx(xlsxFile= hot_file, sheet = "Material List", detectDates = TRUE)
#       hot_mtl
#       #print(hot_mtl)
#     }
#   })
  #print(hot_mtl())
  
  ###end extra code
  
  
})
