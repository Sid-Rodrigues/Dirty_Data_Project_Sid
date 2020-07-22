
library(readxl)
library(readr)
library(dplyr)
library(here)
library(tidyverse)


# Read in xlsx file

sheet1 <- read_xlsx(here("raw_data/boing-boing-candy-2015.xlsx"))
sheet1


# Inspect the data i.e. dimensions, variable types, variable names, etc.?

dim(sheet1)
colnames(sheet1)
glimpse(sheet1)


# Tidy data - long format

sheet1_long <- sheet1 %>%
  pivot_longer(cols = starts_with("["),  #converting rows to columns 
               names_to = "candy",
               values_to = "rating")


#check dimensions, column names

dim(sheet1_long)
colnames(sheet1_long)


#Omitting columns that are not required

sheet1_long <- sheet1_long %>%
  select(-c(4:29))


#check dimensions, column names

colnames(sheet1_long)
dim(sheet1_long)


#Change column names

colnames(sheet1_long) <- c("timestamp", "age", "going_out", "candy", "rating")
colnames(sheet1_long)


#Add column 'year'

sheet1_long <- sheet1_long %>%
  add_column(year = 2015)
head(sheet1_long)

#x x x x x x x x x x x x x x x x x x x x x x x x x 

# Read in xlsx file

sheet2 <- read_xlsx(here("raw_data/boing-boing-candy-2016.xlsx"))
sheet2


# Inspect the data i.e. dimensions, variable types, variable names, etc.?

dim(sheet2)
colnames(sheet2)
glimpse(sheet2)


# Tidy data - long format

sheet2_long <- sheet2 %>%
  pivot_longer(cols = starts_with("["),  #converting rows to columns 
               names_to = "candy",
               values_to = "rating")


##check dimensions, column names
dim(sheet2_long)
colnames(sheet2_long)


#Omitting columns that are not required

sheet2_long <- sheet2_long %>%
  select(-c(6:22))


#check dimensions, column names

colnames(sheet2_long)
dim(sheet2_long)


#Change column names

colnames(sheet2_long) <- c("timestamp", "going_out", "gender", "age", "country", "candy", "rating")
colnames(sheet2_long)


#Add column 'year'

sheet2_long <- sheet2_long %>%
  add_column(year = 2016)
head(sheet2_long)


#x x x x x x x x x x x x x x x x x x x x x x x x x x x x x 

# Read in xlsx file

sheet3 <- read_xlsx(here("raw_data/boing-boing-candy-2017.xlsx"))
sheet3


# Inspect the data i.e. dimensions, variable types, variable names, etc.?

dim(sheet3)
colnames(sheet3)
glimpse(sheet3)


# Tidy data - long format

sheet3_long <- sheet3 %>%
  pivot_longer(cols = starts_with("Q6"),  #converting rows to columns 
               names_to = "candy",
               values_to = "rating")
colnames(sheet3_long)


#Omitting columns that are not required

sheet3_long <- sheet3_long %>%
  select(-c(6:17))


#check dimensions, column names

colnames(sheet3_long)
dim(sheet3_long)


#Change col names

colnames(sheet3_long) <- c("internal_id", "going_out", "gender", "age", "country", "candy", "rating")
colnames(sheet3_long)


#Add column 'year'

sheet3_long <- sheet3_long %>%
  add_column(year = 2017)
head(sheet3_long)


# X X X X X X X X X X X X X X X X X X - - - - - - - - - - - X X X X X X X X X X X X X X X X X 

# Combine all sheets 

candy_combined <- bind_rows(sheet1_long, sheet2_long, sheet3_long)


#check dimensions, column names

colnames(candy_combined)
dim(candy_combined)
head(candy_combined)


#Write to csv file - initial iteration of data cleaning

write_csv(candy_combined, "raw_data/candy_combined.csv")

