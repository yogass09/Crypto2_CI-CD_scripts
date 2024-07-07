# who dat 
library(DBI)
library(odbc)
library(dplyr)
library(crypto2)

#----- Get local Path to Coin_List --------


# FETCHER
# all_coins_historical <- crypto_history(coin_list = coin_list_all,convert = "USD", limit = 10000,sleep = 0)

# REFRESHER
Daily_OHLCV<-crypto_history(coin_list = crypto.list,
                                     convert = "USD", 
                                     limit = 1,sleep = 0,
                                     start_date = Sys.Date()-10,
                                     end_date = Sys.Date()+1)

# Set up your Azure SQL Database connection
con <- dbConnect(odbc::odbc(),Driver = "ODBC Driver 17 for SQL Server",
                 Server = "cp-io-sql.database.windows.net",
                 Database = "sql_db_ohlcv",
                 UID = "yogass09",
                 PWD = "Qwerty@312",
                 Port = 1433)


# Assuming 'all_coins_historical' is your tibble
dbWriteTable(con, "Daily_OHLCV", as.data.frame(Daily_OHLCV), append = TRUE)

# Disconnect from the database
dbDisconnect(con)


# - Add a line for notification on completion of task -  first check CI/CD tools for the same

