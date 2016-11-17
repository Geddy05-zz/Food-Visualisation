#get the data
alergieTags <- c("Milk", "Wheat","Soya","Egg","Butter","Lactose","Gluten","Moutarde","Oats","Fish","salmon","Tuna")
foodData <- read.csv("foodData.csv")

# create the intro page Using html 
intro<-function()
{
  paste("<h4>In het menu hiernaast kunt u meerdere allergien selecteren.</h4>
        <br><br>
        <h3> Extra info </h3><br>
        De dataset die gebruikt wordt komt van http://world.openfoodfacts.org/data \n
        Deze dataset bestaat uit meerder talen deze heb ik zoveel mogelijk vertaald naar het engels\n
        Helaas is dit niet overal gelukt. Me grootste focus lag op de visualisaties.<br><br>
        <h3> Welke visualisaties </h3><br>
        Ik maak gebruik van 3 verschillende visualisaties. De Eerste is een barplot waarin je kunt zien \n
        uit welke landen de gerechten komen waar de door u geselecteerde gerechten in zitten. op deze
        pagina is ook te zien hoeveel procent van alle gerechten u veilig kan eten. NOTE: Niet bij alle gerechten in de
        dataset zijn de allergieen goed ingevuld.<br>
        2de visualisatie is een wordcloud van alle allergieen die in dataset te vinden zijn.<br>
        3de visualisatie is een table met allergie en percentage gerechten waar de allergie in voor komt volgens de data set.")
}

# Function for getting al the words from data set
# some columns contains multiple words seperated bij a comma,
# i split them so we can count the words.
getWordcloudVariable <- function(){
  words <- unlist(strsplit(as.character(foodData$allergens),','))
  return(Corpus(VectorSource(words)))
}

# get percentage a user can eat
getTotaalPercentage<-function(input){
  totaalPercent <- 100 -calculatePercentage(input)
  if (totaalPercent == 0){
    totaalPercent = 100
  }
  paste(" You can eat",totaalPercent,"% of all recepies")
}

# calculate percantage from te input compare with the dataset
calculatePercentage <- function(input){
  allergie <- foodData[grep(paste(input, collapse = "|"), foodData$allergens,ignore.case=TRUE), ]
  ((nrow(allergie) / nrow(foodData)) * 100)
}

# create the table with percentage on off each allergie
createPercentTable<- function(){
  data <- data.frame( "Alergie" = character(), "percentage" = integer(), stringsAsFactors=FALSE)
  for (tag in alergieTags){
    data[nrow(data) + 1, ] <- c( tag, round(calculatePercentage(tag),2))
  }
  return(data)
}
