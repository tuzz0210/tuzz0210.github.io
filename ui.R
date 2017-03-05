#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Iris Classification"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        checkboxGroupInput("predictor","Selecte Two Predictors:",choices = c("The length of Sepal","The width of Sepal","The length of Petal","The width of Petal"),selected = c("The length of Petal","The width of Petal")),
    
       conditionalPanel(
           condition="input.predictor.length<2",
           helpText("Please select two predictors from the four options above!")
       ),
       conditionalPanel(
           condition="input.predictor.length>=2",
           conditionalPanel(
               condition="'The length of Sepal'==input.predictor[0]||'The length of Sepal'==input.predictor[1]",
               sliderInput("lsepal",
                           "The length of Sepal:",
                           min = 4,
                           max = 9,
                           value = 5.1)),
           #checkboxInput("p1","Selected As a Predictor",value=F),
           conditionalPanel(
               condition="'The width of Sepal'==input.predictor[0]||'The width of Sepal'==input.predictor[1]",
               sliderInput("wsepal",
                           "The width of Sepal:",
                           min = 1.5,
                           max = 5,
                           value = 3.5)),
           #checkboxInput("p2","Selected As a Predictor",value=F),
           
           conditionalPanel(
               condition="'The length of Petal'==input.predictor[0]||'The length of Petal'==input.predictor[1]",
               sliderInput("lpetal",
                           "The length of Petal:",
                           min = 0.9,
                           max = 7,
                           value = 1.4)),
           #checkboxInput("p3","Selected As a Predictor",value=F),
           conditionalPanel(
               condition="'The width of Petal'==input.predictor[0]||'The width of Petal'==input.predictor[1]",
               sliderInput("wpetal","The width of Petal:", min=0.05, max=3, value=0.2)),
           #checkboxInput("p4","Selected As a Predictor",value=F),
           
           checkboxInput("showline","Show Classification Plot",value = FALSE)
       )
       
       
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       tabsetPanel(type="tabs",
                   #tabPanel("Predictors Selection",br(),h4("Below is the scatterplot of all attributes colored by Iris species. From the four attributes, We choose the best two predictors which could distinguish different points."),plotOutput("eda")),
                   tabPanel("Help",br(),
                            h3(strong("Instruction")),
                            p("The goal of my application is to predict the iris species according to your input. Note that there are four features: Sepal.Length, Sepal.Width, Patal.Length and Patal.Width which are the indictors of iris species.
                              "),
                            p("Before running this app, you need to choose two predictors from the four features by clicking the box on the left.",strong("Our app only works after choosing at least two features.")),
                            p("After you choose two features, two sliderinput will appear on the left according to what you have selected before. By moving the handle in the slider, you could control the input. Once the input is decided, the prediction results will be shown in ", strong("Our Prediction"),"tab"),
                            p("In",strong("Our Prediction"),"tab, you could see the scatterplot of two predictors you have choosed colored by iris species and the predicted iris species for your input. Our prediction is based on the support vector machine algorithm, and training set is taken from the iris dataset in",strong("R"),". The data is given in", strong("Data"),"tab."),
                            p(strong("Hint:"),"if you click", strong("show Classification Plot"), "box below the slider in the left, the scatterplot in", strong("Our Prediction"),"tab will be replaced by the SVM Classification Plot which describes how our algorithm predicts iris species")),
                   tabPanel("Data",br(),
                             #h4("Our training set is from the Iris dataset in R"),
                            dataTableOutput("data")
                            ),
                   tabPanel("Our Prediction",br(),
                            conditionalPanel(
                            condition="input.predictor.length>=2",
                            p("Below is the scatterplot of two predictors you have choosed colored by iris species where", code("black"),"represents",code("setosa"),",", code("red"), "represents", code("versicolor"), "and", code("green"), "represents", code("virginica"),". The point which is marked as", code("+"), " in the figure is your input."),
                            
                            plotOutput("speciesPlot"),
                            h2("Predicted iris species:"),
                            h3(textOutput("pred"))))
                  
                   )
                   
      
       
    ))
  ))

