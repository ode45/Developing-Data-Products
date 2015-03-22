shinyUI(pageWithSidebar(
  headerPanel("Predict the height of your child"),
  
  sidebarPanel(
    img(src="kids.jpg",width='100%'),
    h3(""),
    selectInput("malegender", "I have a", choices = c('Son'=1,'Daugther'=0)),
    selectInput("unitsCM", "I want to specify the units in", choices = c('Inches'=0,'Cm'=1)),
    conditionalPanel(condition="input.unitsCM==0",
      sliderInput("father", "Height father (inches):", min = 58, max = 79, value = 70, step= 0.5),
      sliderInput("mother", "Height mother (inches):", min = 58, max = 79, value = 67, step= 0.5)),
    conditionalPanel(condition="input.unitsCM==1",
      sliderInput("father_cm", "Height father (cm):", min = 150, max = 200, value = 180, step= 1),
      sliderInput("mother_cm", "Height mother (cm):", min = 150, max = 200, value = 170, step= 1)),    
    sliderInput("angle", "Viewing angle plot:", min = 0, max = 180, value = 45, step= 1) 
  ),
  mainPanel(
        
    h3('Results of prediction'),
 
    plotOutput("heightplot",height=550),
    
    h5('The data comes from', a('Galton\'s dataset', href='http://rgm3.lab.nig.ac.jp/RGM/R_rdfile?f=HistData/man/GaltonFamilies.Rd&d=R_CC'), 'this data set lists the individual observations for 934 children. The data points in blue are from sons, the ones in pink are from daughters. The surface plots with the corresponding colors have been fitted with a linear model that predicts the height of the child. The point highlighted in red indicates the prediction of your child.')
    
  )
))