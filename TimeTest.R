library(DBI)
library(odbc)
library(dplyr)
library(lubridate)  # For date and time functions

# Set up your Azure SQL Database connection parameters
driver <- "ODBC Driver 17 for SQL Server"
server <- "cp-io-sql.database.windows.net"
database <- "sql_db_ohlcv"
uid <- "yogass09"
pwd <- "Qwerty@312"
port <- 1433
timeout <- 30

# Function to get current date, month, quarter, and system time
get_datetime_info <- function() {
  today <- Sys.Date()
  month <- month(today)
  quarter <- quarter(today)
  current_time <- Sys.time()
  
  df <- data.frame(
    today_date = today,
    month = month,
    quarter = quarter,
    system_time = current_time
  )
  
  return(df)
}

# Try to connect to the database
tryCatch({
  con <- dbConnect(odbc::odbc(), 
                   Driver = driver, 
                   Server = server, 
                   Database = database, 
                   UID = uid, 
                   PWD = pwd, 
                   Port = port,
                   Timeout = timeout)
  message("Connected to the database successfully!")
  
  # Call function to create data frame
  data <- get_datetime_info()
  
  # Write data to the SQL database
  dbWriteTable(con, "ci.cd.test.min", data, append = TRUE)
  
  # Disconnect from the database
  dbDisconnect(con)
}, error = function(e) {
  message("Failed to connect to the database. Error: ", e$message)
})
