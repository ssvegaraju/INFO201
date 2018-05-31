library(dplyr)
library(ggplot2)
library(shiny)
library(reshape2)

all_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = FALSE)

# View(all_data)

#Birthrate difference from 2015-2017
all_data$birth_rate_diff <- (all_data$BIRTHS2017 - all_data$BIRTHS2015)

# View(all_data$birth_rate_diff)
# print(all_data$birth_rate_diff)

all_data$positive_diff <- (all_data$birth_rate_diff > 0)

# View(all_data)

increase_births <- filter(all_data, birth_rate_diff > 0)

new_data_set <- select(increase_births, NAME, LSAD, birth_rate_diff)

# View(new_data_set)

total_increase <- sum(new_data_set$birth_rate_diff > 0)

total_data <- sum(all_data$birth_rate_diff > -100000)

total_increase / total_data

# function takes a state as an argument
# finds death columns for that state
get_death_columns_state <- function(state) {
  specific_state <- paste0(", ", state)
  print(specific_state)
  specific_data <- grepl(specific_state, all_data$NAME)
  specific_only <- all_data[specific_data, ]
  death <- select(
    specific_only, NAME,
    DEATHS2010, DEATHS2011, DEATHS2012, DEATHS2013, DEATHS2014, DEATHS2015,
    DEATHS2016, DEATHS2017
  )
  death
}

# Washington data
washington_data <- get_death_columns_state("WA")

# function to grab any specific state
# in this case the first state
get_first_state <- function(first_state) {
  my_state <- get_death_columns_state(first_state)
  my_state
}

# first state call
test <- get_first_state("OR")

get_summarize_death_totals_two_states <- function(state_one) {
  first_choosen_state <- get_first_state(state_one)
  
  first_state_year2010_sum <- first_choosen_state %>%
    summarize(
      sum_2010 = sum(DEATHS2010)
    )
  
  first_state_year2011_sum <- first_choosen_state %>%
    summarize(
      sum_2011 = sum(DEATHS2011)
    )
  
  # sums of each year 2012
  first_state_year2012_sum <-  first_choosen_state %>%
    summarize(
      sum_2012 = sum(DEATHS2012)
    )
  
  first_state_year2013_sum <-  first_choosen_state %>%
    summarize(
      sum_2013 = sum(DEATHS2013)
    )
  
  first_state_year2014_sum <-  first_choosen_state %>%
    summarize(
      sum_2014 = sum(DEATHS2014)
    )
  
  first_state_year2015_sum <-  first_choosen_state %>%
    summarize(
      sum_2015 = sum(DEATHS2015)
    )
  
  first_state_year2016_sum <-  first_choosen_state %>%
    summarize(
      sum_2016 = sum(DEATHS2016)
    )
  
  first_state_year2017_sum <-  first_choosen_state %>%
    summarize(
      sum_2017 = sum(DEATHS2017)
    )
  
  first_state_summed_up <- data.frame(
    name = state_one,
    first_state_year2010_sum,
    first_state_year2011_sum,
    first_state_year2012_sum,
    first_state_year2013_sum,
    first_state_year2014_sum,
    first_state_year2015_sum,
    first_state_year2016_sum,
    first_state_year2017_sum
  )
  first_state_summed_up
}

# get's two state's information 
both_states_finally <- function(get_first, get_second) {
  first_first <- get_summarize_death_totals_two_states(get_first)
  second_second <- get_summarize_death_totals_two_states(get_second)
  both_states <- full_join(first_first, second_second)
  both_states <- both_states[, 2:ncol(both_states)]
  first_row <- both_states[1, ]
  second_row <- both_states[2, ]
  
  names(first_row) <- NULL
  names(second_row) <- NULL
  
  first_row <- unlist(first_row)
  second_row <- unlist(second_row)
  
  years <- seq(2010, 2017)
  
  final_frame <- data.frame("first_state" = first_row, "second_state" = second_row, "years" = years)
  final_frame
}