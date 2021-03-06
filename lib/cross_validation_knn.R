########################
### Cross Validation ###
########################

### Author: Chengliang Tang
### Project 3

cv.function <- function(dat_train, K, k){
  ### Input:
  ### - train data frame
  ### - K: a number stands for K-fold CV
  ### - tuning parameters 
  
  n <- dim(dat_train)[1]
  n.fold <- round(n/K, 0)
  set.seed(0)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))  
  cv.error <- rep(NA, K)
  
  for (i in 1:K){
    train.data <- dat_train[s != i,]
    test.data <- dat_train[s == i,]
    
    par <- list(k = k)
    knn_model <- class::knn(train = train.data[,-which(names(train.data) == 'emotion_idx')], 
                                   test = test.data[,-which(names(test.data) == 'emotion_idx')], 
                                   cl = train.data$emotion_idx, 
                                   k = k)
    
   
    error <- mean(knn_model != test.data$emotion_idx) 
    print(error)
    cv.error[i] <- error
    
  }			
  return(c(mean(cv.error),sd(cv.error)))
}