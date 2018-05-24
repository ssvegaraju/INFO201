library(dplyr)
library(ggplot2)
library(shiny)

all_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = FALSE)

# Did the deaths in Washington state affect deaths in Maine?
# adding traces and adding them to the same plot

# function takes a state as an argument
# finds death columns for that state
get_death_columns_state <- function(state) {
   specific_state <-  paste0(", ", state)
   print(specific_state)
   specific_data <- grepl(specific_state, all_data$NAME)
   specific_only <- all_data[specific_data, ]
   death <- select(specific_only, NAME,
                   DEATHS2010, DEATHS2012, DEATHS2013, DEATHS2014, DEATHS2015,
                   DEATHS2016, DEATHS2017)
}


# Washington data 
washington_data <- get_death_columns_state("WA")


# sums of each year 2010
washington_year2010_sum <- washington_data %>%
  summarize(
    sum_2010 = sum(DEATHS2010)
  )


# sums of each year 2012
washington_year2012_sum <- washington_data %>%
  summarize(
    sum_2012 = sum(DEATHS2012)
  )


# sums of each year 2013
washington_year2013_sum <- washington_data %>%
  summarize(
    sum_2013 = sum(DEATHS2013)
  )


# deaths of year 2014
washington_year2014_sum <- washington_data %>%
  summarize(
    sum_2014 = sum(DEATHS2014)
  )

# deaths of year 2015
washington_year2015_sum <- washington_data %>%
  summarize(
    sum_2015 = sum(DEATHS2015)
  )

# deaths of year 2016
washington_year2016_sum <- washington_data %>%
  summarize(
    sum_2016 = sum(DEATHS2016)
  )

# deaths of year 2017
washington_year2017_sum <- washington_data %>%
  summarize(
    sum_2017 = sum(DEATHS2017)
  )


washington_summed_up <- data.frame( name = "Washington",
                          washington_year2010_sum, 
                          washington_year2012_sum,
                          washington_year2013_sum,
                          washington_year2014_sum,
                          washington_year2015_sum,
                          washington_year2016_sum,
                          washington_year2017_sum
)

# Maine data
maine_data <- get_death_columns_state("ME") 

maine_year2010_sum <- maine_data %>%
  summarize(
    sum_2010 = sum(DEATHS2010)
  )

maine_year2012_sum <- maine_data %>%
  summarize(
    sum_2012 = sum(DEATHS2012)
  )

maine_year2013_sum <- maine_data %>%
  summarize(
    sum_2013 = sum(DEATHS2013)
  )

maine_year2014_sum <- maine_data %>%
  summarize(
    sum_2014 = sum(DEATHS2014)
  )

maine_year2015_sum <- maine_data %>%
  summarize(
    sum_2015 = sum(DEATHS2015)
  )

maine_year2016_sum <- maine_data %>%
  summarize(
    sum_2016 = sum(DEATHS2016)
  )

maine_year2017_sum <- maine_data %>%
  summarize(
    sum_2017 = sum(DEATHS2017)
  )

maine_summed_up <- data.frame(name = "Maine", maine_year2010_sum,
                          maine_year2012_sum,
                          maine_year2013_sum,
                          maine_year2014_sum,
                          maine_year2015_sum,
                          maine_year2016_sum,
                          maine_year2017_sum
)


# Data of Washington and Maine 
both_states <- full_join(washington_summed_up, maine_summed_up) 




# x will be year, facet by year 
# y amount of deaths by year













