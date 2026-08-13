setwd("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/Json")
rm(list = ls())
source("../code/cleaning_functions.R")

diffs.belmonte <- readxl::read_xlsx("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/disagreement_classification/belmonte_disagreement_categorized_SM_8_12_26.xlsx")


diffs.belmonte <- diffs.belmonte  %>% 
  mutate(attributed_graph = case_when(attributed_graph == "j" ~ "TE1", 
                                      attributed_graph == "s" ~ "TE2",
                                      attributed_graph == "gpt" ~ "GPT",
                                      attributed_graph == "gemini" ~ "Gemini",
                                      .default = attributed_graph))

# how do i code if both halves of the loop are errors? both and both? ....
## RESOLVE

diffs.belmonte <- diffs.belmonte %>% 
  mutate(error_type = case_when(attributed_graph == who_error ~ "Commission", 
                                attributed_graph != who_error & who_error!= "ambiguity" ~ "Omission",
                                attributed_graph == "both" & who_error!= "ambiguity" ~ "Commission",
                                      .default = NA)) %>% 
  mutate(theory = "Belmonte")


# ADD IN COMMISSION / OMISSION USING diffs$attributed_graph

errors_per_person.belmonte <- diffs.belmonte %>% group_by(error_type, who_error) %>% count() %>%
  filter(!who_error %in% c("ambiguity", "trivial")) %>% 
  pivot_wider(
    names_from  = error_type,
    values_from = n,
    values_fill = 0
  ) %>%
  mutate(theory = "Belmonte")
  




diffs.baroncohen <- readxl::read_xlsx("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/disagreement_classification/baron_cohen_disagreement_categorized_SM_8_12_26.xlsx")


diffs.baroncohen <- diffs.baroncohen  %>% 
  mutate(attributed_graph = case_when(attributed_graph == "j" ~ "TE1", 
                                      attributed_graph == "s" ~ "TE2",
                                      attributed_graph == "gpt" ~ "GPT",
                                      attributed_graph == "gemini" ~ "Gemini",
                                      .default = attributed_graph))

# how do i code if both halves of the loop are errors? both and both? ....
## RESOLVE

diffs.baroncohen <- diffs.baroncohen %>% 
  mutate(error_type = case_when(attributed_graph == who_error ~ "Commission", 
                                attributed_graph != who_error & who_error!= "ambiguity" ~ "Omission",
                                attributed_graph == "both" & who_error!= "ambiguity" ~ "Commission",
                                .default = NA)) %>% 
  mutate(theory = "baroncohen")


# ADD IN COMMISSION / OMISSION USING diffs$attributed_graph

errors_per_person.baroncohen <- diffs.baroncohen %>% group_by(error_type, who_error) %>% count() %>%
  filter(!who_error %in% c("ambiguity", "trivial")) %>% 
  pivot_wider(
    names_from  = error_type,
    values_from = n,
    values_fill = 0
  ) %>%
  mutate(theory = "Baron-Cohen")


diffs.gepner <- readxl::read_xlsx("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/disagreement_classification/gepner_disagreement_categorized_SM_8_12_26.xlsx")


diffs.gepner <- diffs.gepner  %>% 
  mutate(attributed_graph = case_when(attributed_graph == "j" ~ "TE1", 
                                      attributed_graph == "s" ~ "TE2",
                                      attributed_graph == "gpt" ~ "GPT",
                                      attributed_graph == "gemini" ~ "Gemini",
                                      .default = attributed_graph))

# how do i code if both halves of the loop are errors? both and both? ....
## RESOLVE

diffs.gepner <- diffs.gepner %>% 
  mutate(error_type = case_when(attributed_graph == who_error ~ "Commission", 
                                attributed_graph != who_error & who_error!= "ambiguity" ~ "Omission",
                                attributed_graph == "both" & who_error!= "ambiguity" ~ "Commission",
                                .default = NA)) %>% 
  mutate(theory = "Gepner")


# ADD IN COMMISSION / OMISSION USING diffs$attributed_graph

errors_per_person.gepner <- diffs.gepner %>% group_by(error_type, who_error) %>% count() %>%
  filter(!who_error %in% c("ambiguity", "trivial")) %>% 
  pivot_wider(
    names_from  = error_type,
    values_from = n,
    values_fill = 0
  ) %>%
  mutate(theory = "Gepner")






errors <- bind_rows(errors_per_person.belmonte, errors_per_person.baroncohen, errors_per_person.gepner)
diffs.full <- bind_rows(diffs.belmonte, diffs.baroncohen, diffs.gepner)

#writexl::write_xlsx(errors, "../disagreement_classification/errors_classified_SM_8_13_26.xlsx")
#writexl::write_xlsx(diffs.full, "../disagreement_classification/differences_classified_SM_8_13_26.xlsx")


#diffs.full <- readxl::read_xlsx("../disagreement_classification/differences_classified_SM_8_13_26.xlsx")
#errors <- readxl::read_xlsx("../disagreement_classification/errors_classified_SM_8_13_26.xlsx")


diffs.full %>% distinct(from, to, who_error, .keep_all = TRUE) %>% group_by(error_type, who_error) %>% count() %>%
  filter(!who_error %in% c("ambiguity", "trivial")) %>% 
  pivot_wider(
    names_from  = error_type,
    values_from = n,
    values_fill = 0
  ) %>% rename(Coder = who_error)




diffs.full %>% distinct(from, to, .keep_all = TRUE) %>% filter(error_ambiguity == "ambiguity") %>%
  group_by(coder1, coder2) %>% 
  count() %>%
  rename(Ambiguities = n)


errors %>% group_by(who_error) %>% summarize(Commission = sum(Commission),
                                             Omission = sum(Omission))
