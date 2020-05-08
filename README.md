What effects imdb score
Cem Kilicli
1/8/2017
========================================================

Univariate Plots Section
This report explores a dataset containing attributes for approximately 5043 movies that is taken from imdb.com

Imdb Score of Movies
# Imdb score distribution
summary(mmd$imdb_score)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.600   5.800   6.600   6.442   7.200   9.500
# First to start I would like to inspect the distribution of Imdb Score 
ggplot(aes(x=imdb_score), data = mmd) +
  geom_histogram(aes(fill = ..count..)) +
  scale_x_continuous(breaks = 0:10) +
  ggtitle("Imdb Score Distribution") +
  labs(x = "IMDB Score", y = "Count of Movies")
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
 It seems like there is an unexpected drop around 6,5. It migth be meaningfull to set binwidth to 0,1 to distrubute data more priciese also fill the histogram with color to make it visualy differentiable.

ggplot(aes(x=imdb_score), data = mmd) +
  geom_histogram(binwidth = 0.1, aes(fill = ..count..)) +
  scale_x_continuous(breaks = 0:10) +
  ggtitle("Imdb Score Distribution") +
  labs(x = "IMDB Score", y = "Count of Movies")


Movie Director Distribution
I would like to check if the movie directs with movie count more than 10 have an effect on the movie imdb score. To do this I will start by understanding the distribution od director data. Will get in to the details of this data on bi variante analysis.

# Director distribution - Unfiltered data for directors is not meaningfull. I create new data frame with directors that have more than 10
mmd.fr.directors <- data.frame (mmd %>% 
  group_by(director_name) %>%
  summarise(count = n())%>%
  filter(count >10, count <50))
  

ggplot(aes(x = director_name, y = count), data = mmd.fr.directors)+
  geom_jitter() +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  labs(title="Directors Distribution on Movies",x="Count of Movies",y="Directors")


Content Rating Distribution
Content rating is one of the attributes that to be cheked versus imdb score. I might support to finilize our assumplions.



Title Year Distribution
Title year is one of the key identifiers on how the imdb score change in time. If Will help support my investigation into features of interest.



Facebook likes of Movies
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0       0     166    7526    3000  349000
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.


Profit Distribution
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max. 
## -1.221e+10 -1.027e+07  8.516e+05  5.845e+06  2.475e+07  5.235e+08 
##       NA's 
##       1152


Number of Voted Users Distribution


Bivariate Plots Section
Imdb Score vs. Title Year of Movies
There is a decrease in the imdb score over years. This seams to be caused by the effect of number of movies in the early periods. Once the amount of movie increases the it decrease the average of imdb scores in late 2000’s. Which shows that the early titles movies are less but with better imdb score. Which is displayed in the graph below.

ggplot(aes(x = title_year, y = imdb_score), data = mmd) +
  geom_point() + geom_smooth(method = "auto") 
## `geom_smooth()` using method = 'gam'


Title Year vs. Imdb Score Distribution
Title year is one of the key identifiers on how the imdb score change in time. If Will help support my investigation into features of interest.



Budget vs. Title Year of Movies
The budget of movies seams to increase from 1920’s to early 2000’s. then there is a decrease. This moght be coused because of the uprising of independen movies. Which is displayed in the graph below.

# Distribution of budget over years
# Removed NA & OutLiers(Q3+(1.5*IQR)) from the data
ggplot(aes(x= title_year, y = (budget/1000000)), data = subset(mmd, budget < 75000000),!is.na(budget)) +
  geom_jitter(alpha = 1/4) +
  geom_smooth()
## `geom_smooth()` using method = 'gam'


### Budget vs profit
mmd[mmd$title_year>=2006,] %>% 
  mutate(budget,profit = gross- budget) %>% 
  filter(profit > 0) %>% 
  ggplot(aes(x=budget,y=profit))+geom_point()+geom_smooth(method = "lm") +
  labs(title=" Budget vs. Profit",x="Budget",y="Profit")


Budget vs Imdb Score
It seems like there is a uniform relation between imdb score and budget. So with this data we might say that with higher budget you can not guarantee a higher imdb score.

ggplot(aes(x=budget, y = imdb_score), data = subset(mmd, budget < 75000000),!is.na(budget)) +
  geom_jitter(binwidth = 1000000, alpha = 1/4) +
  geom_smooth(method = "auto")+
  ggtitle("Effect of Budget to IMDB SCORE") +
  labs(x = "BUDGET", y = "IMDB SCORE")
## `geom_smooth()` using method = 'gam'


Budget vs profit
By looking at the graph It is you might increase profit by increasing the budget. If you think about the general audience this makes sense, because people tend to watch movies with hight budgets which provides extreme movie effects.

### Budget vs profit
mmd[mmd$title_year>=2006,] %>% 
  mutate(budget,profit = gross- budget) %>% 
  filter(profit > 0) %>% 
  ggplot(aes(x=budget,y=profit))+geom_point()+geom_smooth(method = "lm") +
  labs(title=" Budget vs. Profit",x="Budget",y="Profit")


Facebook Likes vs. Title Year
I have checked the correspondence between movie facebook likes and title year. As I expected the amount of movie facebook likes start increasing around 2007, which clearly shows that the newer movies is tend to have more likes. Old movies don’t have any facebook page unless some fans of the movie created one. In contrary newer movies lunch their movies with a facebook page. To be able to find the reason of decrease around 2015 we need more data.

## `geom_smooth()` using method = 'gam'


## `geom_smooth()` using method = 'gam'
 ### Content Rating vs. Average Imdb Score When we look deeper into content rating we see that “R” (restricted) and “PG-13” movies have the most observations but this doesn’t put them on the high parts of the imdb score scale. The “TV-MA” (unsuitable for children under 17) stands on the top because these titles mostly broadcasted through TV, and tend to viewed by much broader audience.

 ### Number of Voted Users vs. Title Year It is clearly show that as the movie imdb score increase people tend to like movie on facebook. This makes perfect sense, popular things reach to wider audience.

## `geom_smooth()` using method = 'gam'
 ### Profit vs. Title Year

## `geom_smooth()` using method = 'gam'


## `geom_smooth()` using method = 'gam'


Multivariate Plots Section
Facebook likes of Movies
## `geom_smooth()` using method = 'gam'
 ### Content Rating Distribution

 ### Budget vs. Profit vs. Imdb Score

## `geom_smooth()` using method = 'loess'


## `geom_smooth()` using method = 'loess'
 ### Profit vs. imdb score vs. title year

## `geom_smooth()` using method = 'loess'
 ### Directors distributed over Profit vs. Imdb Score 
