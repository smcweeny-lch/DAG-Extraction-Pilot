#Human-Human agreement only

setwd("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/Json")
rm(list = ls())
source("../code/cleaning_functions.R")

commission_errors <- read.csv("../disagreement_classification/commission_errors_to_drop.csv") %>% filter(error_type == "Commission")
commission_errors_belmonte <- commission_errors %>% filter(theory == "Belmonte")
commission_errors_baroncohen <- commission_errors %>% filter(theory == "Baron-Cohen")
commission_errors_gepner <- commission_errors %>% filter(theory == "Gepner")

omission_errors <- read.csv("../disagreement_classification/omission_errors_to_add.csv")
omission_errors_belmonte <- omission_errors %>% filter(theory == "Belmonte")
omission_errors_baroncohen <- omission_errors %>% filter(theory == "Baron-Cohen")
omission_errors_gepner <- omission_errors %>% filter(theory == "Gepner")


temp <- load.graphs(theory = "Belmonte")
invisible(list2env(temp, envir = .GlobalEnv))

#s.clean <- s.clean[!edge.paste(s.clean) %in% edge.paste(commission_errors[,1:2]),]

s.cleanest <- drop_error_edges(s.clean, commission_errors_belmonte)
j.cleanest <- drop_error_edges(j.clean, commission_errors_belmonte)
gpt.cleanest <- drop_error_edges(gpt.clean, commission_errors_belmonte)
gemini.cleanest <- drop_error_edges(gemini.clean, commission_errors_belmonte)


s.cleanest <- add_omitted_edges(s.cleanest, omission_errors_belmonte)
j.cleanest <- add_omitted_edges(j.cleanest, omission_errors_belmonte)
gpt.cleanest <- add_omitted_edges(gpt.cleanest, omission_errors_belmonte)
gemini.cleanest <- add_omitted_edges(gemini.cleanest, omission_errors_belmonte)


j.s.list <- compare.pair(g1 = j.cleanest, g2 = s.cleanest, g1.name = "j", g2.name = "s")
gemini.j.list <- compare.pair(g1 = gemini.cleanest, g2 = j.cleanest, g1.name = "gemini", g2.name = "j")
gpt.j.list <- compare.pair(g1 = gpt.cleanest, g2 = j.cleanest, g1.name = "gpt", g2.name = "j")
gemini.s.list <- compare.pair(g1 = gemini.cleanest, g2 = s.cleanest, g1.name = "gemini", g2.name = "s")
gpt.s.list <- compare.pair(g1 = gpt.cleanest, g2 = s.cleanest, g1.name = "gpt", g2.name = "s")
gpt.gemini.list <- compare.pair(g1 = gpt.cleanest, g2 = gemini.cleanest, g1.name = "gpt", g2.name = "gemini")

invisible(list2env(j.s.list, envir = .GlobalEnv))
invisible(list2env(gemini.j.list, envir = .GlobalEnv))
invisible(list2env(gemini.s.list, envir = .GlobalEnv))
invisible(list2env(gpt.j.list, envir = .GlobalEnv))
invisible(list2env(gpt.s.list, envir = .GlobalEnv))
invisible(list2env(gpt.gemini.list, envir = .GlobalEnv))

## TE1-TE2: Belmonte

cmp <- cmp.j.s
mcs <- mcs.j.s

report.table.j.s <- c(Coder1 = "TE1", Coder2 = "TE2", SharedNodes = length(cmp$shared_nodes), Coder1_unique_nodes = length(cmp$unique_nodes1), Coder2_unique_nodes = length(cmp$unique_nodes2), Jaccard_Nodes = round(cmp$jaccard_nodes, 3), Jaccard_Edges_Raw = round(cmp$jaccard_raw_edges, 3), Jaccard_Edges_Closure = round(cmp$jaccard_edges_shared_nodes,3))

g <- j.s.graph

nodes <- data.frame(id = V(g)$name, label = V(g)$name)

edges <- as_data_frame(g, what = "edges")# %>% 
#  drop_cycles_for_visnetwork() 



visNetwork(nodes, edges) %>%
  # visIgraphLayout(layout = "layout_with_sugiyama") %>% 
  visHierarchicalLayout(direction = "LR", sortMethod = "directed", levelSeparation = 10, nodeSpacing = 80) %>%
  visInteraction(navigationButtons = TRUE) %>% 
  visEdges(arrows = "to", width = .01)









temp <- load.graphs(theory = "Baron-Cohen")
invisible(list2env(temp, envir = .GlobalEnv))



s.cleanest <- drop_error_edges(s.clean, commission_errors_baroncohen)
j.cleanest <- drop_error_edges(j.clean, commission_errors_baroncohen)
gpt.cleanest <- drop_error_edges(gpt.clean, commission_errors_baroncohen)
gemini.cleanest <- drop_error_edges(gemini.clean, commission_errors_baroncohen)

s.cleanest <- add_omitted_edges(s.cleanest, omission_errors_baroncohen)
j.cleanest <- add_omitted_edges(j.cleanest, omission_errors_baroncohen)
gpt.cleanest <- add_omitted_edges(gpt.cleanest, omission_errors_baroncohen)
gemini.cleanest <- add_omitted_edges(gemini.cleanest, omission_errors_baroncohen)


