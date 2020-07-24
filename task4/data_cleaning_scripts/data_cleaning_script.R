
#1.4 Task 4 - Halloween Candy Data

library(readxl)
library(readr)
library(dplyr)
library(here)
library(tidyverse)
library(stringr)


# Read in xlsx file no. 1

sheet1 <- read_xlsx(here("raw_data/boing-boing-candy-2015.xlsx"))


# Tidy data - long format

sheet1_long <- sheet1 %>%
  pivot_longer(cols = starts_with("["),  #converting rows to columns 
               names_to = "candy",
               values_to = "rating")


#Omitting columns that are not required

sheet1_long <- sheet1_long %>%
  select(-c(4:29))


#Adding new column names

colnames(sheet1_long) <- c("timestamp", "age", "going_out", "candy", "rating")


#Add new column 'year'

sheet1_long <- sheet1_long %>%
  add_column(year = 2015)



# Read in xlsx file no. 2

sheet2 <- read_xlsx(here("raw_data/boing-boing-candy-2016.xlsx"))


# Tidy data - long format

sheet2_long <- sheet2 %>%
  pivot_longer(cols = starts_with("["),  #converting rows to columns 
               names_to = "candy",
               values_to = "rating")


#Omitting columns that are not required

sheet2_long <- sheet2_long %>%
  select(-c(6:22))


#Adding new column names

colnames(sheet2_long) <- c("timestamp", "going_out", "gender", "age", "country", "candy", "rating")


#Add column 'year'

sheet2_long <- sheet2_long %>%
  add_column(year = 2016)


# Read in xlsx file no. 3

sheet3 <- read_xlsx(here("raw_data/boing-boing-candy-2017.xlsx"))


# Tidy data - long format

sheet3_long <- sheet3 %>%
  pivot_longer(cols = starts_with("Q6"),  #converting rows to columns 
               names_to = "candy",
               values_to = "rating")


#Omitting columns that are not required

sheet3_long <- sheet3_long %>%
  select(-c(6:17))


#Change col names

colnames(sheet3_long) <- c("internal_id", "going_out", "gender", "age", "country", "candy", "rating")


#Add column 'year'

sheet3_long <- sheet3_long %>%
  add_column(year = 2017)

#X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X 

# Combine all sheets 

candy_combined <- bind_rows(sheet1_long, sheet2_long, sheet3_long)


#Changing column data type

candy_combined$age <- as.integer(candy_combined$age)
candy_combined$year <- as.integer(candy_combined$year)
candy_combined$internal_id <- as.integer(candy_combined$internal_id)


# remove age greater than 122

candy_combined <- candy_combined %>%
  filter(age <= 122)


# Change string values to lower case

candy_combined <- candy_combined %>%
  mutate_if(is.character, str_to_lower)


# Cleaning candy column

candy_combined <- candy_combined %>%
  mutate(candy = str_extract(candy, "[^\\[\\]]+"),
         candy = str_extract(candy, "[^q6 |]+[^|]+"))


#cleaning country column

canada_error <- c("can", "canada`")
uk_error <- c("endland", "england", "scotland", "u.k.", "united kindom", "united kingdom")
usa_error <- c("'merica", "america", "merica", "murica", "murrika", "n. america", "new jersey", "new york", "north carolina", "pittsburgh", 
               "the united states", "the united states of america", "the yoo ess of aaayyyyyy", "trumpistan", "u s", "u s a", "u.s.", "u.s.a.",  
               "unhinged states", "unied states", "unite states", "united  states of america", "united sates", "united staes", "united state", 
               "united statea", "united stated", "united states", "united states of america",
               "united statss", "united stetes", "united ststes", "unites states", "units states", "us", "us of a", "usa usa usa", "usa usa usa usa",
               "usa usa usa!!!!", "usa!", "usa! usa!", "usa! usa! usa!", "usa!!!!!!", "usa? hard to tell anymore..", "usaa", "usas", "usausausa",   
               "ussa")
candy_combined <- candy_combined %>%
  mutate(country = ifelse(country %in% canada_error, "canada", country),
         country = ifelse(country %in% uk_error, "uk", country),
         country = ifelse(country %in% usa_error, "usa", country))


# Cleaning candy column

candy_combined <- candy_combined %>%
  filter(candy != "cash, or other forms of legal tender")



#saving to new df
candy_clean <- candy_combined


#Write to csv file

write_csv(candy_clean, "../clean_data/candy_clean.csv")
