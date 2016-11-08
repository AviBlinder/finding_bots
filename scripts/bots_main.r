
#friends <- read.csv("D:/Yelp/r_datasets/friends.csv",stringsAsFactors = FALSE)
users <- read.csv("D:/Yelp/r_datasets//users.csv",stringsAsFactors = FALSE)

business <- read.csv("D:/Yelp/r_datasets/business.csv",header = TRUE,stringsAsFactors = FALSE)
reviews <- read.csv("D:/Yelp/r_datasets/reviews.csv",header = TRUE,stringsAsFactors = FALSE)


names(users)
names(reviews)

library(dplyr)
users %>% filter(FriendsNumber == 0 & fans <= 10) -> bot_users
reviews %>% filter(user_id %in% bot_users$user_id) %>%
  group_by (business_id) %>% mutate(reviews_count = count(business_id)) -> 
  filtered_reviews

