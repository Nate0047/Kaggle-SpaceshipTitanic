# Clean Functions --------------------------------------------------------------------

# turn empty strings to missing and drop level from factors
emptyStringstoMissing.fun <- function(x) {
  
  x[x == ""] <- NA
  x <- droplevels.data.frame(x) # to get rid of old factor levels
    
}

# impute missing data

hdImpute.fun <- function(x) {
  
  hdimputed.train.data <-
    VIM::hotdeck(x, 
                 variable = c('RoomService', 'VRDeck', 'Spa', 'FoodCourt', 'Age', 
                              'Destination', 'Cabin', 'Name', 'HomePlanet', 'VIP',
                              'ShoppingMall', 'CryoSleep')
    )
  
}

