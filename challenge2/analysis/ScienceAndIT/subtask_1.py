import datetime as dt
import matplotlib as mpl
from matplotlib import pyplot as plt
from matplotlib.dates import date2num, num2date
from math import ceil, floor
from datacursor import DataCursor, HighlightingDataCursor

# extract data from a file and save it as a list of tuples
with open('total_watt.csv', 'r+') as file_to_analysis:
    time_stamp = []  # auxiliary list for time stamps
    energy_consumption = []  # auxiliary list for energy values
    for line in file_to_analysis.readlines():
        line = line.split(',')
        time_stamp.append(line[0])
        energy_consumption.append(line[1])
data = []
for i in range(len(time_stamp) - 1):
    data.append((dt.datetime.strptime(time_stamp[i], "%Y-%m-%d %H:%M:%S"), float(energy_consumption[i])))

#convert dates into float numbers (could be useful when working with NumPy,
# but can be inefficient with a large amount of data)
x = [date2num(date) for (date, value) in data]
y = [value for (date, value) in data]

#preparing to plot
fig = plt.figure()
graph = fig.add_subplot(111)
graph.grid(True)
y_max = 10000  # max range of y-axis
width = 0.01   # width of single bar
plt.yticks(range(0, y_max, 500))
plt.axis([x[0]-1, x[len(x)-1]+1, 0, y_max])

#plot the data
for j in range(len(data)):
    graph.bar(data[j][0], data[j][1], width=width, color='blue')

#plotting dotted lines to separate days
for k in range(23, len(data), 48):
    plt.plot([ceil(x[k]), ceil(x[k])], [0, y_max], 'g--')
plt.plot([floor(x[23]), floor(x[23])], [0, y_max], 'g--')

#annotations and titles
x_label = plt.xlabel('\nDate')
plt.setp(x_label, fontsize=24, color='black')
y_label = plt.ylabel('Energy consumption [W]\n')
plt.setp(y_label, fontsize=24, color='black')
title = plt.title('Energy consumption (measured every 30 minutes)\n')
plt.setp(title, fontsize=28, color='black')
fig.autofmt_xdate(bottom=0.15, rotation=45)  # adjust for date labels display
fig.subplots_adjust(left=0.15)


#formatting dates
dateFmt = mpl.dates.DateFormatter('%Y-%m-%d')
graph.xaxis.set_major_formatter(dateFmt)
daysLoc = mpl.dates.DayLocator(interval=1)
#hoursLoc = mpl.dates.HourLocator(interval=1)
graph.xaxis.set_major_locator(daysLoc)
#graph.xaxis.set_minor_locator(hoursLoc)

#annotates
plt.annotate('No data available from\n2011-05-03 (21:22) to\n 2011-05-06 (14:22)',
             xy=(x[731]+1.5, 2000), xytext=(x[731]+1.5, 7000), color='red',
             arrowprops=dict(facecolor='red', shrink=0.05, width=5))
plt.figtext(0.65, 0.04, '* you can click the data to get the detailed information', color='green')

#show everything
DataCursor(graph, xytext=(15, 15))
plt.show()