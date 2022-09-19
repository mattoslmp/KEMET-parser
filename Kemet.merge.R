#Authors: Leandro de Mattos Pereira, Date: 19/09/2022
#Leandro de Mattos Pereira
#Gisele Nunes
rm(list=ls())
library (purrr)
library(readr)
library(ggpubr)
library(stringr)
############################ To specify KEMET results directory:
setwd ("D:/ITV/KEMET_resultados/reports_tsv_KASS")
###path: To specify directory contain KEMET results:
data_join <-list.files(path="D:/ITV/KEMET_resultados/reports_tsv_KASS/", pattern="*.tsv", full.names=TRUE) 
%>% lapply(read_tsv) %>%  
reduce(full_join, by = "Module_id")  %>% unique()                     
# colname: module_id
modules_id <- data_join$Module_id 
# colname: module_name
modules_names <- data_join$Module_name.x 
df <- data_join %>%
  select(matches("(Completeness)"))
myfilenames <-list.files(path="D:/ITV/KEMET_resultados/reports_tsv_KASS/", pattern="*.tsv", full.names=TRUE) 
#My Filenames pattern of KEMET results: reportKMC_Ga0541012_bin.tsv, get all names of samples:
name_files <- sapply(strsplit(myfilenames, split='reportKMC_', fixed=TRUE), function(x) (x[2]))
name_files <- str_remove(name_files, pattern = ".tsv")
df2 <- data.frame(modules_id, modules_names, df)
### To create a new data.frame with results and name of samples by collums
colnames(df2) <- c ("Module_id", "Completeness", name_files)
# Export data.frame with all KEMET results into a only table
write.table (df2, "Res_KEMET.tsv",row.names=FALSE, sep="\t")

