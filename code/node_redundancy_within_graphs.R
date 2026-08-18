setwd("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/Json")
rm(list = ls())
source("../code/cleaning_functions.R")

temp <- load.graphs(theory = "Belmonte")

# # run everything up to report.table.[theory] after you've chosen your temp
invisible(list2env(temp, envir = .GlobalEnv))
# 
redundancy_table_belmonte <- node_redundancy(node_map, j, s, gemini, gpt, theory = "Belmonte")



temp <- load.graphs(theory = "Baron-Cohen")

# # run everything up to report.table.[theory] after you've chosen your temp
invisible(list2env(temp, envir = .GlobalEnv))
# 
redundancy_table_baroncohen <- node_redundancy(node_map, j, s, gemini, gpt, theory = "Baron-Cohen")


temp <- load.graphs(theory = "Gepner")

# # run everything up to report.table.[theory] after you've chosen your temp
invisible(list2env(temp, envir = .GlobalEnv))
# 
redundancy_table_gepner <- node_redundancy(node_map, j, s, gemini, gpt, theory = "Gepner")


redundancy_table <- bind_rows(redundancy_table_belmonte, redundancy_table_baroncohen, redundancy_table_gepner)

DT::datatable(redundancy_table %>%  group_by(encoder) %>% 
  summarize(Redundant_Nodes = sum(n_redundant)))
