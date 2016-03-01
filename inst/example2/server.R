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
#print(getwd())

shinyServer( function(input, output, session) {
  
  volumes <- shinyFiles::getVolumes()
  shinyFileChoose(input, 'file', roots=volumes, session=session,
                  restrictions=system.file(package='base'),filetypes=c('xlsx'))
  
  
  hot_path <- reactive ({
    validate(
      need(input$file != "", label = "Please enter an XLSX file. XLS files are forbidden")
    )
    
    if(length(input$file)==0){return (NULL)}
    if(length(input$file)>0){
      hot_file <- as.character(parseFilePaths(volumes, input$file)$datapath)
    }
  })
  
  
  observe({
    if (input$id_success == 0) 
      return()
   # hot_file <- hot_path() 
#     if(length(hot_file)==0){return (NULL)}
#     if(length(hot_file)>0){
#     }
    showshinyalert(session, "shinyalert1", paste("Your file has been saved", "success"), 
                   styleclass = "success")
  })
  
  
  values <- reactiveValues()
  #values$df <- data.frame(Column1 = NA, Column2 = NA)
#   values$df <- data.frame(Fbname = NA, Crop = NA,Trial = NA, Country = NA, Begin_Date = NA,
#                           Collaborator = NA, Leader = NA)
#   
  values$df <- readRDS("C:/OMAR-2015/GitHubProjects/fbimport/inst/example2/omar.rds") 
#     insert_row <- data.frame(Fbname = minimal_param$ minimal_fbname,      
#                                    Crop=minimal_param$minimal_crop,   
#                                    Trial=minimal_param$minimal_trial,
#                                    Country=minimal_param$minimal_country,
#                                    Begin_Date=minimal_param$minimal_begindate,
#                                    Collaborator=minimal_param$minimal_collaborators, 
#                                    Leader=minimal_param$minimal_leader)
#   
  
  newEntry <- observe({
    #if(input$update > 0) {
    if(input$id_success>0) { 
     
      fp <- hot_path()
      excel_data <- get_excel_sheet_data(fp)
      minimal_param <- get_minimal_sheet_params(excel_data = excel_data) 
      excel_to_rda(excel_data)
      
      insert_row <- data.frame(Fbname = minimal_param$ minimal_fbname,      
                               Crop=minimal_param$minimal_crop,   
                               Trial=minimal_param$minimal_trial,
                               Country=minimal_param$minimal_country,
                               Begin_Date=minimal_param$minimal_begindate,
                               Collaborator=minimal_param$minimal_collaborators, 
                               Leader=minimal_param$minimal_leader)
      
      #newLine <- isolate(c(input$text1, input$text2))
      newLine <- insert_row
      
      isolate(values$df <- rbind(values$df, newLine))
      saveRDS(object = values$df,file="omar.rds")
    }
  })
  
  output$table1 <- renderDataTable({
    
    DT::datatable(values$df)
  })
  
})
