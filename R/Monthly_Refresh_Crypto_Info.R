
# Libraries
library(DBI)
library(odbc)
library(dplyr)
library(crypto2)
library(SQL)


start.time <- Sys.time()


## 2. Crypto Info
crypto.info<- crypto_info(limit = 1)

crypto.info<- as.data.frame(crypto.info)
crypto.info <- sqlData(con, crypto.info)
str(crypto.info)


# Set up your Azure SQL Database connection
con <- dbConnect(odbc::odbc(),Driver = "ODBC Driver 17 for SQL Server",
                 Server = "cp-io-sql.database.windows.net",
                 Database = "sql_db_ohlcv",
                 UID = "yogass09",
                 PWD = "Qwerty@312",
                 Port = 1433)


# Assuming 'all_coins_historical' is your tibble

# 2
dbWriteTable(con, "crypto.info", as.data.frame(crypto.info), overwrite = TRUE)


## 00 check process time
end.time <- Sys.time()

end.time-start.time



# Disconnect from the database
dbDisconnect(con)

