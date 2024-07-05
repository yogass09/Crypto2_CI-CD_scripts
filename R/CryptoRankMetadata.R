  library(httr)
  library(jsonlite)
  
  # API endpoint
  url <- "https://api.cryptorank.io/v0/coins/"
  
  # Make GET request
  response <- GET(url)

  
  
  content <- content(response, "text", encoding = "UTF-8")
  data <- fromJSON(content)
  
  # Print the structure of the parsed data
  str(data)

  df <- data.frame(data)  
  
  
# to DB

