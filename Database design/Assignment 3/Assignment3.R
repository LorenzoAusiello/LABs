library("RPostgres")

## Make a connection to your local PostgreSQL database using API.
con <- dbConnect(RPostgres::Postgres(), 
                 dbname = "postgres", 
                 host = "127.0.0.1", 
                 port = 5432, 
                 user = "postgres", 
                 password = 'Culturismo99.')

## Import the csv file you got from Problem 1 (banks total) 
## into a new table in the database using API.
setwd('C:/Users/Public')
dbWriteTable(con, "new_banks_total", read.csv("banks_total_export.csv"))

## Retrieve the data of table ‘banks total‘ using API. Count how many rows
## in the table.
banks_total <- dbGetQuery(con, "SELECT * FROM banks_total")
result <- dbGetQuery(con, "SELECT COUNT(*) FROM banks_total")
head(banks_total)
print(result)
dbDisconnect(con)
