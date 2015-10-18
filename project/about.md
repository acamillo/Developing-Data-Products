Population Instruction Level Explorer
=====================================

This Shiny App aims at enabling the user to explore the percentage of the population, with age within 30 and 34 years,with a level of accademical instruction  within the European Countries. 

The dataset covers a range of years from the 2001 to 2013.

## Navigation
This applicatiion layout is composed of a navigation tabbed bar at the top and two panel. The first panel allows the user to visually explore the data, the second tab containt the application documentation (this page).

The exploring panel is divived into two main panels. A lefthand side control panel and a central main panel with the graphs. The filter panel allows the user
to select what kind of data to break the dataset into using the $X-axis variable$ combobox. It is possibly to choose to major kind of visualizations: divived by years, divided by country. According to the kind of visualization selected the application will show/hide the correct sub-filter dropdown menu.

If the application is showing data dividing by countries, then the filter panel allows the user to select what year of data to display.
Conversely, if the data is shown by years, the filter panel allows the user to select what country to drill down.

If the graph visualization is cluttered is it possible to enlarge the container window and the graph will resize itself to use all the possibile available space.

## Dataset structure


Variable &nbsp;  |  Description
-----------------|------------
country          | Name of the country surveied.
level            | Percentuage level of the population with an accademic instruction
year             | Year of the survey (2001 to 2013)


## Dataset Source

Last update date: 07 August 2015  
Source: Ministery of Economical Development  
Original source: Eurostat  


Data set downloaded from: [DatiOpen.it](http://www.datiopen.it/it/opendata/Popolazione_con_istruzione_universitaria_nelle_nazioni_europee)
