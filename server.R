# creator:  Eve Jimenez Sagastegui 

# Dataset comes from
# https://www.kaggle.com/datasnaek/youtube-new/data



#load in these two libraries
library(dplyr)
library(ggplot2)

# Define a server for the Shiny app
function(input, output,session) {
  
  #Dynamically update the drop down list
  updateSelectizeInput(session,'title', "Title:",
                    choices=possibleChannels,server=TRUE)
  
  # Create a plot for trending youtube videos over time by specific channel
  output$youtubePlot <- renderPlot({
    
    # create a dataframe that reads in the selected channel from the drop down list
    # and groups them by the date the video was published
    df <- youtubeData %>% filter(channel_title == input$title) %>% 
      group_by(publish_time)
    

    # Generates a bar graph of popular youtube videos over time
    main <- paste0("Views of popular youtube videos in the United States \n by youtuber '", 
                   input$title, "' over time")
    barplot(df$views, names.arg = df$publish_time, col = "lightblue", 
            xlab = "date published", ylab = "Views", 
            main = main, axis.lty = 1)
  })
  
  output$youtubeCompare <- renderPlot({
    
    dfcompare <- youtubeData %>% filter(channel_title == input$title) %>% 
      group_by(publish_time)
    
    #t <- table(dfcompare$likes,dfcompare$views)
    #t.conditional <- prop.table(t, margin = 1)
    
    # Generates a scatterplot graph of likes/views over time. 
    ggplot(dfcompare, aes(x=views, y=likes)) +
      geom_point(aes(color = publish_time)) +
      ggtitle("Views vs Likes comparison videos") +
      labs(x = "Views", y = "Likes")
  })
  
  #  Creating  text output where the 
  
  output$maxText <- renderText ({
    
    dfVid <- youtubeData %>% filter(channel_title == input$title) %>% 
      group_by(publish_time)
    
    
    w <- which.max(dfVid$views)   # finds the index of the channel with most views
    numofViews <- dfVid$views[w]  # displays number views
    dateVid <- dfVid$publish_time[w]  # displays video date 
    titleVideo <- dfVid$title[w]      # displays title 
    titleLikes <- dfVid$likes[w]      # displays likes 
    numTrending <- length(dfVid$video_id) #number of trending videos per channel
    
    # prints out text to the UI
    paste("The most popular video for", input$title, 
          "was '",titleVideo, "' \nand it reached a total of", numofViews, " views on",dateVid,
          ". \n\nThis video has", titleLikes, "likes. \n \n",
          input$title, "has a total of ", numTrending, "trending videos." )
  })
  

  output$mostLikes <- renderText ({
    # This dataframe specifically finds the numbers between the ones selected in the
    # slider and 1000 below.
    dfViews <- youtubeData %>% filter(views <= input$views,views >= input$views-1000) %>% 
      group_by(publish_time)
    
    # Finds the video within the range of views indicated with the the most likes
    w <- which.max(dfViews$likes)
    
    # Takes the channels in the dataframe and cleans it up to be more readable
    channels <- unique(dfViews$channel_title)   
    stringTogether <- paste(channels,collapse=', ')
    
    paste("The video with", input$views,"that had the most likes was '", 
          dfViews$title[w],"'. It had", 
          dfViews$likes[w],"likes.\nThe channels that had trending videos with", 
          input$views,"were", stringTogether)
  })
}