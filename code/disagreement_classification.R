setwd("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/Json")
rm(list = ls())
source("../code/cleaning_functions.R")

temp <- load.graphs(theory = "Gepner") # Belmonte, Baron-Cohen, Gepner
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


j.s.disagree <- og_edge_conflicts(cmp.j.s$edge_diffs, edges1 = j.clean, edges2 = s.clean) %>% mutate(coder1 = "TE1", coder2 = "TE2")
gemini.j.disagree <- og_edge_conflicts(cmp.gemini.j$edge_diffs, edges1 = gemini, edges2 = j.clean) %>% mutate(coder1 = "Gemini", coder2 = "TE1")
gemini.s.disagree <- og_edge_conflicts(cmp.gemini.s$edge_diffs, edges1 = gemini.clean, edges2 = s.clean) %>% mutate(coder1 = "Gemini", coder2 = "TE2")
gpt.j.disagree <- og_edge_conflicts(cmp.gpt.j$edge_diffs, edges1 = gpt.clean, edges2 = j.clean) %>% mutate(coder1 = "GPT", coder2 = "TE1")
gpt.s.disagree <- og_edge_conflicts(cmp.gpt.s$edge_diffs, edges1 = gpt.clean, edges2 = s.clean) %>% mutate(coder1 = "GPT", coder2 = "TE2")
gpt.gemini.disagree <- og_edge_conflicts(cmp.gpt.gemini$edge_diffs, edges1 = gpt.clean, edges2 = gemini.clean) %>% mutate(coder1 = "GPT", coder2 = "Gemini")


all.disagree <- bind_rows(j.s.disagree, gemini.j.disagree, gemini.s.disagree, gpt.j.disagree, gpt.s.disagree, gpt.gemini.disagree) %>% mutate(error_ambiguity = NA_character_, 
                                                                                                                                              who_error = NA_character_, 
                                                                                                                                              supp_quote1 = NA_character_, 
                                                                                                                                              supp_quote2 = NA_character_)

# writexl::write_xlsx(all.disagree, "../disagreement_classification/belmonte_disagreement.xlsx")
# writexl::write_xlsx(all.disagree, "../disagreement_classification/baron_cohen_disagreement.xlsx")
# writexl::write_xlsx(all.disagree, "../disagreement_classification/gepner_disagreement.xlsx")
