# Creator: Eve Jimenez

# Dataset comes from
# https://www.kaggle.com/datasnaek/youtube-new/data

#change file if want to read in data from other countries
youtubeData <- read.csv("C:\\USvideos.csv") #location of file
cat('Read in baby names with',nrow(youtubeData), 'rows\n')

possibleChannels <- sort( unique(youtubeData$channel_title) )
cat('Created a vector of',length(possibleChannels), 'unique names\n')

# rounds up number of views 
possibleViews <- sort(unique(round(youtubeData$views,-3)))

#youtubeData$views <- sort(round(youtubeData$views,-3))

# Cleans up youtube video publish date to be more readable
youtubeData$publish_time <- gsub(pattern = 'T.*',replacement = '',x = youtubeData$publish_time)

