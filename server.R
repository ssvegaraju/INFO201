library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
library(plotly)

source("analysis.R")


server <- function(input, output) {
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
  })
  
}

# shiny server
shinyServer(server) 

