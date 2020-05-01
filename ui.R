# creator: Eve Jimenez
# Final: A webpage that displays youtube analytics for users
# to better understand trending video information from 2006-2018

# This program runs with the dataset extracted from
# https://www.kaggle.com/datasnaek/youtube-new/data

# Use a fluid Bootstrap layout
fluidPage(

  # Give the page a title
  titlePanel("Popular Videos on Youtube by Channel Eve Jimenez"),

  # Generate a row with a sidebar
  sidebarLayout(

    # Define the sidebar with one input
    sidebarPanel(
      selectInput("title", "Title:",
                  choices=NULL),
      
      # Allows the user to switch from a graph that displays the
      # views of a user over time and the views to likes ratio
      radioButtons("col","Switch Plot",
                   choices = c("Views", "Views vs Likes"),
                   selected = "Views"),

      # Allows user to select the number of views equal to or 1000 less than
      # the amount indicate. Then it will produce the most liked within that range
      # using a slider (https://shiny.rstudio.com/articles/sliders.html)
      p("Most likes depending on views",style = "color: purple"),
      sliderInput("views", "Views:",
                  min = min(possibleViews), max=1000000,
                  value = 1000,step=1000),
      
      hr(),
      
      img(src = "https://img.deusm.com/informationweek/2015/04/1320122/YouTube-logo-full_color.png", height = 100, width = 190),
      
      #This display where the dataset is from to the user
      helpText("The youtube dataset comes from kaggle. Last update was the end of 2018")
    ),
      
    # right side of the webpage display
    mainPanel(
      conditionalPanel(
        condition = "input.col == 'Views'", plotOutput("youtubePlot")),
      conditionalPanel(
        condition = "input.col == 'Views vs Likes'", plotOutput("youtubeCompare")),
      verbatimTextOutput('maxText'),
      verbatimTextOutput('mostLikes')
    )

  )
)

