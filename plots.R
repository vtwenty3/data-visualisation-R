library(ggplot2)
#run that in console: setwd("G:/year3/data")
dataset <- read.csv("dataset.csv")

#outlier 1
ggplot(dataset, aes(x = Damage, y = Severity)) + geom_point()

#outlier 2
ggplot(dataset, aes(x = Age, y = Severity ,color=Road.Type )) + geom_point()  +  facet_grid (~ Gender) +  scale_color_brewer(palette="Set1")


#R1. Men driving slower
dataset["Year"][dataset["Year"] == 98] <- 1998
dataset["Year"][dataset["Year"] == 99] <- 1999
dataset["Year"][dataset["Year"] == 0] <- 2000
dataset["Year"][dataset["Year"] == 1] <- 2001
dataset["Year"][dataset["Year"] == 2] <- 2002
Males <- with(dataset, dataset[Gender=="M",])
ggplot(Males, aes(x = factor(Year), y = Speed)) + 
  geom_bar(stat = "summary", fun = "mean")

#R2. Fast Crashes
Above.100 <- with(dataset, dataset[Speed > 100,])
ggplot(Above.100, aes(x=Age, y = Severity)) + geom_smooth(se=FALSE) +facet_grid( ~ Gender)

#R3. Young males most damage
ggplot(dataset, aes(x=Age, y=Damage)) +
  geom_bar( stat="identity") + facet_grid( ~ Gender)

#R4. Men  are causing 
ggplot(Males, aes(x=Brightness, y = Damage, color=Gender)) +
  geom_smooth( method="loess",se=FALSE)  + geom_point()

#R5. Road Type Accidents
ggplot(dataset, aes(x=Severity)) +  geom_histogram(color="darkblue", fill="lightblue", binwidth=10) + facet_grid( ~ Road.Type)

#Bonus:
yearz <- with(dataset, dataset[Year== "98" | Year=="2",])
yearz <- with(yearz, yearz[Speed < 100,])
ggplot(yearz, aes(x=Speed)) +  geom_histogram(color="darkblue", fill="lightblue", binwidth=1) +facet_grid( ~ Year) +  geom_density(aes(y=..count../1.5))


