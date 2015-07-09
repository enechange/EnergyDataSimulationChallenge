from matplotlib import style
from matplotlib import pylab as plt
import pandas as pd

style.use('ggplot')

MY_FILE='total_watt.csv'
date=[]
consumption=[]


df = pd.read_csv('total_watt.csv', parse_dates=[0], index_col=[0])
df = df.resample('1D', how='sum')

for row in df:
    if len(row) ==2 :
        date.append(row[0])
        consumption.append(row[1])

import datetime
for x in range(len(date)):
    date[x]=datetime.datetime.strptime(date[x], '%Y-%m-%d %H:%M:%S')

df.plot()

plt.title('Energy Consumptions per day')
plt.xlabel('days')
plt.ylabel('energy consumption')

plt.show()