j.s.list <- compare.pair(g1 = j.cleanest, g2 = s.cleanest, g1.name = "j", g2.name = "s")
gemini.j.list <- compare.pair(g1 = gemini.cleanest, g2 = j.cleanest, g1.name = "gemini", g2.name = "j")
gpt.j.list <- compare.pair(g1 = gpt.cleanest, g2 = j.cleanest, g1.name = "gpt", g2.name = "j")
gemini.s.list <- compare.pair(g1 = gemini.cleanest, g2 = s.cleanest, g1.name = "gemini", g2.name = "s")
gpt.s.list <- compare.pair(g1 = gpt.cleanest, g2 = s.cleanest, g1.name = "gpt", g2.name = "s")
gpt.gemini.list <- compare.pair(g1 = gpt.cleanest, g2 = gemini.cleanest, g1.name = "gpt", g2.name = "gemini")

invisible(list2env(j.s.list, envir = .GlobalEnv))
invisible(list2env(gemini.j.list, envir = .GlobalEnv))
invisible(list2env(gemini.s.list, envir = .GlobalEnv))
invisible(list2env(gpt.j.list, envir = .GlobalEnv))
invisible(list2env(gpt.s.list, envir = .GlobalEnv))
invisible(list2env(gpt.gemini.list, envir = .GlobalEnv))

## TE1-TE2: Baron-Cohen

cmp <- cmp.j.s
mcs <- mcs.j.s

report.table.j.s <- c(Coder1 = "TE1", Coder2 = "TE2", SharedNodes = length(cmp$shared_nodes), Coder1_unique_nodes = length(cmp$unique_nodes1), Coder2_unique_nodes = length(cmp$unique_nodes2), Jaccard_Nodes = round(cmp$jaccard_nodes, 3), Jaccard_Edges_Raw = round(cmp$jaccard_raw_edges, 3), Jaccard_Edges_Closure = round(cmp$jaccard_edges_shared_nodes,3))

g <- j.s.graph

nodes <- data.frame(id = V(g)$name, label = V(g)$name)

edges <- as_data_frame(g, what = "edges")# %>% 
#  drop_cycles_for_visnetwork() 

visNetwork(nodes, edges) %>%
  # visIgraphLayout(layout = "layout_with_sugiyama") %>% 
  visHierarchicalLayout(direction = "LR", sortMethod = "directed", levelSeparation = 20, nodeSpacing = 80) %>%
  visInteraction(navigationButtons = TRUE) %>% 
  visEdges(arrows = "to", width = .01)




# Gepner 

temp <- load.graphs(theory = "Gepner")
invisible(list2env(temp, envir = .GlobalEnv))



s.cleanest <- drop_error_edges(s.clean, commission_errors_gepner)
j.cleanest <- drop_error_edges(j.clean, commission_errors_gepner)
gpt.cleanest <- drop_error_edges(gpt.clean, commission_errors_gepner)
gemini.cleanest <- drop_error_edges(gemini.clean, commission_errors_gepner)


s.cleanest <- add_omitted_edges(s.cleanest, omission_errors_gepner)
j.cleanest <- add_omitted_edges(j.cleanest, omission_errors_gepner)
gpt.cleanest <- add_omitted_edges(gpt.cleanest, omission_errors_gepner)
gemini.cleanest <- add_omitted_edges(gemini.cleanest, omission_errors_gepner)


j.s.list <- compare.pair(g1 = j.cleanest, g2 = s.cleanest, g1.name = "j", g2.name = "s")
gemini.j.list <- compare.pair(g1 = gemini.cleanest, g2 = j.cleanest, g1.name = "gemini", g2.name = "j")
gpt.j.list <- compare.pair(g1 = gpt.cleanest, g2 = j.cleanest, g1.name = "gpt", g2.name = "j")
gemini.s.list <- compare.pair(g1 = gemini.cleanest, g2 = s.cleanest, g1.name = "gemini", g2.name = "s")
gpt.s.list <- compare.pair(g1 = gpt.cleanest, g2 = s.cleanest, g1.name = "gpt", g2.name = "s")
gpt.gemini.list <- compare.pair(g1 = gpt.cleanest, g2 = gemini.cleanest, g1.name = "gpt", g2.name = "gemini")

invisible(list2env(j.s.list, envir = .GlobalEnv))
invisible(list2env(gemini.j.list, envir = .GlobalEnv))
invisible(list2env(gemini.s.list, envir = .GlobalEnv))
invisible(list2env(gpt.j.list, envir = .GlobalEnv))
invisible(list2env(gpt.s.list, envir = .GlobalEnv))
invisible(list2env(gpt.gemini.list, envir = .GlobalEnv))

## TE1-TE2: Gepner

g <- j.s.graph

nodes <- data.frame(id = V(g)$name, label = V(g)$name)

edges <- as_data_frame(g, what = "edges")# %>% 
#  drop_cycles_for_visnetwork() 

visNetwork(nodes, edges) %>%
  visHierarchicalLayout(direction = "LR", sortMethod = "directed") %>%
  visInteraction(navigationButtons = TRUE) %>% 
  visEdges(arrows = "to", width = .01)


g <- graph_from_data_frame(j.cleanest)

nodes <- data.frame(id = V(g)$name, label = V(g)$name)

edges <- as_data_frame(g, what = "edges")# %>% 

visNetwork(nodes, edges) %>%
  visHierarchicalLayout(direction = "LR", sortMethod = "directed") %>%
  visInteraction(navigationButtons = TRUE) %>% 
  visEdges(arrows = "to", width = .01)



g <- graph_from_data_frame(s.cleanest)

nodes <- data.frame(id = V(g)$name, label = V(g)$name)

edges <- as_data_frame(g, what = "edges")# %>% 

visNetwork(nodes, edges) %>%
  visHierarchicalLayout(direction = "LR", sortMethod = "directed") %>%
  visInteraction(navigationButtons = TRUE) %>% 
  visEdges(arrows = "to", width = .01)
