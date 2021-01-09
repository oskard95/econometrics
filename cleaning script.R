#DATA AND CREATING CSV FILE FROM CLEANED DATA TO REDUCE FILE SIZE.
vehicles <- read.csv("rawdata/maindata.csv", header=TRUE, na.strings= c("", " ", "NA"))

#After we drop Size from the vehiclesframe and make a new vehiclesframe "Vehicle vehicles Frame" 
vdf <- vehicles[-c(1:5,16,18,21,22)]
#Here we cut off for above 1million and below 100 dollars.
vdf <- subset(vdf,vdf$price < 100000)
vdf <- subset(vdf,vdf$price > 100)
#Odometer
vdf <- subset(vdf,vdf$odometer<500000)
#changing cylinders into factors
vdf$cylinders <- as.factor(factor(vdf$cylinders, levels = c( NA , "3 cylinders" , "4 cylinders", "5 cylinders", "6 cylinders", "8 cylinders", "10 cylinders", "12 cylinders", "other" ), ordered = "FALSE"))
#changing condition to a factor.
vdf$condition <- as.factor(factor(vdf$condition, levels = c( NA ,"salvage", "fair", "good", "excellent", "like new", "new"), ordered = "TRUE"))
#Changing fuel to a factor
vdf$fuel <- as.factor(factor(vdf$fuel, levels = c( NA ,"gas", "diesel", "other", "hybrid", "electric"), ordered = "FALSE"))
levels(vdf$fuel)
#Changing title_status to factor
vdf$title_status <- as.factor(factor(vdf$title_status, levels = c( NA ,"clean", "lien", "missing", "salvage", "rebuilt", "parts only"), ordered = "FALSE"))
#changing other variables to factor
vdf$transmission <- as.factor(vdf$transmission)
vdf$drive <- as.factor(vdf$drive)
vdf$type <- as.factor(vdf$type)
vdf$paint_color <- as.factor(vdf$paint_color)
#Dropping NA's and filtering out further observations
dropped <- na.omit(vdf)
#Filtering out locations outside the UNITED STATES. Creating more accurate observations
filtered <- dropped %>%
          filter(lat> 24.206, lat< 49.752, long> -126.625, long< -62.447) 
filtered1 <- dropped %>%         
          filter(lat> 54.622, lat< 71.187, long> -169.150, long< -129.648)          
filtered2 <- dropped %>% 
          filter(lat> 18.229, lat< 29.305, long> -179.014, long< -154.345)
wdata <- rbind(filtered,filtered1,filtered2)
#creating age variable
wdata$age <- 2020-wdata$year
#Creating the csv file, you have to input your own file directory if you do not open it as a project file.
write.csv(wdata,file= "rawdata/cleaneddata.csv", row.names = FALSE)
rm(filtered, filtered1, filtered2, dropped, vdf)
