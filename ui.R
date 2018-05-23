library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)

csa_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = F)

ui <- fluidPage(
  titlePanel("Immigration"),
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel("Migration vs. Death Rates",
                         sidebarLayout(
                           sidebarPanel(
                             selectInput("region", "Region:",
                                         unique(csa_data$NAME))
                           ),
                           mainPanel()
                         )))
  )
)

shinyUI(ui)