#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from https://www.voterstudygroup.org/downloads?key=bdb6ff88-27ff-444c-bac1-f8f7c7e87c41
# Author: Xinyi Xu [Add to this!!!]
# Data: 30 October 2020
# Contact: tiffanyandjojo.xu@mail.utoronto.ca [Add to this!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
setwd("~/Desktop/脑残/STA304/A3")
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625/ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(interest,
         registration,
         vote_2016,
         vote_intention,
         vote_2020,
         ideo5,
         employment,
         foreign_born,
         gender,
         census_region,
         hispanic,
         race_ethnicity,
         household_income,
         education,
         state,
         congress_district,
         age)


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?
reduced_data<-
  reduced_data %>%
  filter(vote_2020 != "I would not vote" ) %>% 
#  filter(vote_2020 != "I am not sure/don't know") %>% 
  mutate(vote_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0)) %>% 
  mutate(vote_biden = 
           ifelse(vote_2020=="Joe Biden", 1, 0)) %>% 
  mutate(vote_not_sure = 
           ifelse(vote_2020 == "I am not sure/don't know",1,0))

# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "survey_data.csv")

