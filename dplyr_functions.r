library(tidyverse) 
#install.packages("gapminder")
library(gapminder)

df<-gapminder


###dimensions of the df
dim(gapminder)

### basic structure of the df
str(gapminder)

### detailed summary of the df
summary(df)

### glimpse of the data 
# similar to str() applied to a data frame but it tries to show you as much data as possible.
# It always shows the underlying data, even when applied to a remote data source
glimpse(df)



### arrange() : to arrange the data in ascending or descending order; by default ascending order is picked 

## to order countries in the ascending order of year , life expectancy and country name 
df %>% arrange(year, lifeExp, country)


## to order countries in the descending order of life expectancy, descending order of year and country name 
df %>% arrange(desc(lifeExp),desc(year), country)

## to order countries in the descending order of gdp per capita , descending order of year and country name 
df %>% arrange(desc(gdpPercap),desc(year), country)



### select() : To select or remove specific columns 

df %>% colnames()


# to select country name, year and life expectancy
df %>% select(country, year ,lifeExp)


# to only remove life expectancy
df %>% select(-lifeExp)

# to rename pop as Population
df %>% select(country, year, Population=pop)


# to rename pop as Population and lifeExp as life_expectancy
df %>% select(country, year, Population=pop,
              life_expectancy=lifeExp)

#to select multiple columns with :
df %>% select(country, lifeExp:gdpPercap)


# Include any column starting with a given string 
gapminder %>%
  select(country, year, starts_with("co"))
# Include any column ending with a given string
gapminder %>%
  select(country, year, ends_with("Exp"))
# Keep the last column, by any name
gapminder %>%
  select(country, year, last_col())


### distinct() - select distinct values of a filed

# distinct values of year
df %>% distinct(year)

# distinct values of countries
df %>% distinct(country)

# distinct values of countries and year
df %>% distinct(year,country)

### filter() - based on condition 


#filter data for the year 2007
df %>% filter(year==2007)

#filter data for the India
df %>% filter(country=="India")

#filter data for the Asia and for year 2007
df %>% filter(continent=="Asia", year==2007)

# bonus: filter data for the Asia and for year 2007 while arranging in descending order of population 
df %>% filter(continent=="Asia", year==2007) %>% 
  arrange(desc(pop))


# bonus: filter data for the Asia and for year 2007 while arranging in descending order of population 
# let's put one more filter on life expectancy 
df %>% filter(continent=="Asia", year==2007) %>% 
  arrange(desc(pop)) %>% 
  filter(lifeExp>60)


# filter on multiple values
df %>% filter(year %in% c(2002,2007)) %>% 
  filter(country %in% c("India", "China", "Japan","United States"))

# "or" operator function
df %>% 
  select(year,country,pop ) %>%        
  filter(pop > 50000 | pop < 100000) %>% 
  filter(year==2007) %>% 
  arrange(desc(pop))


# "and" operator function 
gapminder %>% 
  select(pop, country, year) %>%        
  filter(pop > 50000, pop < 100000)

# "and" operator function 2
gapminder %>% 
  select(pop, country, year) %>%        
  filter(pop > 50000 & pop < 100000)



### Create Data summary - Max, Min, Mean, Count & Anything In Between
#count(), summarize(), and top_n(k, )

df %>%
  count(continent)

#total 
df %>%
  summarize(total_gdp = sum(gdpPercap))

#average
df%>%
  summarize(avg_gdp = mean(gdpPercap))

# standar??d deviation
df %>%
  summarize(gdp_standard_dev = sd(gdpPercap))
# variance
df %>%
  summarize(gdp_variance = var(gdpPercap))

# create many columns at once
df %>%
  summarize(max_gdp = max(gdpPercap),
            total_pop = sum(pop), 
            min_lifeExp = min(lifeExp))

### top 5 countries based on life expectancy for the year 2007 

df %>% filter(year==2007) %>% 
  arrange(desc(lifeExp)) %>% 
  top_n(5)




### group_by() and mutate()

#arrange continents based on their descending order of total population

df %>% 
  group_by(continent) %>% 
  summarise(total_population = sum(pop, na.rm = TRUE)) %>% 
  arrange(desc(total_population))

#arrange countries based on their average life expectancy 

df %>% 
  group_by(country, year) %>% 
  summarise(avg_life=mean(lifeExp,na.rm=TRUE)) %>% 
  arrange(desc(avg_life))
  
# time-series of continents based on their total population 

df %>% group_by(continent, year) %>% 
  summarise(total_population=sum(pop,na.rm = TRUE)) %>% 
  arrange(continent,year)
  
  
