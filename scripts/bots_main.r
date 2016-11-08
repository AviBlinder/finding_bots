library(dplyr)
library(ggplot2)

#friends <- read.csv("D:/Yelp/r_datasets/friends.csv",stringsAsFactors = FALSE)
users <- read.csv("D:/Yelp/r_datasets//users.csv",stringsAsFactors = FALSE)

business <- read.csv("D:/Yelp/r_datasets/business.csv",header = TRUE,stringsAsFactors = FALSE)
reviews <- read.csv("D:/Yelp/r_datasets/reviews.csv",header = TRUE,stringsAsFactors = FALSE)
checkins <- read.csv("D:/Yelp/r_datasets/checkings.csv",header = TRUE,stringsAsFactors = FALSE)
tips  <- read.csv("D:/Yelp/r_datasets/tips.csv",header = TRUE,stringsAsFactors = FALSE)


head(checkins)
names(users)
names(reviews)



##Assumption #1: No friends and really few funs
users %>% filter(FriendsNumber == 0 & fans <= 3) -> filtered_users_p1

##Assumption #2: No tips given by those users
filtered_users <- setdiff(filtered_users_p1$user_id,tips$user_id)


##Slice and Dice reviews given by those users
reviews %>% 
  group_by (business_id) %>% mutate(total_reviews_count = n()) %>% 
  ungroup() %>%
  filter(user_id %in% filtered_users) %>%
  group_by (business_id) %>% mutate(reviews_count = n(), 
                    prop_reviews = round(reviews_count /total_reviews_count,2)) %>%
  arrange(desc(prop_reviews)) -> filtered_reviews

#filtered_reviews %>% filter(prop_reviews >= 0.8) -> filtered_reviews_high_prop
#
#filtered_reviews %>% summarise(prop_reviews_h  = max (stars)) -> filtered_reviews_high_prop


filtered_reviews %>% filter (prop_reviews == 1) %>% 
  group_by(business_id) %>% mutate(avg_stars = mean(stars)) -> filtered_reviews2
#  group_by(business_id) %>% summarise(avg_stars = mean(stars)) -> filtered_reviews1
hist(filtered_reviews2$avg_stars)

qplot(filtered_reviews$prop_reviews) + stat_bin(bins = 50,binwidth = 0.05)


head(filtered_reviews$reviews_count);head(filtered_reviews$total_reviews_count)
