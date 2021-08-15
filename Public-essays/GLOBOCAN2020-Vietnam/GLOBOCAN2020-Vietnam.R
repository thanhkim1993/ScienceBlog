# Load the data
library(readr)
GLOBOCAN2020_Vietnam <- read_table2("D:/OneDrive - pnt.edu.vn/7Advocacy/Public-essays/GLOBOCAN2020-Vietnam/GLOBOCAN2020-Vietnam.txt")

# Highlight Liver Cancer
GLOBOCAN2020_Vietnam$liver = ifelse(GLOBOCAN2020_Vietnam$Cancer == "Liver",1,0)

# Incidence Ranking
library(ggplot2)
library(dplyr)
incidence_rank <- ggplot(data = GLOBOCAN2020_Vietnam, 
               aes(x=reorder(Cancer,-Incidence), 
                   y = Incidence, 
                   fill = liver))+
  geom_col() + 
  xlab("Cancer Organ") + ylab("Incidence (number of cases)") + 
  labs(
    title = "Number of Incident Cases by Cancer Site",
    subtitle = "GLOBOCAN 2020 - Vietnam") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.9), legend.position = "none") +
  geom_text(data = GLOBOCAN2020_Vietnam %>% filter(liver == 1),aes(y = Incidence + 1000, label = Incidence), hjust = 0.4 , colour = "black")


# Death Ranking
library(ggplot2)
library(dplyr)
death_rank <- ggplot(data = GLOBOCAN2020_Vietnam, 
                         aes(x=reorder(Cancer,-Death), 
                             y = Death, 
                             fill = liver))+
  geom_col() + 
  xlab("Cancer Organ") + ylab("Death (number of cases)") + 
  labs(
    title = "Number of Death by Cancer Site",
    subtitle = "GLOBOCAN 2020 - Vietnam") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.9), legend.position = "none") +
  geom_text(data = GLOBOCAN2020_Vietnam %>% filter(liver == 1),aes(y = Death + 1000, label = Death), hjust = 0.4 , colour = "black")

# 5-year prevalence Ranking
library(ggplot2)
library(dplyr)
prevalence_rank <- ggplot(data = GLOBOCAN2020_Vietnam, 
                     aes(x=reorder(Cancer,-Prevalence_per_100000), 
                         y = Prevalence_per_100000, 
                         fill = liver))+
  geom_col() + 
  xlab("Cancer Organ") + ylab("5-year prevalence (per 100,000)") + 
  labs(
    title = "5-year Prevalence by Cancer Site",
    subtitle = "GLOBOCAN 2020 - Vietnam") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.9), legend.position = "none") +
  geom_text(data = GLOBOCAN2020_Vietnam %>% filter(liver == 1),aes(y = Prevalence_per_100000 + 5, label = Prevalence_per_100000), hjust = 0.4 , colour = "black")
