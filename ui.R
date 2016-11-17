# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

alergieTags <- c("Milk", "Wheat","Soya","Egg","Butter","Lactose","Gluten","Moutarde","Tuna","Oats","Fish","Salmon")


shinyUI(fluidPage(
  #import css
  includeCSS("www/style.css"),
  
  # Application title
  titlePanel("Food Data"),

  # Sidebar
  sidebarLayout(
    sidebarPanel(
    checkboxGroupInput("variable", "Allergieen",
                       alergieTags)
    ,width = 2),

    # main Panel with tabs
    mainPanel(
      tabsetPanel(
        tabPanel("Intro", 
                 htmlOutput("intro")),
        
        tabPanel("type keuken met meeste allergieen", 
                 textOutput("percentage"),
                 plotOutput("distPlot"),
                 "http://world.openfoodfacts.org/data"),
        
        tabPanel("verzameling allergien","Het laden van de wordcloud kan even duren door de vele gerechten" ,
                 plotOutput("wordcloud"),
                  "Wanneer de wordcloud geladen is zal je verschillende woorden in andere talen dan
                  engels tegen komen. Dat komt doordat de data set veel verschillende talen bevat."
                 ),
        
        tabPanel("percentage van allergieen" ,"Het laden van de tabel kan even duren door de vele gerechten",
                 tableOutput('tableAllergieen'),
                 " In de tabel hierboven kan je aflezen hoeveel procent van de gerechten niet gegeten kunnen worden als je bepaalde allergie hebt. 
                 Helaas is de dataset qua allergie niet volledig")
        )
      ,width = 9)
  )
))
