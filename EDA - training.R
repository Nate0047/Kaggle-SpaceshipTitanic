# EDA ------------------------------------------------------------------------------------
print(train.data) # missing data present

DataExplorer::plot_missing(train.data)
# missing data - roomservice, vrdeck, spa, foodcourt, age, shoppingmall
# doesn't capture everything, because some some strings were empty but not NA - fix
train.data[train.data == ""] <- NA
train.data <- droplevels.data.frame(train.data) # to get rid of old factor levels

DataExplorer::plot_missing(train.data)
# now missing data - roomservice, vrdeck, spa, foodcourt, age, destination, shoppingmall,
# cabin, name, homeplanet, vip, cryosleep (all around 2-3%)

DataExplorer::plot_bar(train.data)
DataExplorer::plot_histogram(train.data)


# impute missing data
hdimputed.train.data <-
VIM::hotdeck(train.data, 
             variable = c('RoomService', 'VRDeck', 'Spa', 'FoodCourt', 'Age', 
                          'Destination', 'Cabin', 'Name', 'HomePlanet', 'VIP',
                          'ShoppingMall', 'CryoSleep')
             )

