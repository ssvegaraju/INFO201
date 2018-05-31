all_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = FALSE)

# View(all_data)

library(dplyr)

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

