#fp <- "C:\\Users\\Omar\\Desktop\\SPYL200804_OLJORO.xlsx"

#TEST UNIT 

test(get_fb_sheets(sheets[1])=="Minimal")

library(magrittr)
library(dplyr)


get_excel_sheet_data <- function(file_path){
  fb_sheets <- readxl::excel_sheets(file_path)
  sheet_list <- lapply(X=fb_sheets, function(x) openxlsx::read.xlsx(xlsxFile = file_path,sheet = x, na.strings = TRUE ))
  names(sheet_list) <- fb_sheets
  sheet_list <- structure(sheet_list)
}


get_minimal_sheet_params <- function(excel_data){
  
  minimal_fbsheet <-  excel_data$Minimal
  #Selection of minimal parameters
  minimal_fbname <- as.character(dplyr::filter(minimal_fbsheet,Factor== "Short name or Title")%>% dplyr::select(.,Value))[[1]]
  minimal_crop <- as.character(dplyr::filter(minimal_fbsheet,Factor== "Crop")%>% select(.,Value))[[1]]
  minimal_trial <- as.character(dplyr::filter(minimal_fbsheet,Factor== "Type of Trial")%>% dplyr::select(.,Value))[[1]]
  minimal_country <- as.character(dplyr::filter(minimal_fbsheet,Factor== "Country")%>% dplyr::select(.,Value))[[1]]
  minimal_begindate <- as.character(dplyr::filter(minimal_fbsheet,Factor== "Begin date")%>% dplyr::select(.,Value))[[1]]
  minimal_collaborators <- as.character(dplyr::filter(minimal_fbsheet,Factor== "Collaborators")%>% dplyr::select(.,Value))[[1]]
  minimal_leader <- as.character(dplyr::filter(minimal_fbsheet,Factor== "Leader")%>% dplyr::select(.,Value))[[1]]
  
  #assembly all parameter in output list
  output <- list(minimal_fbsheet=minimal_fbsheet, 
                 minimal_fbname= minimal_fbname,
                 minimal_crop = minimal_crop,
                 minimal_trial = minimal_trial,
                 minimal_country = minimal_country,
                 minimal_begindate = minimal_begindate,
                 minimal_collaborators = minimal_collaborators,
                 minimal_leader = minimal_leader
                 )
}
  

excel_to_rda <- function(excel_data){
  
  #rda_name <- excel_data$minimal_data$minimal_fbname
  rda_name <- get_minimal_sheet_params(excel_data)$minimal_fbname
  rda_file_name <- paste(rda_name,".rda",sep="")
  #in specific repository called import_fieldbook
  save(excel_data,file=rda_file_name)
  
}

excel_data <- get_excel_sheet_data(fp)
minimal_param <- get_minimal_sheet_params(excel_data = excel_data) 
excel_to_rda(excel_data)
 


# minimal_fbsheet <-  myobj$Minimal
# #Test: fb_Minimal_sheet is empty :: TROW AN ERROR
# #library(dplyr)
# #minimal_fbsheet[minimal_fbsheet$Factor=="Short name or Title","Value"]
# minimal_fbname <- as.character(filter(minimal_fbsheet,Factor== "Short name or Title")%>% select(.,Value))[[1]]
# minimal_crop <- as.character(filter(minimal_fbsheet,Factor== "Crop")%>% select(.,Value))[[1]]
# minimal_trial <- as.character(filter(minimal_fbsheet,Factor== "Type of Trial")%>% select(.,Value))[[1]]
# minimal_country <- as.character(filter(minimal_fbsheet,Factor== "Country")%>% select(.,Value))[[1]]
# minimal_begindate <- as.character(filter(minimal_fbsheet,Factor== "Begin date")%>% select(.,Value))[[1]]
# minimal_collaborators <- as.character(filter(minimal_fbsheet,Factor== "Collaborators")%>% select(.,Value))[[1]]
# minimal_leader <- as.character(filter(minimal_fbsheet,Factor== "Leader")%>% select(.,Value))[[1]]


# minimal_file_name <- paste(minimal_fbname,".rda",sep="")
# #in specific repository called import_fieldbook
# save(myobj,minimal_file_name)

import_fb_data <- data.frame(Fbname=minimal_param$minimal_fbname,
           Crop=minimal_param$minimal_crop,
           Trial = minimal_param$minimal_trial, 
           Country= minimal_param$minimal_country,  Begin_date=minimal_param$minimal_begindate , 
           Collaborators=minimal_param$minimal_collaborators, 
           Leader=minimal_param$minimal_leader) 
