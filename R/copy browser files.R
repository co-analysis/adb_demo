library(tidyverse)
library(magrittr)
library(R.utils)

meta <- c("lib","metadata")
content <- c("data.csv","index.html")

for (year in 2021:2023) {
  from_dir <- paste0("../acses_data_browser_",year)
  
  map(meta,~copyDirectory(paste0(from_dir,"/docs/",.x),paste0("docs/",year,"/",.x)))
  
  
  file_list <- list.files(paste0(from_dir,"/docs"))
  
  folder_list <- setdiff(file_list,c(meta,content))
  
  content_from <- map(content,~list.files(paste0(from_dir,"/docs/",c("",folder_list)),full.names=TRUE,pattern=.x)) %>%
    unlist(F,F)
  
  content_to <- gsub(paste0(from_dir,"/docs/"),paste0("docs/",year,"/"),content_from,fixed=TRUE)
  folder_to <- gsub("\\/[^\\/]*$","",content_to) %>%
    unique()
  
  map(folder_to,~dir.create(.x,recursive=TRUE))
  file.copy(content_from,content_to)
  print(year)
}
