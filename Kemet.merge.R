
library(readr)
#Autor: Leandro de Mattos Pereira 12/02/2018
###Leandro de Mattos Pereira
###Gisele Nunes
#### Fun??es usadas: Phyloseq, Melt and ggplot, biomformat,dplyr"
rm(list=ls())
library (purrr)
library(readr)
library(ggpubr)
library(stringr)
############################ IMPORTACAO DE DADOS DO QIIME2
setwd ("D:/ITV/KEMET_resultados/reports_tsv_KASS")

###path: To specify directory contain KEMET results:
data_join <-list.files(path="D:/ITV/KEMET_resultados/reports_tsv_KASS/", pattern="*.tsv", full.names=TRUE) %>% 
lapply(read_tsv) %>%  
reduce(full_join, by = "Module_id")  %>% unique()                     
data_join               

modules_id <- data_join$Module_id # colname: module_id
modules_names <- data_join$Module_name.x # colname: module_name

df <- data_join %>%
  select(matches("(Completeness)"))


#My Filenames pattern of KEMET results: reportKMC_Ga0541012_bin.tsv

myfilenames <-list.files(path="D:/ITV/KEMET_resultados/reports_tsv_KASS/", pattern="*.tsv", full.names=TRUE) 
name_files <- sapply(strsplit(myfilenames, split='reportKMC_', fixed=TRUE), function(x) (x[2]))
name_files <- str_remove(name_files, pattern = ".tsv")

df2 <- data.frame(modules_id, modules_names, df)
colnames(df2) <- c ("Module_id", "Completeness", name_files)
colnames(df2) <- c ("Module_id", "Completeness","AM.P1.D","AM.P1.R","AM.P2.D","AM.P2.R","TIA.P1.D","TIA.P1.R",
  "TIA.P2.D","TIA.P2.R","TI.P1.D","TI.P1.R","TI.P2.D","TI.P2.R",
  "TI.P3.D","TI.P3.R","TI.P4.D","TI.P4.R","VI.P1.D","VI.P1.R",
  "VI.P2.D","VI.P2.R")
write.table (df2, "Res_KEMET.tsv",row.names=FALSE, sep="\t")

