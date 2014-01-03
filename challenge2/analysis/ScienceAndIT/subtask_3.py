import datetime as dt
import matplotlib as mpl
import numpy as np

from matplotlib import pyplot as plt
from matplotlib.dates import date2num
from collections import OrderedDict
from scipy.cluster.vq import kmeans2

# extract data from a file and save it as a list of tuples
with open('total_watt.csv', 'r+') as file_to_analysis:
    time_stamp = []
    energy_consumption = []
    energy_consumption_per_day = {}
    for line in file_to_analysis.readlines():
        line = line.split(',')
        time_stamp.append(line[0])
        energy_consumption.append(line[1])
        energy_consumption_per_day[line[0][:10]] = energy_consumption_per_day.get(line[0][:10], 0) + float(line[1])

ordered_energy_consumption_per_day = OrderedDict(sorted(energy_consumption_per_day.items(), key=lambda t: t[0]))
data = []

for key in ordered_energy_consumption_per_day:
    data.append((date2num(dt.datetime.strptime(key, "%Y-%m-%d")), ordered_energy_consumption_per_day[key]))

#transform data into NumPy array
numpy_data = np.asarray(data)

#define your own starting centroids (could be useful)
my_centroids = np.array([[734264.0, 25000.0], [734264.0, 12000.0], [734264.0, 50000.0]])

#k-means algorithm
centroids, labels = kmeans2(numpy_data, my_centroids)

#preparing to plot
fig = plt.figure()
graph = fig.add_subplot(111)
graph.grid(True)
y_max = 70000  # max range of y-axis
width = 0.3
plt.yticks(range(0, 75000, 2500))
plt.axis([data[0][0], data[len(data)-1][0], 0, y_max])
fig.autofmt_xdate(bottom=0.15, rotation=45)  # adjust for date labels display
fig.subplots_adjust(left=0.15)

# Plot the data
for i in range(len(data)):
    if labels[i] == 0:
        medium_level = graph.bar(data[i][0], data[i][1], width=width, color='yellow', label='Medium')
    elif labels[i] == 1:
        low_level = graph.bar(data[i][0], data[i][1], width=width, color='green', label='Low')
    elif labels[i] == 2:
        high_level = graph.bar(data[i][0], data[i][1], width=width, color='red', label='High')
    else:
        pass

#formatting dates
dateFmt = mpl.dates.DateFormatter('%Y-%m-%d')
graph.xaxis.set_major_formatter(dateFmt)
daysLoc = mpl.dates.DayLocator(interval=1)
graph.xaxis.set_major_locator(daysLoc)

#annotations and titles
x_label = plt.xlabel('\nDate')
plt.setp(x_label, fontsize=24, color='black')
y_label = plt.ylabel('Energy consumption [W]\n')
plt.setp(y_label, fontsize=24, color='black')
title = plt.title('Energy consumption per day (clustering)\n')
plt.setp(title, fontsize=28, color='black')

#legend
plt.legend((high_level, medium_level, low_level), ('High', 'Medium', 'Low'),
           title='Energy consumption', loc='upper right')

#show everything
plt.show()




