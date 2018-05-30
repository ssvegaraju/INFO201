library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)

csa_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = F)
source("analysis.R")
states <- state.abb[state.abb != 'AK' & state.abb != 'WY' & state.abb != 'HI' &
                      state.abb != 'VT' 
                    & state.abb != 'MT']

ui <- fluidPage(
  theme = "style.css",
  tabsetPanel(type = "tabs",
              tabPanel("Migration vs. Death Rates", titlePanel("Immigration"),
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("region", "Region:",
                                       unique(csa_data$NAME))
                         ),
                         mainPanel(htmlOutput("goal"),
                                   plotlyOutput("plot_migration"),
                                   htmlOutput("description"))
                       )),
              tabPanel("Deaths Between Two States",
                       titlePanel("Choose two states"),
                       p("This plot shows the correlation of deaths between two states in the United States.
    "),
                       
                       sidebarLayout(
                         selectInput("first_state", "First State", states),
                         selectInput("second_state", "Second State", states)
                       ),
                       
                       mainPanel(
                         plotlyOutput("plot"),
                         htmlOutput("plot_description")
                         
                         
                       )))
)

shinyUI(ui)
