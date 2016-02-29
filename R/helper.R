#fp <- "C:\\Users\\Omar\\Desktop\\SPYL200804_OLJORO.xlsx"




fb_sheets <- readxl::excel_sheets(fp)

f <- fb_sheets
sheet_list <- lapply(X=f, function(x) openxlsx::read.xlsx(xlsxFile = fp,sheet = x, na.strings = TRUE ))
names(sheet_list) <- fb_sheets

myobj <- structure(sheet_list)

minimal_fbsheet <-  myobj$Minimal

#Test: fb_Minimal_sheet is empty :: TROW AN ERROR
#library(dplyr)
#minimal_fbsheet[minimal_fbsheet$Factor=="Short name or Title","Value"]
minimal_fbname <- as.character(filter(minimal_fbsheet,Factor== "Short name or Title")%>% select(.,Value))[[1]]
minimal_crop <- as.character(filter(minimal_fbsheet,Factor== "Crop")%>% select(.,Value))[[1]]
minimal_trial <- as.character(filter(minimal_fbsheet,Factor== "Type of Trial")%>% select(.,Value))[[1]]
minimal_country <- as.character(filter(minimal_fbsheet,Factor== "Country")%>% select(.,Value))[[1]]
minimal_begindate <- as.character(filter(minimal_fbsheet,Factor== "Begin date")%>% select(.,Value))[[1]]
minimal_collaborators <- as.character(filter(minimal_fbsheet,Factor== "Collaborators")%>% select(.,Value))[[1]]
minimal_leader <- as.character(filter(minimal_fbsheet,Factor== "Leader")%>% select(.,Value))[[1]]


minimal_file_name <- paste(minimal_fbname,".rda",sep="")
#in specific repository called import_fieldbook
save(myobj,minimal_file_name)


