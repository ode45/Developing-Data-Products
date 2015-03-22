library(shiny)


library('scatterplot3d')
library('UsingR')
data(GaltonFamilies)

fit <- lm(formula = childHeight ~ mother + father + gender, data=GaltonFamilies)
colorSet <- c('deeppink2','dodgerblue4')

shinyServer(
  function(input, output) {
        
     output$heightplot <- renderPlot({
          
       
       if (input$unitsCM==1){
         cmf <- 2.54
         father_inch = input$father_cm/cmf
         mother_inch = input$mother_cm/cmf
         unit <- 'cm'
     }
       else{
         father_inch = input$father
         mother_inch = input$mother
         cmf <- 1    
         unit <- 'inches'
       }
     
     if (input$malegender==1) { 
       childg = 'son'
       childf = 'male'
     }
     else {
       childg = 'daughter'
       childf = 'female'
     }   
       newdata <- data.frame(father=father_inch,mother=mother_inch,gender=childf)
       childHeightHat <- predict(fit,newdata,interval='predict')*cmf   
       
  
       s3d <-scatterplot3d(GaltonFamilies$father*cmf,GaltonFamilies$mother*cmf,GaltonFamilies$childHeight*cmf,
                           angle=input$angle,
                           xlim=c(60, 75)*cmf,ylim=c(60,75)*cmf,zlim=c(60,75)*cmf,
                           xlab = paste("Height father (",unit,")", sep=""),
                           ylab = paste("Height mother (",unit,")", sep=""),
                           zlab = paste("Height child (",unit,")", sep=""),
                           main=paste("Your ", childg, " is predicted to be ", round(childHeightHat[1],1) ," ", unit, 
                                      ".\nThe 95% prediction interval is between ", round(childHeightHat[2],1), " and ", round(childHeightHat[3],1) ," ", unit ,sep=""),                           
                           color=colorSet[GaltonFamilies$gender])
       s3d$plane3d(fit$coefficients[1:3]*c(cmf, 1, 1), col = "pink")
       s3d$plane3d((fit$coefficients[1:3] + c(fit$coefficients["gendermale"], 0, 0))*c(cmf, 1, 1), col = "blue")
                             
       s3d$points3d(father_inch*cmf,mother_inch*cmf,childHeightHat[1],col='red',pch=20,cex=3)        
    })
    
   

  })
