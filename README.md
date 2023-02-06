# Data mining with R

## Introduction
Explore and visualise relationships and outliers from a synthetic dataset of historic vehicle accidents on UK roads, spanning five years. The findings may not seem realistic, as the dataset is generated and does not correspond to real life. The following pages will display five relation-ships found in the data and two outliers.

## How to run?
1. Setup you R enviroment. Read more here: https://www.rstudio.com/
2. In R-Studio paste "import ggplot2" on the top of the file you are working on.
3. Run in the console: setwd("C:/yourworkingdir")
4. Paste "dataset <- read.csv("dataset.csv")"

## Outliers
### Global Outlier “Severity to Damage”. (fig.1)
![fig1](/figs/fig1.png)
```
ggplot(dataset, aes(x = Damage, y = Severity)) + geom_point()
```
A scatterplot is used to visualise this outlier. Moreover, there is a clear relationship between Severity and Damage which are continuous variables. As seen in fig.1 “Se-verity” and “Damage” are connected. The outliers are the points around the line, which do not obey the relationship between the two variables. This is a global outlier in table “Damage”.

### Outlier “Speed” (fig.2)
As shown in fig.2 there is a gap between 90mph and 130mph, where no crashes are recorded. After the gap, above 130mph all the records can be considered as an outlier. A histogram is used over boxplot, as histograms are good at displaying outliers that consist of lots of values. It is not entirely clear if we have to treat the records above 130 as an outlier as they have interesting trends and relationships as seen in fig.8 - young males (18 to 40) when driving at speeds above 130 are causing significantly more severe crashes. Similar case with women, but not that pronounced. Secondly from 40 to 60 severity of the crashes increases, but from 60 to 80 severity is in a downtrend again.
![fig2](/figs/fig2.png)
``` 
ggplot(dataset, aes(x = Age, y = Severity ,color=Road.Type )) + geom_point()  +  facet_grid (~ Gender) +  scale_color_brewer(palette="Set1")
```

## Relationships

### Average male collision speed has decreased over the years. (fig.3)
A simple bar chart is used to showcase the average speed over the years. Speed is decreasing gradually from 98 to 2002. That is the case only with Males. As shown in fig.3. Note. For better accuracy of the graph, I have removed outlier 2 “Speed” from the visualisation.
![fig3](/figs/fig3.png)

``` 
dataset["Year"][dataset["Year"] == 98] <- 1998
dataset["Year"][dataset["Year"] == 99] <- 1999
dataset["Year"][dataset["Year"] == 0] <- 2000
dataset["Year"][dataset["Year"] == 1] <- 2001
dataset["Year"][dataset["Year"] == 2] <- 2002
Males <- with(dataset, dataset[Gender=="M",])
ggplot(Males, aes(x = factor(Year), y = Speed)) + 
geom_bar(stat = "summary", fun = "mean") 
```


### Collisions on Motorways by Gender (fig.4)
The most severe crashes are caused by young males on motorways as its shown-on fig.4. There is a problem with the dataset, as there are no records of males above 30 causing crashes on motorways. A histogram is used for displaying the gap. Data den-sity is not ideal, but the idea of the graph is to display the number of collisions and the missing data.
![fig4](/figs/fig4.png)

``` 
Above.100 <- with(dataset, dataset[Speed > 100,])
ggplot(Above.100, aes(x=Age, y = Severity)) + geom_smooth(se=FALSE) +facet_grid( ~ Gender)
```


### Number of collisions depending on the brightness and casualty class (fig.5)
Driver and passenger collisions are pretty similar see fig.5, but the “other” type of casualty class has no data during overcast and night daytime, only from 40000lux onwards, moreover, the number of collisions is greater than the rest. It is interesting why the crashes during nighttime or in low light conditions are lower than crashes in sunlight.
![fig5](/figs/fig5.png)


```
ggplot(dataset, aes(x=Age, y=Damage)) +
  geom_bar( stat="identity") + facet_grid( ~ Gender)
```

### Amount and severity of collisions depending on the Road Type (fig.6)
Most of the crashes happened on unclassified roads as shown in fig.6 and they are with low severity. Most severe crashes happened on motorways. On A class roads have more severe crashes than B class roads. We can conclude that the higher the class of the road is the higher the severity of the crash is.
![fig6](/figs/fig6.png)

```
ggplot(Males, aes(x=Brightness, y = Damage, color=Gender)) +
  geom_smooth( method="loess",se=FALSE)  + geom_point()
```

### Number of collisions depending on speed 1998 vs 2002 (fig.7)
Comparing years 1998 and 2002 by the total count of collisions you will find that there is an interesting mirror-like graph when viewing the graphs side by side. See fig.7. To visualise that histogram and smooth line are used. In 1998 most of the crash-es happened with a speed above 80mph, but during 2002, most of the crashes were with a speed below 40mph.
![fig7](/figs/fig7.png)

```
ggplot(dataset, aes(x=Severity)) +  geom_histogram(color="darkblue", fill="lightblue", binwidth=10) + facet_grid( ~ Road.Type)

```

