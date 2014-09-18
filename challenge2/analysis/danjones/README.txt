This a README for challenge 2:

The pythonvisualisation.py file is the file with the original python code.

All data point.png is a graph of all the data points as log(base 10) values, with mean
and 0.75*standard deviation lines. 

Bar of daily average.png is a bar chart of the daily average power output with mean
and standard deviation lines.

Cluster daily averages.png is a bar chart the same as above BUT the bars are now coloured
in depending on whether the output power was deemed to be low, medium or high. The low,
medium or high values where determined to be those outside +- 0.75*standard deviations
from the mean.

Energyusagebyday.png is a group of pie chart that clusters low, medium and high average power
outputs and outputs them for each day of the week, Monday through to Sunday.

Hist of all data.png is a histogram of all the data with a Gaussian fit onto it, it can be 
seen that although the data is vaguely Gaussian there are a lot of wild fluctuation towards
the lower end of the power output and the lower end tail does not extend as far as the 
upper end tail, this tells us that the power output is not completely Gaussian in data and 
therefore may well be quite difficult to get very accurate predictions.

Pie daily average.png is a pie chart of the daily average power grouped as low, medium and high.

Pie of all data.png is a pie chart of all the data grouped as low, medium and high power output.
