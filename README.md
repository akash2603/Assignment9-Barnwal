# Assignment9-Barnwal
The repository consist of three task. 

problem 1: is refining the Shiny app we worked in on class so that the result looks nicer (consistent colors for male and female names, no decimal in the counts, wide format in the table when male and female names are included). 

Problem 2:  
Make a Shiny app that shows a scatterplot (points, not lines) of log10 of per capita GDP (horiz axis) versus life expectency (vert axis), including a smoothed curve, for an individual country. The user should be able to select the country by typing in the name of the country (or selecting from a pull-down menu if you are ambitious) and use sliders to specify the range of years. Use the gapminder dataset for this. 

Problem 3: 
Following the approach in class for nested data frames, please calculate, for each country in the gapminder dataset, the slope of the linear regression of life expectency against log10 of per capita GDP. Do the same using the rlm function in the MASS package (rlm() gives robust estimates, which are less affected by outliers---the broom package works with the output of rlm). Produce a plot of the slope estimates from lm versus the slope estimates from rlm. Countries that don't fall near the diagonal line might have a non-normal error distribution. For the countries with the biggest differences in the two slope estimates, show the scatter plots of log10 per capita GDP versus life expectency.
