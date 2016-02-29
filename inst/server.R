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
#library(RSQLite)
library(magrittr)
library(dplyr)

# import_fb_db <- dbConnect(SQLite(), dbname="Import_fb_db.sqlite")
# db <- RSQLite::dbReadTable(import_fb_db,name = "Import_fb_table")
# print(db)
 print(getwd())

shinyServer( function(input, output, session) {
  
  volumes <- shinyFiles::getVolumes()
   shinyFileChoose(input, 'file', roots=volumes, session=session,
                   restrictions=system.file(package='base'),filetypes=c('xlsx'))
  #shinyFileSave(input, 'save', roots=volumes, session=session, restrictions=system.file(package='base'))
   
   hot_path <- reactive ({
     validate(
       need(input$file != "", label = "Please enter an XLSX file. XLS files are forbidden")
     )
     
   if(length(input$file)==0){return (NULL)}
    if(length(input$file)>0){
       hot_file <- as.character(parseFilePaths(volumes, input$file)$datapath)
       }
   })
   
   minimal_param <- reactive({
     if(length(hot_file)==0){return (NULL)}
        if(length(hot_file)>0){
        excel_data <- get_excel_sheet_data(hot_file)
        minimal_param <- get_minimal_sheet_params(excel_data = excel_data) 
      }
   })
   
   
#     observe({
#       if (input$id_success == 0) 
#       return()
#       
#       hot_file <- hot_path() 
#       if(length(hot_file)==0){return (NULL)}
#       if(length(hot_file)>0){
#         excel_data <- get_excel_sheet_data(hot_file)
#         minimal_param <- get_minimal_sheet_params(excel_data = excel_data) 
#         excel_to_rda(excel_data)
#         db <- readRDS("import_register.rds")
#         insert_row <- data.frame(Fbname = minimal_param$ minimal_fbname,      
#                                  Crop=minimal_param$minimal_crop,   
#                                  Trial=minimal_param$minimal_trial,
#                                  Country=minimal_param$minimal_country,
#                                  Begin_Date=minimal_param$minimal_begindate,
#                                  Collaborator=minimal_param$minimal_collaborators, 
#                                  Leader=minimal_param$minimal_leader)
#         
#         
#       }
#       showshinyalert(session, "shinyalert1", paste("Your file has been saved", "success"), 
#                      styleclass = "success")
#     })
#     
   values <- reactiveValues()
   values$df <- data.frame(Column1 = NA, Column2 = NA)
   import_fb_data <- data.frame(Fbname=minimal_param()$minimal_fbname,
                                Crop=minimal_param()$minimal_crop,
                                Trial = minimal_param()$minimal_trial, 
                                Country= minimal_param()$minimal_country,  Begin_date=minimal_param$minimal_begindate , 
                                Collaborators=minimal_param()$minimal_collaborators, 
                                Leader=minimal_param()$minimal_leader) 
   
   newEntry <- observe({
     if (input$id_success == 0) 
           return()
       newLine <- isolate(c(input$text1, input$text2))
       isolate(values$df <- rbind(values$df, newLine))
     
   })
   
     
   db <- reactive({
     #import_fb_db <- dbConnect(SQLite(), dbname="Import_fb_db.sqlite")
     #db <- RSQLite::dbReadTable(import_fb_db,name = "Import_fb_table")
     #RSQLite::dbDisconnect(import_fb_db)
     db <- readRDS("D:/GITHUB_HIDAP_MOD/fbimport/data/import_fb_data.rds")
     db
   })
    
    output$the_data <- renderDataTable({
      #import()
      DT::datatable(db())
    })
    
#     import <- reactive({
#       hot_file <- hot_path() 
#       if(length(hot_file)==0){return (NULL)}
#       if(length(hot_file)>0){
#         excel_data <- get_excel_sheet_data(fp)
#         #If no minimal data or sheet, please entry one
#         minimal_param <- get_minimal_sheet_params(excel_data = excel_data) 
#         excel_to_rda(excel_data)
#       }
#     })
# 

    

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
