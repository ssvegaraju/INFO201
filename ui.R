library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
library(plotly)

source("analysis.R")


states <- state.abb[state.abb != 'AK' & state.abb != 'WY' & state.abb != 'HI' &
                    state.abb != 'VT' 
                    & state.abb != 'MT']

ui <- fluidPage(
  theme = "style.css",
  titlePanel("Choose two states"),
  p("The is data frame shows the correlation of deaths between two states in the United States.
    "),
    
  sidebarLayout(
    selectInput("first_state", "First State", states),
    selectInput("second_state", "Second State", states)
  ),
  
  mainPanel(
    plotlyOutput("plot"),
    htmlOutput("plot_description")
    
    
  )
)

shinyUI(ui)

