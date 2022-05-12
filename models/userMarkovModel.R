library(dplyr)
library(ggplot2)
library(markovchain)

data <- read.csv('data_clean.csv.gz')

#turn the timestamp into an R-interpretable object
options(digits.secs = 3)  
data <- data %>% mutate(timestamp = gsub("-", ".", timestamp)) %>%
  mutate(timestamp = gsub(":", ".", timestamp)) %>%
  mutate(timestamp = strptime(timestamp, "%Y.%m.%d %H.%M.%OS"))

#possible states a user can be in
possibleStates <- c('CLOSE', 
                    'CLOSE_FEEDBACK', 
                    'GO_TO_BUG_REPORT',
                    'GO_TO_COMMENTS',
                    'GO_TO_THEORY',
                    'NEXT',
                    'OPEN_FEEDBACK',
                    'REQUEST_HINT',
                    'REVIEW_TASK',
                    'SHARE',
                    'SKIP',
                    'SUBMIT_ANSWER',
                    'VIEW_QUESTION')


users <- unique(data$user_id)
userMCModel <- matrix(list(), length(users), 1)
rownames(transition_data) <- users 

for(user in seq_along(users)){
  #extract chronological action sequence by user
  user_sequence <- data %>% 
    filter(user_id == users[user]) %>%
    arrange(timestamp) %>%
    select(action)
  
  #create markov model object 
  user_sequence <- as.list(user_sequence)
  mcModel <- markovchainFit(data=user_sequence,
                            method='mle', #use maximum likelihood estimation 
                            byrow=T,
                            possibleStates=possibleStates, 
                            name=as.character(users[user]))
  userMCModel[[user]] <- mcModel
}

#may need to remove some actions for better more interpretable results. 
#I think this shows us that we might be more interested in the bigger picture (i.e. actions directly
#linked to learning),  
