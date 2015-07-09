from matplotlib import style
from matplotlib import pylab as plt
            
style.use('ggplot')
                
MY_FILE='total_watt.csv'
date=[]
consumption=[]
                            
import csv
with open(MY_FILE, 'rb') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')
    for row in csvreader:
        if len(row) ==2 :
            date.append(row[0])
            consumption.append(row[1])

                                                            
import datetime
for x in range(len(date)):
    date[x]=datetime.datetime.strptime(date[x], '%Y-%m-%d %H:%M:%S')
                                                                        
plt.plot(date,consumption)
                                                                            
plt.title('Energy Consumption per 30 mins')
plt.xlabel('time')
plt.ylabel('energy consumption')

plt.show()