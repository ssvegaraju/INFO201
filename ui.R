library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)

csa_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = F)

ui <- fluidPage(
  titlePanel("Immigration"),
  tabsetPanel(type = "tabs",
              tabPanel("Migration vs. Death Rates",
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("region", "Region:",
                                       unique(csa_data$NAME))
                         ),
                         mainPanel(htmlOutput("goal"),
                                   plotlyOutput("plot"),
                                   htmlOutput("description"))
                       )))
)

shinyUI(ui)