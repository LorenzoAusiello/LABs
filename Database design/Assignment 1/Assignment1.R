vector_1<-runif(10)
vector_2<-runif(10)
vector_1
vector_2

vector_tot<-append(vector_1,vector_2)
vector_tot

mean_value<-mean(vector_tot)
mean_value

for (i in vector_tot){
  if (i>mean_value) {
    print('True')}
  else {print('False')
  }
}

vector_3<-runif(100)
vector_3

matrix_1<-matrix(vector_3,nrow = 10)
matrix_1

matrix_2<-t(matrix_1)
matrix_2

print(matrix_2[2,1])

matrix_3<-matrix(NA,nrow = 10,ncol=10)
for (i in 1:10){
  for (j in 1:10){
    matrix_3[i,j]<-sum(matrix_2[i,]*matrix_1[,j])
  }
}
matrix_3

matrix_4<-matrix_2%*%matrix_1
matrix_4

setwd("C:/Users/loaus/OneDrive - stevens.edu/STEVENS/Financial Lab Database Design/Assignment/Assignment1")

data<-read.csv("stock_data-1.csv")
head(data)

data <- subset(data, select = -c( which(colMeans(is.na(data)) > 0)))
head(data)

log_returns<-matrix(NA,nrow=6041,ncol=26)
colnames(log_returns)<-colnames(data)
log_returns<-data.frame(log_returns)

for (i in 2:26){
  for (j in 2:6041){
    log_returns[j,i]<-log(data[j,i]/data[j-1,i])
  }
}

log_returns<-log_returns[-1,]
log_returns[,1]<-data[-1,1]
head(log_returns)

stat_fun<-function(x){
  c(mean(x),sd(x))
}

statistics<-sapply(log_returns[,-1],FUN=stat_fun)
rownames(statistics)<-c("mean","sd")
statistics

data$X<-as.Date(data$X)


library(ggplot2)
plot1 <- ggplot(data, aes(x =X)) +
  geom_point(aes(y = AAPL, color = "AAPL"), size = 1) +
  geom_point(aes(y = AMGN, color = "AMGN"), size = 1) +
  geom_point(aes(y = AXP, color = "AXP"), size = 1) +
  labs(title = "Daily Stock Prices",
       x = "Date",
       y = "Stock Price") +
  scale_color_manual(values = c("AAPL" = "red", "AMGN" = "blue", "AXP" = "green")) 

plot2 <- ggplot() +
  geom_point(aes(x = colnames(statistics), y = statistics[1,],color="Mean"), size = 3)+
  geom_point(aes(x = colnames(statistics), y = statistics[2,],color="SD"), size = 3)+
  labs(title = "Statistical Results",
       x = "Stocks",
       y = "Statistical Values") +
  scale_color_manual(values = c("Mean" = "red", "SD" = "blue")) 

library(gridExtra)
combined_plot <- grid.arrange(plot1, plot2, ncol = 1)


# Calculate log returns using pipes
library(dplyr)
library(purrr)
log_returns <- data %>%
  select(-1) %>%
  mutate(across(everything(), ~log(. / lag(.)))) %>%
  slice(-1) %>%
  bind_cols(date = data[-1, 1], .) %>%
  setNames(names(data))

stat_fun <- function(x) c(mean = mean(x), sd = sd(x))

statistics <- log_returns[,-1] %>%
  summarise(across(everything(), stat_fun))

rownames(statistics) <- c("mean", "sd")

head(log_returns)
statistics<-as.matrix(statistics)

data$X<-as.Date(data$X)

plot1 <- ggplot(data, aes(x =X)) +
  geom_point(aes(y = AAPL, color = "AAPL"), size = 1) +
  geom_point(aes(y = AMGN, color = "AMGN"), size = 1) +
  geom_point(aes(y = AXP, color = "AXP"), size = 1) +
  labs(title = "Daily Stock Prices",
       x = "Date",
       y = "Stock Price") +
  scale_color_manual(values = c("AAPL" = "red", "AMGN" = "blue", "AXP" = "green")) 

plot2 <- ggplot() +
  geom_point(aes(x = colnames(statistics), y = statistics[1,],color="Mean"), size = 3)+
  geom_point(aes(x = colnames(statistics), y = statistics[2,],color="SD"), size = 3)+
  labs(title = "Statistical Results",
       x = "Stocks",
       y = "Statistical Values") +
  scale_color_manual(values = c("Mean" = "red", "SD" = "blue")) 

library(gridExtra)
combined_plot <- grid.arrange(plot1, plot2, ncol = 1)

##Parte 2

library(quantmod)
AMZN=get(getSymbols("AMZN", from = "2021-01-01", to = "2021-12-31"))
file_name ="AMZN.csv"
write.csv(AMZN, file = file_name, row.names = FALSE)
file.exists(file_name)
head(AMZN)

AMZN_weekly<-to.weekly(AMZN)
AMZN_weekly$AMZN.Weekly_LogReturns<-log(AMZN_weekly$AMZN.Adjusted/lag(AMZN_weekly$AMZN.Adjusted))
head(AMZN_weekly)
AMZN_weekly<-na.omit(AMZN_weekly)

stat<-function(x){
  c(mean(x),median(x),sd(x))
}

statistics<-sapply(AMZN_weekly$AMZN.Weekly_LogReturns,stat)
rownames(statistics)<-c("mean","median","sd")
statistics

AMZN$AMZN.Daily_LogReturns<-log(AMZN$AMZN.Adjusted/lag(AMZN$AMZN.Adjusted))
AMZN<-na.omit(AMZN)

hist(AMZN$AMZN.Daily_LogReturns, freq=F)
x<-1:6
curve(dnorm(x, mean=mean(AMZN$AMZN.Daily_LogReturns), sd=sd(AMZN$AMZN.Daily_LogReturns)),-0.1,0.1 ,add=F, lwd=2)

{hist(AMZN$AMZN.Daily_LogReturns, freq=FALSE)
curve(dnorm(x, mean=mean(AMZN$AMZN.Daily_LogReturns), sd=sd(AMZN$AMZN.Daily_LogReturns)), add=T, lwd=2)}

nrow(subset(AMZN,AMZN.Daily_LogReturns>0.01 & AMZN$AMZN.Daily_LogReturns<0.015))

