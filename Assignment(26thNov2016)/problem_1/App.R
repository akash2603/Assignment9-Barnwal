library(shiny)
library(babynames)
library(dplyr)
library(tidyr)
library(ggplot2)

View(babynames)

ui <- fluidPage(
  
  titlePanel("Baby Names"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearInput", 
                  "Year", 
                   min = 1880, 
                   max = 2014, 
                   value = c(1900, 2000)
      ),
      
      textInput("nameInput", "Name"),
                
      radioButtons("sexID", "Sex",  choices = c("Female only", "Male only", "Both"), selected = "Female only")),
    mainPanel(
      plotOutput("main_plot"),
      
      tableOutput("results")
    )
  )
  
)

server <- function(input, output, session) {
  reduced_df <- reactive({
    sex_vec <- switch(input$sexID,
                      `Female only` = "F",
                      `Male only` = "M",
                       Both = c("F", "M")
    )
    babynames$year<-as.integer(babynames$year)
    
    
    filter(
      babynames, 
      name == input$nameInput, 
      year >= input$yearInput[1] & year <= input$yearInput[2], 
      sex %in% sex_vec 
    )
  })
  
output$main_plot <- renderPlot({

    if(input$sexID == "Female only"){
     ggplot(data = reduced_df(), aes(year, n, colour = sex)) + geom_line() + ggtitle(input$nameInput) +
        scale_color_manual(values=c("#CC6666"))
    }
    

    else if(input$sexID == "Male only"){
    ggplot(data = reduced_df(), aes(year, n, colour = sex)) + geom_line() + ggtitle(input$nameInput) +
        scale_color_manual(values=c("#9999CC"))
      
    }
  
    else if(input$sexID == c("Both")){
      
  
      ggplot(data = reduced_df(), aes(year, n, colour = sex)) + geom_line() + ggtitle(input$nameInput) +
        scale_color_manual(values=c("#CC6666", "#9999CC"))
       }
   })




    
  
 output$results <- renderTable({ 
    
   if(input$sexID == "Female only"){
   reduced_df()
   }

   else if(input$sexID == "Male only"){
     reduced_df()
   }

   else if(input$sexID == c("Both")){

    abc <- spread(reduced_df(), sex, n)
    abc
   }
   
})
}

shinyApp(ui = ui, server = server)


