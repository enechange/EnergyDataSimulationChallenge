# -*- coding: utf-8 -*-
"""
Created on Tue Sep 09 13:19:35 2014

@author: Dan
"""

import pandas as pd
import pylab as pl
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from datetime import datetime
import math
import numpy as np
import scipy.stats as stats

df = pd.read_csv('C:/Users/Dan/Documents/GitHub/EnergyDataSimulationChallenge/challenge2/data/total_watt.csv', header = None)

def thirtyminutes(data):
    date = []  #create an empty list called date for adding the datetime to
    for row in data[0]:    #scans each row             
        date.append(datetime.strptime(row,"%Y-%m-%d %H:%M:%S"))  #appends the data with the datetime from that row use  %Y-%m-%d (%H:%M)
    data['Date']=date
    x = pl.date2num(data['Date'])
    y = []   
    for i in data[1]:
        y.append(math.log10(i))#log the values because it's slightly clearer than the straight values
    m = np.mean(y)
    s = np.std(y)
    plt.scatter(x,y)
    plt.plot([x.min(), x.max()],[m,m],'r-')
    plt.plot([x.min(),x.max()],[m+0.75*s, m+0.75*s], 'r--')
    plt.plot([x.min(),x.max()],[m-0.75*s, m-0.75*s], 'r--')
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d'))
    plt.xticks(rotation=45)
    plt.xlabel('Date')
    plt.ylabel('Log base 10 of Power(Watts)')
    plt.title('Visualisation of All Data Points')
    plt.xlim(x.min(), x.max())
    plt.ylim(1.6,4.1)
    plt.show()
    
    low = []
    lowdate = []
    medium = []
    meddate= []
    high = []
    highdate = []
    for i,j in zip(y, x):
        if i <= m-0.75*s:
            low.append(i)
            lowdate.append(j)
        elif i >= m+0.75*s:
            high.append(i)
            highdate.append(j)
        else:
            medium.append(i)
            meddate.append(j)
    total = len(low) + len(medium) + len(high)
    frac = []
    frac.append(100*len(low)/total)
    frac.append(100*len(medium)/total)
    frac.append(100*len(high)/total)
    plt.pie(frac, labels = ['Low','Medium','High'])
    plt.title('Average Power Usage Levels (All Points)')
    plt.show()
    
    y = sorted(y)
    plt.hist(y, bins = 100, normed = True)
    plt.ylabel('Percentage of Points in Range')
    plt.xlabel('Log Base 10 Power in Watts')
    plt.title('Histogram of 30 Minute Values')
    fit = stats.norm.pdf(y, np.mean(y), np.std(y))
    plt.plot(y, fit, 'r-', label = 'Gaussian Line')
    plt.legend(loc = 'best')
    plt.show()
    
thirtyminutes(df)




def daily(data):
    day = []
    for i in data[0]:
        day.append(datetime.strptime(i[0:10], "%Y-%m-%d"))
    data['Day'] = day
    uniquedays = list(data.apply(set)['Day'])
    dailymean = []
    for i in uniquedays:
        dd = data[data['Day'] == i]
        averagepower = []
        for row in dd[1]:
            averagepower.append(row)
        dailymean.append(np.mean(averagepower))
    x = pl.date2num(uniquedays)
    y = dailymean
    m = np.mean(y)
    s = np.std(y)
    plt.bar(x,y)
    plt.plot([x.min(), x.max()],[m,m],'k-')
    plt.plot([x.min(),x.max()],[m+0.75*s, m+0.75*s], 'k--')
    plt.plot([x.min(),x.max()],[m-0.75*s, m-0.75*s], 'k--')
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d'))
    plt.xticks(rotation=45)
    plt.xlabel('Date')
    plt.ylabel('Daily Power Consumption (W)')
    plt.title('Average Daily Power Consumption')
    plt.xlim([x.min(), x.max()])
    plt.show()
    
    
    low = []
    lowdate = []
    medium = []
    meddate= []
    high = []
    highdate = []
    for i,j in zip(y, x):
        if i <= m-0.75*s:
            low.append(i)
            lowdate.append(j)
        elif i >= m+0.75*s:
            high.append(i)
            highdate.append(j)
        else:
            medium.append(i)
            meddate.append(j)
    plt.bar(lowdate,low, color = 'blue', label = 'Low')
    plt.bar(meddate,medium, color = 'green', label = 'Medium')
    plt.bar(highdate,high,color = 'red', label = 'High')
    plt.plot([x.min(), x.max()],[m,m],'k-')
    plt.plot([x.min(),x.max()],[m+0.75*s, m+0.75*s], 'k--')
    plt.plot([x.min(),x.max()],[m-0.75*s, m-0.75*s], 'k--')
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d'))
    plt.xticks(rotation=45)
    plt.legend(loc = 'best')
    plt.xlabel('Date')
    plt.ylabel('Daily Power Consumption (W)')
    plt.title('Average Daily Power Consumption')
    plt.xlim([x.min(), x.max()])
    plt.show()


    total = len(low) + len(medium) + len(high)
    frac = []
    frac.append(100*len(low)/total)
    frac.append(100*len(medium)/total)
    frac.append(100*len(high)/total)
    plt.pie(frac, labels = ['Low','Medium','High'])
    plt.title('Average Daily Power Usage Levels')
    plt.show()
daily(df)

    
#tidy
    