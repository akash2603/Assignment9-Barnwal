library(shiny)
library(gapminder)
library(ggplot2)
library(dplyr)
data(gapminder)



ui <- fluidPage(
  
  titlePanel("PerCapita GDP vs Life Expectancy"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearInput", 
                  "Year", 
                  min = 1952, 
                  max = 2007, 
                  value = c(1980, 2000)
      ),
      textInput("nameInput", "Country_Name")),
      
      mainPanel(
        plotOutput("main_plot"),
        tableOutput("results")
      )
   )
)
server <- function(input, output, session) {
  reduced_df <- reactive({
    
    gapminder$gdpPercap<-log10(gapminder$gdpPercap)
    
    filter(
      gapminder, 
      country == input$nameInput, 
      year >= input$yearInput[1] & year <= input$yearInput[2]
      
    )
  })
  
  output$main_plot <- renderPlot({
    ggplot(data = reduced_df(), aes(lifeExp, gdpPercap, colour = country)) + geom_point() + geom_smooth() +
      ggtitle("PerCapita GDP vs Life Expectancy")
  })
  
  output$results <- renderTable({ 
    reduced_df()
    
  })
}


shinyApp(ui = ui, server = server)