setwd("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/Json")
rm(list = ls())
source("../code/cleaning_functions.R")

# Run one theory at a time
temp <- load.graphs(theory = "Belmonte")
temp <- load.graphs(theory = "Baron-Cohen")
temp <- load.graphs(theory = "Gepner")

# run everything up to report.table.[theory] after you've chosen your temp
invisible(list2env(temp, envir = .GlobalEnv))

j.s.list <- compare.pair(g1 = j.clean, g2 = s.clean, g1.name = "j", g2.name = "s")
gemini.j.list <- compare.pair(g1 = gemini.clean, g2 = j.clean, g1.name = "gemini", g2.name = "j")
gpt.j.list <- compare.pair(g1 = gpt.clean, g2 = j.clean, g1.name = "gpt", g2.name = "j")
gemini.s.list <- compare.pair(g1 = gemini.clean, g2 = s.clean, g1.name = "gemini", g2.name = "s")
gpt.s.list <- compare.pair(g1 = gpt.clean, g2 = s.clean, g1.name = "gpt", g2.name = "s")
gpt.gemini.list <- compare.pair(g1 = gpt.clean, g2 = gemini.clean, g1.name = "gpt", g2.name = "gemini")

invisible(list2env(j.s.list, envir = .GlobalEnv))
invisible(list2env(gemini.j.list, envir = .GlobalEnv))
invisible(list2env(gemini.s.list, envir = .GlobalEnv))
invisible(list2env(gpt.j.list, envir = .GlobalEnv))
invisible(list2env(gpt.s.list, envir = .GlobalEnv))
invisible(list2env(gpt.gemini.list, envir = .GlobalEnv))


cmp <- cmp.j.s
mcs <- mcs.j.s
report.table.j.s <- c(Coder1 = "TE1", Coder2 = "TE2", SharedNodes = length(cmp$shared_nodes), Coder1_unique_nodes = length(cmp$unique_nodes1), Coder2_unique_nodes = length(cmp$unique_nodes2), Jaccard_Nodes = round(cmp$jaccard_nodes, 3), Jaccard_Edges_Raw = round(cmp$jaccard_raw_edges, 3), Jaccard_Edges_Closure = round(cmp$jaccard_edges_shared_nodes,3))

cmp <- cmp.gemini.j
mcs <- mcs.gemini.j
report.table.gemini.j <- c(Coder1 = "Gemini", Coder2 = "TE1", SharedNodes = length(cmp$shared_nodes), Coder1_unique_nodes = length(cmp$unique_nodes1), Coder2_unique_nodes = length(cmp$unique_nodes2), Jaccard_Nodes = round(cmp$jaccard_nodes, 3), Jaccard_Edges_Raw = round(cmp$jaccard_raw_edges, 3), Jaccard_Edges_Closure = round(cmp$jaccard_edges_shared_nodes,3))

cmp <- cmp.gemini.s
mcs <- mcs.gemini.s
report.table.gemini.s <- c(Coder1 = "Gemini", Coder2 = "TE2", SharedNodes = length(cmp$shared_nodes), Coder1_unique_nodes = length(cmp$unique_nodes1), Coder2_unique_nodes = length(cmp$unique_nodes2), Jaccard_Nodes = round(cmp$jaccard_nodes, 3), Jaccard_Edges_Raw = round(cmp$jaccard_raw_edges, 3), Jaccard_Edges_Closure = round(cmp$jaccard_edges_shared_nodes,3))

cmp <- cmp.gpt.j
mcs <- mcs.gpt.j
report.table.gpt.j <- c(Coder1 = "GPT", Coder2 = "TE1", SharedNodes = length(cmp$shared_nodes), Coder1_unique_nodes = length(cmp$unique_nodes1), Coder2_unique_nodes = length(cmp$unique_nodes2), Jaccard_Nodes = round(cmp$jaccard_nodes, 3), Jaccard_Edges_Raw = round(cmp$jaccard_raw_edges, 3), Jaccard_Edges_Closure = round(cmp$jaccard_edges_shared_nodes,3))

cmp <- cmp.gpt.s
mcs <- mcs.gpt.s
report.table.gpt.s <- c(Coder1 = "GPT", Coder2 = "TE2", SharedNodes = length(cmp$shared_nodes), Coder1_unique_nodes = length(cmp$unique_nodes1), Coder2_unique_nodes = length(cmp$unique_nodes2), Jaccard_Nodes = round(cmp$jaccard_nodes, 3), Jaccard_Edges_Raw = round(cmp$jaccard_raw_edges, 3), Jaccard_Edges_Closure = round(cmp$jaccard_edges_shared_nodes,3))

cmp <- cmp.gpt.gemini
mcs <- mcs.gpt.gemini
report.table.gpt.gemini <- c(Coder1 = "GPT", Coder2 = "Gemini", SharedNodes = length(cmp$shared_nodes), Coder1_unique_nodes = length(cmp$unique_nodes1), Coder2_unique_nodes = length(cmp$unique_nodes2), Jaccard_Nodes = round(cmp$jaccard_nodes, 3), Jaccard_Edges_Raw = round(cmp$jaccard_raw_edges, 3), Jaccard_Edges_Closure = round(cmp$jaccard_edges_shared_nodes,3))

# report.table.belmonte <- bind_rows(report.table.j.s, report.table.gemini.j, report.table.gemini.s, report.table.gpt.s, report.table.gpt.j, report.table.gpt.gemini) %>%
#   mutate(theory = "Belmonte")
# 
# write.csv(report.table.belmonte, "../data/report_table_belmonte.csv")
# %>% 