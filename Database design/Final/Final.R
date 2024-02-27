
# Problem 2

library(quantmod)
get_stock_data <- function(ticker, start_time, end_time, window_size) {
  # Download daily stock data using a given stock ticker for a given time period
  stock_data <- getSymbols(ticker, from = start_time, to = end_time, auto.assign = FALSE)
  
  # Get the adjusted close price
  adj_close <- stock_data[,6]
  
  # Perform rolling window estimation for mean and standard deviation
  mean_estimates <- rollapply(adj_close, width = window_size, FUN = function(x) mean(x, na.rm = TRUE), by.column = FALSE)
  std_estimates <- rollapply(adj_close, width = window_size, FUN = function(x) sd(x, na.rm = TRUE), by.column = FALSE)
  
  # Store the statistical results of into a dataframe
  results <- data.frame(
    Index = 1:length(mean_estimates),
    Mean = mean_estimates,
    Std_Dev = std_estimates
  )
  results <- na.omit(results)
  
  # Plot this statistical dataframe using scatter plot
  plot(results$Index, results$Mean, col = "blue", xlab = "Index", ylab = "Statistical Values", 
       ylim = c(min(c(results$Mean, results$Std_Dev)), max(c(results$Mean, results$Std_Dev))), main = "Rolling Window Statistics")
  points(results$Index, results$Std_Dev, col = "red")
  legend("topright", legend = c("Mean", "Std Dev"), col = c("blue", "red"), pch = 1)
  
  # Return the statistical dataframe
  return(results)
}

# Test your function with suitable parameters
start_date <- '2021-01-01'
end_date <- '2023-01-01'
ticker <- "TSLA"
rolling_window <- 20

stock_stats <- get_stock_data(ticker, start_date, end_date, rolling_window)
head(stock_stats)



# Problem 3

library("RPostgres")
# Make a connection to your local PostgreSQL database
con <- dbConnect(RPostgres::Postgres(), 
                 dbname = "postgres", 
                 host = "127.0.0.1", 
                 port = 5432, 
                 user = "postgres", 
                 password = 'Culturismo99.')

# Query the PostgreSQL database via API to get the original bank data. 
# Store the data into a dataframe.
query <- "SELECT * FROM bank_data;"
bank_data <- dbGetQuery(con, query)
head(bank_data)

# 3.3
# Calculate asset growth rate for each quarter and each bank.
# The result start from second quarter, since we don’t have all necessary data for first quarter calculation. Store the
# calculation result in a data frame.
library(dplyr)
bank_data <- bank_data %>%
  arrange(id, date) %>%
  group_by(id) %>%
  mutate(asset_growth_rate = ifelse(row_number() == 1, NA,
                                    (asset - lag(asset)) / lag(asset))) %>%
  ungroup()

# Export the dataframe to the PostgreSQL database via API
dbWriteTable(con, "asset_growth_rates", bank_data, row.names = FALSE, overwrite = TRUE)

dbDisconnect(con)

