# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(tm)
library(SnowballC)
library(wordcloud)

foodData <- read.csv("foodData.csv")
# With the lines below i cleaned up the data for a faster response
#drops <- c("product_name","brands","origins","countries","ingredients_text","allergens","traces","main_category","image_url")
#foodData <- foodData[ ,(names(foodData) %in% drops)]
#write.csv(foodData,file = "foodData.csv")
#foodData.csv

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    # get te recepies with selected allergie
    allergie <- foodData[grep(paste(input$variable, collapse = "|"), foodData$allergens,ignore.case=TRUE), ]
    
    #calculate percentage
    (nrow(allergie) / nrow(foodData)) * 100
     t <- table(allergie$countries)

    barplot(head(t[order(t,decreasing=TRUE)], 6),main= "Top 6 kichtens containse allergie ingredients", 
            ylab="number of recepies",col=c("royalblue","palegreen","orangered","salmon","lightgoldenrod","olivedrab"))
  })
  
  # get totaal percentage you can eat save
  output$percentage<- renderText({
    getTotaalPercentage(input$variable)
  })
  
  # render the wordcloud of all allergies
  output$wordcloud <- renderPlot({
    wordcloud(getWordcloudVariable(), max.words = 100, scale=c(10,.8), random.order = FALSE,colors=brewer.pal(8, "Dark2"))
  })
  
  # render percentage table
  output$tableAllergieen <- renderTable(createPercentTable())
  
  # intro text
    output$intro <- renderUI({
      HTML(intro())
    })
})
