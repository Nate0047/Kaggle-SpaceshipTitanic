# Feature Engineering --------------------------------------------------------------------

# Info on data at: https://www.kaggle.com/competitions/spaceship-titanic/data

# PassengerId could be split into group and number of people
# Cabin could be broken down into deck/num/side, with side either p or s.

train.data %<>%
  separate(data = ., col = 'PassengerId', into = c('GroupNo', 'PersonNo'), sep = "_") %>%
  separate(data = ., col = 'Cabin', into = c('Deck', 'Room', 'Side'), sep = "/")

# build into a function
IDandCabinSeparator.fun <- function(x) {
  x %<>%
    separate(data = ., col = 'PassengerId', into = c('GroupNo', 'PersonNo'), sep = "_") %>%
    separate(data = ., col = 'Cabin', into = c('Deck', 'Room', 'Side'), sep = "/")
}
