library(dplyr)
library(shiny)

csa_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = F)
source("analysis.R")

ui <- fluidPage(
  theme = "style.css",
  mainPanel(textOutput("Background_Info"), dataTableOutput("Birthrate_difference")
      
    )
  )


shinyUI(ui)
