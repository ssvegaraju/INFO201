library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)
csa_data <- read.csv("csa-est2017-alldata.csv", stringsAsFactors = F)

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
  })
  output$plot <- renderPlotly({
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
}

shinyServer(server)