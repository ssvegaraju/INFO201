library(dplyr)
library(ggplot)




all_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = FALSE)


# Question is did the deaths in Washington affect deaths in Maine?


# Washington data 
washington_data <- get_death_columns_state("WA")

# main data
maine_data <- get_death_columns_state("ME")



# function takes a state as an argument
# lookf for death columns of that state
get_death_columns_state <- function(state) {
   specific_state <-  paste0(", ", state)
   print(specific_state)
   specific_data <- grepl(specific_state, all_data$NAME)
   specific_only <- all_data[specific_data, ]
   death <- select(specific_only, NAME,
                   DEATHS2010, DEATHS2012, DEATHS2013, DEATHS2014, DEATHS2015,
                   DEATHS2016, DEATHS2017)
   death
}







# one for washington deaths for each stat columns
