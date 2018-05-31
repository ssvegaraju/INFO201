library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)
library(DT)
source("analysis.R")

csa_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = F)


states <- state.abb[state.abb != "AK" & state.abb != "WY" & state.abb != "HI" &
  state.abb != "VT"
& state.abb != "MT"]

source("analysis.R")
states <- state.abb[state.abb != "AK" & state.abb != "WY" & state.abb != "HI" &
  state.abb != "VT"
& state.abb != "MT"]

ui <- fluidPage(
  theme = "style.css",
  tabsetPanel(
    type = "tabs",
    tabPanel(
      "Migration vs. Death Rates", titlePanel("Immigration"),
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "region", "Region:",
            unique(csa_data$NAME)
          )
        ),
        mainPanel(
          htmlOutput("goal"),
          plotlyOutput("plot_migration"),
          htmlOutput("description")
        )
      )
    ),
    tabPanel(
      "Birthrate Difference",
      titlePanel("Difference between Birthrates"),

      mainPanel(
        textOutput("background_Info"),
        dataTableOutput("birthrate_difference")
      )
    ),
    tabPanel(
      "Deaths Between Two States",
      titlePanel("Choose two states"),
      p("This plot shows the correlation of deaths between two states in the United States."),

      sidebarLayout(
        sidebarPanel(
          selectInput("first_state", "First State", states),
          selectInput("second_state", "Second State", states)
        ),

        mainPanel(
          plotlyOutput("plot"),
          htmlOutput("plot_description")
        )
      )
    )
  ),
  tabPanel(
    "About",
    titlePanel("Information about the data"),
    p("The title of the Data set is part of the American FactFinder II, 
        a large set of datasets and tables surveyed from the US population.
        This data (found on this  site ,  here ) comes directly from the Bureau of the Census in the US Department of Commerce. 
        It describes many different aspects of American populations,
        including but not limited to: Births, Deaths, Immigration, Migration, Total Populations, etc. 
        With this diverse spread of data, there are many facets of populations that can be analyzed."),
    h3("Project Goal"),
    p("To analyze immigration data sets and see how migration to and from areas affect other statistical data
        about that are"),
    h3("Technical Description"),
    HTML(" <ul>
               <li> 
                    dplyr - A fast, consistent tool for working with data frame
                    like objects, both in memory and out of memory. 
                </li>
                <li> 
                      Shiny - Package that makes it easy to build interactive web
                      apps straight from R. 
                </li>
                <li> ggplot2 - Data visualization package for R. </li>
                <li> 
                    Plotly - Library makes interactive, publication-quality 
                     graphs with R. 
                </li>
            </ul>
           "),
    h3("Team members"),
    HTML("<ul>
            <li>Sukeerth Vegaraju - Worked on 'Deaths vs. Migrations'</li> 
            <li>Roger Benjume - Worked on 'Deaths Between Two States'</li>
            <li>Kyle McCune - Worked on 'Birthrate Diffrence'</li>
         </ul>
         ")
  )
)



shinyUI(ui)
