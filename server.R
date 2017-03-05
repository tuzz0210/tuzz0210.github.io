#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(e1071)

# Define server logic required to draw a histogram

shinyServer(function(input, output) {
    name<-c("The length of Sepal","The width of Sepal","The length of Petal","The width of Petal")
    id<-reactive({
        index<-c()
        for(j in input$predictor){
            index<-c(index,which(j==name))
        }
        if(length(index)>=2)
            index
        else
            c(3,4)
        
    })
    dd<-reactive({data.frame(p1=iris[[id()[1]]],p2=iris[[id()[2]]],iris[5])})
    #names(dd)<-c("p1","p2","Species")
    value<-reactive({c(input$lsepal,input$wsepal,input$lpetal,input$wpetal)})
    sv<-reactive({svm(Species~p1+p2,data=dd(),cross=5)})
    modelpre<-reactive({
        predict(sv(),data.frame(p1=value()[id()[1]],p2=value()[id()[2]]))
    })
    cc<-c("black","red","green")
    
    output$speciesPlot <- renderPlot({
        if(input$showline){
            plot(sv(),dd(),xlab=input$predictor[2],ylab=input$predictor[1])
        }
        else{
            plot(dd()$p2,dd()$p1,xlab=input$predictor[2],ylab=input$predictor[1],col=dd()$Species)
            legend(2,3,levels(dd()$Species),col=c("black","red","green"),pch=1,bty="n",cex=1.2)
        }
        points(value()[id()[2]],value()[id()[1]],pch="+",col=cc[modelpre()],cex=2)
  })
    output$pred<-renderText({
        levels(dd()$Species)[modelpre()]
        
    })
    output$eda<-renderPlot({
        pairs(iris[,1:4],col=iris$Species)
    })
    output$data<-renderDataTable(iris)
    
    
  
  
})
