setwd('/users/cem.kilicli/documents/BDA_505_FinalProject')
getwd()

mmd <- read.csv(file='movie_metadata.csv', header = TRUE, sep = ",")

library(ggplot2)

# Distribution of budget over years

ggplot(aes(x= title_year, y = (budget/1000000)), data = mmd) +
  geom_line()

qplot(x = budget, data = mmd)
qplot(x = budget, data = subset(mmd, budget > 0))


ggplot(aes(x= title_year, y = (budget/1000000)), data = subset(mmd, budget > 0)) +
  geom_smooth()

ggplot(aes(x= title_year, y = (budget/1000000)), data = subset(mmd, budget > 0)) +
  geom_line()
summary(mmd$budget/1000000)

# Removed NA & OutLiers(Q3+(1.5*IQR)) from the data

ggplot(aes(x= title_year, y = (budget/1000000)), data = subset(mmd, budget < 75000000),!is.na(budget)) +
  geom_jitter(alpha = 1/4) +
  geom_smooth()

with(subset(mmd,budget < 75000000, !is.na(budget)), summary(budget/1000000))

ggplot(aes(x= title_year, y = (budget/1000000)), data = subset(mmd, budget < 75000000,!is.na(budget))) +
  geom_smooth()



# Distribution of gross over years

ggplot(aes(x= gross, y = (gross/1000000)), data = mmd) +
  geom_jitter(alpha = 1/4) +
  geom_smooth()

summary(mmd$gross)

ggplot(aes(x= title_year, y = (gross/1000000)), data = subset(mmd, !is.na(gross))) +
  geom_jitter(alpha = 1/4) +
  geom_smooth()

with(subset(mmd, gross < 100000000, !is.na(gross)), summary(gross/1000000))

ggplot(aes(x= title_year, y = (gross/1000000)), data = subset(mmd, gross < 100000000, !is.na(gross))) +
  geom_jitter(alpha = 1/4) +
  geom_smooth()



# Distribution of gross/budget over years

mmd$grossDivBudget <- mmd$gross/mmd$budget

summary(mmd$grossDivBudget)

