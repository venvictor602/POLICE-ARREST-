# we are working with the us Arrest data set 

library(dplyr)
library(plotly)
library(ggplot2)
#install.packages("ggtext")
library(ggtext)
library(maps)
#install.packages("DT")

library(DT)
#install.packages("ggcorrplot")

library(ggcorrplot)

library(shiny)

# install.packages("shinydashboard")
library(shinydashboard)
#install.packages("shinycssloaders")
library(shinycssloaders)
#install.packages("evaluate")
library(evaluate)
my_data <- USArrests

#geetting the struture of my data




#summary stats 

my_data %>% 
  summary()


# first few observation

my_data %>% 
  head() 

#assigning row names tpo object

states = rownames(my_data)

my_data = my_data %>% 
  mutate(states = states)


str(my_data)

#second menu item visualization

# creating the histogram and boxplot

my_data %>% 
  plot_ly() %>% 
  add_histogram(~Rape) %>% 
  layout(xaxis = list(title = "Rape"))


#choices for selecInput -  without states column 

c1 = my_data %>% 
  select(-states) %>% 
  names()

c2 = my_data %>% 
  select(-"states", -"UrbanPop") %>% 
  names()

#top 5 states eith high rates
my_data %>% 
  select(states, Rape) %>% 
  arrange(desc(Rape)) %>% 
  head(5)


# top 5 states with low rates 
my_data %>% 
  select(states, Rape) %>% 
  arrange(Rape) %>% 
  head(5)

state_map <- map_data("state")

my_data1 <- my_data %>% 
  mutate(State = tolower(states))

merged = right_join(my_data1, state_map, by = c("State" = "region"))
str(merged)

st = data.frame(abb = state.abb, stname = tolower(state.name), x = state.center$x, y = state.center$y)
str(st)

new_join <- left_join(merged, st, by = c("State" = "stname"))

str(new_join)


#git hub--- aagarw30