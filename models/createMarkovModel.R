library(dplyr)

createMarkovModel <- function(data, possibleStates, order=1){
  #' Create a Markovian model of user actions on platform of a given order.
  #' 
  #' @param data dataframe from lernnavi data encoding each users timestamped actions
  #' @param possibleStates vector of character strings for each possible state in the chain
  #' @param order integer order of the dataframe, at least 1. 
  
  users <- unique(data$user_id)
  userMCModel <- matrix(list(), length(users), 1)
  rownames(userMCModel) <- users 
  
  if(order > 1){
    for(user in seq_along(users)){
      #extract chronological action sequence by user
      user_sequence <- data %>% 
        filter(user_id == users[user]) %>%
        arrange(timestamp) %>%
        dplyr::select(action)
      
      #create markov model object 
      user_sequence <- as.list(user_sequence)
      mcModel <- fitHigherOrder(data=user_sequence, order)
      userMCModel[[user]] <- mcModel
    }
    return(userMCModel)
  }
  
  for(user in seq_along(users)){
    #extract chronological action sequence by user
    user_sequence <- data %>% 
      filter(user_id == users[user]) %>%
      arrange(timestamp) %>%
      dplyr::select(action)
    
    #create markov model object 
    user_sequence <- as.list(user_sequence)
    mcModel <- markovchainFit(data=user_sequence,
                              method='mle', #use maximum likelihood estimation 
                              byrow=T,
                              possibleStates=possibleStates, 
                              name=as.character(users[user]))
    userMCModel[[user]] <- mcModel
  }
  return(userMCModel)
}