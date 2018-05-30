library(dplyr)
library(shiny)

source("analysis.R")
csa_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = F)

server <- function(input, output) {
  output$Birthrate_difference = renderDataTable({
    new_data_set
    
  })
  output$Background_Info = renderText({
    "This table shows the difference in birth rates in U.S. counties that increased from 2015 to 2017.
    The Percentage of U.S. counties that had an increase in birth rate from 2015 to 2017 is 36.867%"
  })
}

shinyServer(server)
