rm(list = ls())

library(tidyverse)

df <- readxl::read_xlsx("../data/Ratings.xlsx")

df <- df %>% 
  mutate(Edge = case_when(Edge == "NA" ~ NA,
                          .default = Edge), 
         Fidelity = case_when(Fidelity == "NA" ~ NA,
                          .default = Fidelity)) %>% 
  mutate(across(Edge:Fidelity, as.numeric)) %>% 
  mutate(Encoder = case_when(Encoder == "Q23" ~ "TE1",
                                  Encoder == "Q29" ~ "UE1", 
                                  Encoder == "Q31" ~ "TE2",
                                  Encoder == "Q37" ~ "UE2",
                                  Encoder == 'Q03' ~ "Naive GPT",
                                  Encoder == "Q11" ~ "Engineered GPT",
                                  Encoder == "Q17" ~ "Naive Gemini",
                                  Encoder == "Q19" ~ "Engineered Gemini")) %>% 
  mutate(NaiveEngineered = case_when(str_detect(Encoder, "Naive") ~ "Naive",
                                     str_detect(Encoder, "Engineered") ~ "Engineered",
                                                .default = "Human")) %>% 
  mutate(TotalScore = rowMeans(across(c(Construct, Edge, Fidelity)), na.rm = TRUE)) %>% 
  mutate(Class = case_when(Encoder %in% c("UE1", "UE2") ~ "Untrained Human",
                           Encoder %in% c("TE1", "TE2") ~ "Trained Human",
                           str_detect(Encoder, "Naive") ~ "Naive",
                           str_detect(Encoder, "Engineered") ~ "Engineered")) %>% 
  mutate(TuringCorrect = case_when(NaiveEngineered %in% c("Naive", "Engineered") & HumanAI == "AI" ~ 1, 
                                   NaiveEngineered == "Human" & HumanAI == "Human" ~ 1, 
                                   .default = 0))  %>% 
  mutate(Class2 = case_when(Encoder %in% c("UE1", "UE2", "TE1", "TE2") ~ "Human",
                                       str_detect(Encoder, "Naive") ~ "LLM",
                                       str_detect(Encoder, "Engineered") ~ "LLM"))



df %>% group_by(Rater) %>% 
  summarize(construct = mean(Construct),
            edge = mean(Edge, na.rm = T), 
            fidelity = mean(Fidelity, na.rm = T),
            TotalScore = mean(TotalScore, na.rm = T)) %>% 
  arrange(desc(TotalScore))



df %>% group_by(Paper, Class2) %>% 
  #filter(Class == "Trained Human") %>% 
  summarize(construct = mean(Construct),
            edge = mean(Edge, na.rm = T), 
            fidelity = mean(Fidelity, na.rm = T),
            TotalScore = mean(TotalScore, na.rm = T)) %>% 
  arrange(Class2) 






df %>% group_by(NaiveEngineered) %>% 
  summarize(construct = mean(Construct),
            edge = mean(Edge, na.rm = T), 
            fidelity = mean(Fidelity, na.rm = T),
            TotalScore = mean(TotalScore, na.rm = T)) %>% 
  arrange(desc(TotalScore))

df %>% group_by(Class) %>% 
  summarize(construct = mean(Construct),
            edge = mean(Edge, na.rm = T), 
            fidelity = mean(Fidelity, na.rm = T),
            TotalScore = mean(TotalScore, na.rm = T)) %>% 
  arrange(desc(TotalScore))




scores_by_coder <- df %>% group_by(Encoder) %>% 
  summarize(construct = mean(Construct),
            edge = mean(Edge, na.rm = T), 
            fidelity = mean(Fidelity, na.rm = T),
            TotalScore = mean(TotalScore, na.rm = T)) %>% 
  arrange(desc(TotalScore))

# write.csv(scores_by_coder, "scores_by_coder.csv",row.names = F)


ggplot(df, aes(x = Rater, y = TotalScore)) +
  geom_point(size = 3) + 
  geom_boxplot() +
   theme_bw() +
  facet_wrap(~Paper)



library(lme4)
library(lmerTest)
model <- lmerTest::lmer(TotalScore ~ Encoder + (1 | Rater), data = df)
summary(model)


model <- lmerTest::lmer(TotalScore ~ NaiveEngineered + (1 | Rater), data = df %>% filter(NaiveEngineered %in% c("Naive", "Engineered")))
summary(model)
.6718/(.6718+.3433)


model <- lmerTest::lmer(TotalScore ~ Class + (1 | Rater), data = df %>% filter(Class %in% c("Trained Human", "Untrained Human")))
summary(model)
.6821/(.6821/.6821+.4416)

model <- lmerTest::lmer(TotalScore ~ Class + (1 | Rater), data = df)
summary(model)


model <- lmerTest::lmer(TotalScore ~ Class2 + (1 | Rater), data = df %>% filter(Class %in% c("Trained Human", "Naive")))
summary(model)



model <- lmerTest::lmer(TotalScore ~ Class + (1 | Rater), data = df)
anova(model, ddf = "Kenward-Roger")
summary(model)
.6067/(.6067+.4316)

emm <- emmeans::emmeans(model, ~ Class)

emmeans::contrast(emm, method = list(
  "Engineered - Naive" = c(1,-1,0,0),
  "Trained Human - Untrained Human" = c(0,0,1,-1),
  "Trained Human - Naive" = c(0,-1,1,0)
  ), adjust = "holm"
)

# df %>% group_by(Encoder) %>% 
#   summarize(correct = sum(TuringCorrect)) %>% 
#   arrange(desc(correct))
# 
# df %>% group_by(Rater) %>% 
#   summarize(correct = sum(TuringCorrect)) %>% 
#   arrange(desc(correct))
