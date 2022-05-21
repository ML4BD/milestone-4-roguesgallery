library(dplyr)
library(ggplot2)
library(markovchain)

data <- read.csv('data_clean.csv.gz')

#turn the timestamp into_counts an R-interpretable object
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

possibleStates.red <- c('GO_TO_THEORY',
                        'REQUEST_HINT',
                        'REVIEW_TASK',
                        'SKIP',
                        'SUBMIT_ANSWER')

#may need to_counts remove some actions for better more interpretable results. 
#I think this shows us that we might be more interested in the bigger picture (i.e. actions directly
#linked to_counts learning), 

data.red <- data %>% filter(action %in% possibleStates.red)

source("createMarkovModel.R")
mcModel <- createMarkovModel(data, possibleStates)

transition_estimates <- lapply(mcModel, FUN = function(i){i$estimate})

from_counts_counts <- matrix(0, nrow=length(possibleStates), ncol=length(possibleStates))
colnames(from_counts) <- possibleStates
rownames(from_counts) <- possibleStates
to_counts <- from_counts


for(state in seq_along(possibleStates)){
  from_counts[state,] <- Reduce('+', lapply(transition_estimates, FUN = function(i){i[possibleStates[state],]}))
  to_counts[state,] <- Reduce('+', lapply(transition_estimates, FUN = function(i){i[,possibleStates[state]]}))
}

zeroLinks <- function(transition_counts, direction){
  loc = which(transition_counts == 0, arr.ind=T)
  n = nrow(transition_counts)
  
  if(direction == 'from_counts'){
    from_counts <- c()
    to_counts <- c()
    
    for(i in 1:n){
      from_counts[i] <- possibleStates[loc[i,1]]
      to_counts[i] <- possibleStates[loc[i,2]]
    }
    return(data.frame(from_counts, to_counts))
  }
  if(direction == 'to_counts'){
    from_counts <- c()
    to_counts <- c()
    for(i in 1:n){
      from_counts[i] <- possibleStates[loc[i,2]]
      to_counts[i] <- possibleStates[loc[i,1]]
    }
    return(data.frame(from_counts, to_counts))
  }
 
}

zeroLinks(to_counts, 'to')

transition_hist <- function(model, from, to){
  transition_estimates <- unlist(lapply(lapply(mcModel, FUN = function(i){i$estimate}),
                                        FUN = function(i){i[from, to]}))
  hist(transition_estimates, 
       main = paste("Density of probabilities of the transition", "\n", from, "to", to),
       xlab = "Probability")
}
transition_hist(mcModel, "REQUEST_HINT", "SKIP")
