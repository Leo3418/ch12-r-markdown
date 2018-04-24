# load relevant libraries
library(httr)
library(jsonlite)

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R")

# Create a variable `movie.name` that is the name of a movie of your choice.
movie.name <- "2012"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie.name` variable as the search query!
base_uri <- "https://api.nytimes.com/svc/movies/v2"
resource <- paste("reviews", "search.json", sep = "/")
query_params <- list("api-key" = nty_apikey, query = movie.name)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response <- GET(paste(base_uri, resource, sep = "/"), query = query_params)
body <- fromJSON(content(response, "text"))

# What kind of data structure did this produce? A data frame? A list?
class(body)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(body)
str(names(body)[[5]])

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- body$results

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
headline <- reviews[1, "headline"]
short_summary <- reviews[1, "summary_short"]
link <- reviews[1, "link"]$url

# Create a list of the three pieces of information from above. 
# Print out the list.
most_recent <- list(headline, short_summary, link)
print(most_recent)
