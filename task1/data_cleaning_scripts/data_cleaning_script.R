
#1.1 Task 1 - Decathlon Data

library(readr)
library(dplyr)

#Load the data
decathlon <- read_rds("raw_data/decathlon.rds")
decathlon

#1.1.1 Cleaning data
class(decathlon)
head(decathlon)
names(decathlon)
dim(decathlon)
glimpse(decathlon)

#This data has row names!

rownames(decathlon)

#To get rid of rownames, use function rownames_to_column() from the package 'tibble'
#Create new data frame with new variable 'name' as its first column
#Keep original data file 'decathlon' in folder
library(tibble)
new_decathlon <- decathlon %>% 
  rownames_to_column("name")
  


#Check column names

colnames(new_decathlon)
glimpse(new_decathlon)

#This data isn't tidy. Names column has mix values; upped and lower case. 
#Using mutate/ str_to_lower() to convert values to lower case
#Using clean_names function from package 'janitor'
#At the same time, change values of 'name' column to lower case

library(janitor)
decathlon_clean <- new_decathlon %>%
  clean_names() %>%
  mutate(name = str_to_lower(name), competition = str_to_lower(competition))
  

decathlon_clean <- decathlon_clean %>%
  pivot_longer(cols = "x100m":"x1500m",
               names_to = "events",
               values_to = "result")

decathlon_clean
#Checks
#names(decathlon_clean)
#decathlon_clean
#glimpse(decathlon_clean)
#distinct(decathlon_clean, names)
#nrow(decathlon_clean)





#Write this cleaned dataset to a csv file in the clean_data folder. 

write_csv(decathlon_clean, "clean_data/decathlon_clean.csv")

