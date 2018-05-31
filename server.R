library(dplyr)
<<<<<<< HEAD
=======
library(ggplot2)
library(plotly)
>>>>>>> d27fd3740c28b6173e00692259fe75661245c7e4
library(shiny)

source("analysis.R")
csa_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = F)

<<<<<<< HEAD
server <- function(input, output) {
  output$Birthrate_difference = renderDataTable({
    new_data_set
    
  })
  output$Background_Info = renderText({
    "This table shows the difference in birth rates in U.S. counties that increased from 2015 to 2017.
    The Percentage of U.S. counties that had an increase in birth rate from 2015 to 2017 is 36.867%"
=======
cols_of_interest <- c("DEATHS2010", "DEATHS2011", "DEATHS2012", "DEATHS2013",
                      "DEATHS2014", "DEATHS2015", "DEATHS2016", "DEATHS2017",
                      "NETMIG2010", "NETMIG2011", "NETMIG2012", "NETMIG2013",
                      "NETMIG2014", "NETMIG2015", "NETMIG2016", "NETMIG2017")

server <- function(input, output) {
  relevant_data <- reactive({
    relevant_data <- csa_data %>%
      filter(NAME == input$region) %>% select(cols_of_interest)
    deaths <- relevant_data[,grepl("DEATH", colnames(relevant_data))]
    migs <- relevant_data[,grepl("MIG", colnames(relevant_data))]
    names(deaths) <- NULL
    names(migs) <- NULL
    deaths <- unlist(deaths)
    migs <- unlist(migs)
    years <- seq(2010, 2017, 1)
    
    
    relevant_data <- data.frame("Year" = years, "Deaths" = deaths, 
                                "Migrations" = migs)
    relevant_data
  })
  
  output$plot_migration <- renderPlotly({
    p <- plot_ly(data = relevant_data(),
              x = ~Year,
              y = ~Deaths,
              type = "scatter",
              mode = "lines+markers",
              name = "Deaths") %>% 
      add_trace(x = ~Year,
                y = ~Migrations,
                type = "scatter",
                mode = "lines+markers",
                name = "Migrations") %>% 
      layout(
        title = paste("Deaths vs. Migration for", input$region),
        xaxis = list(title = "Year", rangeslider = list(type = "date")),
        yaxis = list(title = "Number of People"))
    p
  })
  
  output$description <- renderText({
    data <- relevant_data()
    r <- round(cor(data$Deaths, data$Migrations), 4)
    str <- paste0("The correlation coefficient between Deaths and Migrations ",
                  "for <em>", input$region, "</em> is <b>", r, "</b>.")
    if (r > 0.5) {
      str <- paste0(str, " This implies that there is a <b>decently strong</b>",
                    " positive linear relationship between Deaths and",
                    " Migrations for this region. That is, as deaths grow, so",
                    " do migrations to the area.")
    } else if (r < -0.5) {
      str <- paste0(str, " This implies that there is a <b>decently strong</b>",
                    " negative linear relationship between Deaths and", 
                    " Migrations for this region. That is, as deaths grow,",
                    " Migrations to that area decrease."
                    )
    } else{
      str <- paste0(str, " This implies that there is a <b>very weak</b>", 
                    " correlation between Deaths and Migrations for this", 
                    " region. Deaths do not affect Migrations for this area.")
    }
    str
  })
  
  output$goal <- renderText({
    str <- paste0("The goal of this visualization is to find if migrations",
                  " to/from an area are affected by or effect deaths for that",
                  " area. For example, if illegal migration to an area brings",
                  " a higher death rate to that area. Data is sourced from ",
                  " <a href='https://www.census.gov/data/datasets/2017/demo/popest/total-metro-and-micro-statistical-areas.html'>here</a>",
                  " <hr>")
  })
  
  frame_both_states <- reactive({
    both_states_finally(input$first_state, input$second_state)
  })
  
  output$plot <- renderPlotly({
    plot_ly(data = frame_both_states(),
            x = ~years, y = ~first_state,
            type = "scatter",
            mode = "lines+markers",
            name = input$first_state 
    ) %>%
      add_trace(
        x = ~years, y = ~second_state,
        type = "scatter",
        mode = "lines+markers",
        name = input$second_state 
      )
    
  })
  
  output$plot_description <- renderText({
    if (input$first_state != input$second_state) {
      my_data <- frame_both_states()
      r <- round(cor(my_data$first_state, my_data$second_state), 4)
      
      starter_sentence <- paste0("The correlation coefficent between ", input$first_state, " and ",
                                 input$second_state, " is ", r
      )
      
      if (r < -0.5) {
        starter_sentence <- paste0(
          starter_sentence, " There is an implication of a negative linear relationship between 
          the deaths of both states. As one goes up the other goes down."
        )
        
      } else if (r > 0.5) {
        starter_sentence <- paste0(
          starter_sentence, " There is an implication of a positive linear relationship between 
          the deaths of both states. As one goes up both go up or down."
        )
        
      } else {
        starter_sentence <- paste0(starter_sentence, " There is just a weak correlation between both state")
      }
    } else {
      "Choose two diffrent states"
    }
>>>>>>> d27fd3740c28b6173e00692259fe75661245c7e4
  })
}

shinyServer(server)
