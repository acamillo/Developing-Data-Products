# ui.R
require(shiny)
require(rCharts)
require(markdown)

library(shiny)
library(rCharts)


# Define UI 
shinyUI(
  
  # fluidPage(
  
  navbarPage("EU Instruction Visualizer", 
             
             
             tabPanel("Plot",
                      
                      titlePanel("Population with Accademic Level Instruction in European Countries (2001-2013)"),
                      p("This application shows the percentage of the population which has a University level instructions. The data is visualizable by country or by year"),
                      p("According to the type of graph selected (by Country or by Year) the application enable the user to filter the data with a specific options"),
                      p(" "),
                      hr(),
                      
                      # sidebarLayout(
                        sidebarPanel(
                          selectInput("xvar", "X-axis variable", axis_vars, selected = "year"),
                          tags$small(paste0(
                            "Select the type of data to display"
                          )),
                          
                          h4("Filter"),
                          conditionalPanel("input.xvar == \"Country\"",
                                           uiOutput("YearControl")
                          ),
                          
                          conditionalPanel("input.xvar == \"Year\"",
                                           uiOutput("CountryControl")
                          )
                        , width = 2),
                        
                        mainPanel(
                          h3("Percentage of the Population with University Instruction"),
                          plotOutput("plot1", height = "1px"),
                          showOutput('lexplot', "nvd3"),
                          em("The data is obtained from the Italian Open Data database:", 
                             a("Popolazione con istruzione universitaria nelle nazioni europee", 
                               href="http://www.datiopen.it/it/opendata/Popolazione_con_istruzione_universitaria_nelle_nazioni_europee")
                          )
                        , width = 9)
                      # ) # sideBar Layout
             ), # end of Explore Data Panel
             
             tabPanel("Documentation",
                      mainPanel(
                        # h4("Here the Documentation")
                        includeMarkdown("about.md")
                      )
             ) # end of "About" tab panel
             
             # )
  ))