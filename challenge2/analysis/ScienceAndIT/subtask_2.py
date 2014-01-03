import datetime as dt
import matplotlib as mpl
from matplotlib import pyplot as plt
import matplotlib.cm as cm  # matplotlib colormap module
from matplotlib.dates import date2num
from collections import OrderedDict

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
    data.append((dt.datetime.strptime(key, "%Y-%m-%d"), ordered_energy_consumption_per_day[key]))

#convert dates into float numbers (can be inefficient with a large amount of data)
x = [date2num(date) for (date, value) in data]
y = [value for (date, value) in data]

#preparing to plot
fig = plt.figure()
graph = fig.add_subplot(111)
graph.grid(True)
y_max = 70000  # max range of y-axis
width = 0.3
plt.yticks(range(0, 75000, 2500))
plt.axis([x[0]-1, x[len(x)-1]+1, 0, y_max])

# Plot the data
for i in range(len(data)):
    graph.bar(data[i][0], data[i][1], width=width, color=cm.hsv(int(data[i][1]/255)))

#formatting dates
dateFmt = mpl.dates.DateFormatter('%Y-%m-%d')
graph.xaxis.set_major_formatter(dateFmt)
daysLoc = mpl.dates.DayLocator(interval=1)
graph.xaxis.set_major_locator(daysLoc)
fig.autofmt_xdate(bottom=0.15, rotation=45)  # adjust for date labels display
fig.subplots_adjust(left=0.15)

#annotations and titles
x_label = plt.xlabel('\nDate')
plt.setp(x_label, fontsize=24, color='black')
y_label = plt.ylabel('Energy consumption [W]\n')
plt.setp(y_label, fontsize=24, color='black')
title = plt.title('Energy consumption per day\n')
plt.setp(title, fontsize=28, color='black')

plt.annotate('No data available on\n2011-05-04 and 2011-05-05',
             xy=(x[16]-1.5, 25000), xytext=(x[16]-1.5, 50000),
             arrowprops=dict(facecolor='black', shrink=0.05, width=5))

#show everything
plt.show()