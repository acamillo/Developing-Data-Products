# server.R

library(shiny)
#  library(ggplot2)
library(rCharts)
library(dplyr)

# Load the dataset
df = read.csv2("istruzione.csv", header = F, sep =";", skip=1)

# Set the proper colum names and remove unwanted entries by subsetting
names(df) <- c("country", "level", "year")
df <- df[! is.na(df$level), 1:3]

# Fetch the values for initializing the selection boxes of the UI.
# We need a listing of Countries and a listing of Years.
countries <- sort(unique(df$country))
years <-  sort(unique(df$year))


print("Initialization done!!")
options(RCHART_WIDTH = 800)
options(RCHART_HEIGHT = 500)

# This function prepare the plot
plotByCountry <- function(selected_country)
{
  df2 <- filter(df, country == selected_country) %>% 
    arrange((level))
  
  #   g = ggplot(df2, aes(year, level))
  #   g <- g + geom_bar(position = "dodge", stat="identity", color = "black", fill="blue") +
  #     ggtitle(selected_country) +
  #     xlab("Year") +
  #     ylab("% Of the Population")
  
  g <- nPlot( level ~ year,
              data = df2,
              type = "multiBarChart",
              width = 850
  )
  g$chart(margin = list(left = 100))
  g$chart(reduceXTicks = FALSE)
  
  g$xAxis(axisLabel = "Year", width = 80)
  g$yAxis(axisLabel = "% Of the Population", width = 70)
  
  return(g)
}

plotByYear <- function(y)
{
  df2 <- filter(df, year == y) %>% 
    arrange(desc(level))
  
  df2$country <- factor(df2$country, levels = df2$country[order(df2$level, decreasing = T)])
  
  #   g = ggplot(df2, aes(x = factor(country), y = level))
  #   g <- g + geom_bar(position = "dodge", stat="identity", fill="blue") +
  #       theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  #       ggtitle(paste("Year = ", y)) +
  #       xlab("Countries") +
  #       ylab("% Of the Population")
  
  g <- nPlot( level ~ country, 
              data = df2, 
              type = "multiBarChart",
              dom = 'chart1',
              title = "Year",
              width = 900)
  g$chart(reduceXTicks = FALSE, margin = list(left = 100))
  g$xAxis(axisLabel = "Country", width = 200, rotateLabels = -20, height = 200)  
  g$yAxis(axisLabel = "% Of the Population", width = 70)  
  g$addParams(width = 900, height = 600, dom = 'chart1', title = "Year")
  
  return(g)
}

shinyServer(
  function(input, output, session) {
    
    # Create event type checkbox
    output$CountryControl <- renderUI({
      selectInput('country', 'Select a Country:', 
                  levels(countries), selected = levels(countries)[1])
    })
    
#     # Initialize reactive values
#     values <- reactiveValues()
#     values$years <- years
    
    output$YearControl <- renderUI({
      selectInput('year', 'Select a Year:', years, selected = "2001")
    })
    
    # output$lexplot <- renderPlot({
    output$lexplot <- renderChart2({
      print("SERVER...")
      
      # Labels for axes
      xvar_name <- names(axis_vars)[axis_vars == input$xvar]
      selected_country <- input$country
      selected_year <- input$year
      
      ## In case of no option selected use some default values.
      if ( length(selected_year) == 0) {
        selected_year = years[1]
        selected_country = countries[1]
      }
      
      print(paste("Selected year A = ", selected_year))
      print(paste("Graph type :", xvar_name))
      
      if (xvar_name == "Year") r <- plotByCountry(selected_country)
      else if (xvar_name == "Country") r <- plotByYear(selected_year)
      
      # Automatic graph resize
      r$set(width=session$clientData$output_plot1_width)
      
      return(r)
    })
    
  })