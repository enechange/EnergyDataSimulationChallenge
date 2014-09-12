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

#function used inside thiryminutes function to draw pie chart (avoids repetition of code)
def pie(y,m,s,when):
    low = []  #clustering lists
    medium = []
    high = []
    for i in y:  #for each i and j in power and date respectively
        if i <= m-0.75*s:  #if the element is classed as low
            low.append(i)
        elif i >= m+0.75*s:  #repeat for high values
            high.append(i)
        else:
            medium.append(i)  #repeat for medium values
    total = len(low) + len(medium) + len(high)
    frac = []
    frac.append(100*len(low)/total)  #find fractions that are high, medium and low
    frac.append(100*len(medium)/total)
    frac.append(100*len(high)/total)
    plt.pie(frac, labels = ['Low','Medium','High'])  #plot a pie chart of that data
    plt.title('Average Power Usage Levels ('+when+')')
    plt.show()


#function to deal with visualisation of thirty minute values (including some clustering)
def thirtyminutes(data):
    date = []  #create an empty list called date for adding the datetime to
    for row in data[0]:    #scans each row             
        date.append(datetime.strptime(row,"%Y-%m-%d %H:%M:%S"))  #appends the data with the datetime from that row use  %Y-%m-%d (%H:%M)
    data['Date']=date  #put into new column called Date
    x = pl.date2num(data['Date']) #assign x and y values, x date needs to be converted to number
    y = []   
    for i in data[1]:
        y.append(math.log10(i))#log the values because it's slightly clearer than the straight values
    m = np.mean(y) #find the mean
    s = np.std(y) #find the standard deviation
    plt.scatter(x,y)
    plt.plot([x.min(), x.max()],[m,m],'r-', label = 'Mean') #plot the mean line
    plt.plot([x.min(),x.max()],[m+0.75*s, m+0.75*s], 'r--', label = '+-0.75*Std') #plot lines 0.75 time std above and below the mean line
    plt.plot([x.min(),x.max()],[m-0.75*s, m-0.75*s], 'r--')
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d')) #convert the x axis back into date form
    plt.xticks(rotation=45)
    plt.legend(loc = 'best')
    plt.xlabel('Date')
    plt.ylabel('Log base 10 of Power(Watts)')
    plt.title('Visualisation of All Data Points')
    plt.xlim(x.min(), x.max())
    plt.ylim(1.6,4.1)
    plt.show()
    
    pie(y,m,s, 'All Points')
    
    y = sorted(y)  #sort the y data into numerical order
    plt.hist(y, bins = 100, normed = True) #plot a histogram
    plt.ylabel('Percentage of Points in Range')
    plt.xlabel('Log Base 10 Power in Watts')
    plt.title('Histogram of 30 Minute Values')
    fit = stats.norm.pdf(y, np.mean(y), np.std(y)) #add a Gaussian fit
    plt.plot(y, fit, 'r-', label = 'Gaussian Line')  #add a Gaussian line, to see whether the data is close to Gaussian or not
    plt.legend(loc = 'best')
    plt.show()
thirtyminutes(df)



#function to deal with visualisation of daily data, including clustering
def daily(data):
    day = []  #get an empty day list
    for i in data[0]:
        day.append(datetime.strptime(i[0:10], "%Y-%m-%d"))  #append the date to the day list
    data['Day'] = day
    uniquedays = list(data.apply(set)['Day'])  #create a list of all the days in the list
    dailymean = []
    for i in uniquedays:  #for each day in the list
        dd = data[data['Day'] == i]  #create a new dataset that only has the date i
        averagepower = []
        for row in dd[1]: #then for each row in the new dataset for each day
            averagepower.append(row)  #append the power to a new list
        dailymean.append(np.mean(averagepower))  #then find the mean of the new list, repeat for each day
    x = pl.date2num(uniquedays)  #x values are now the unique days
    y = dailymean
    m = np.mean(y) #find mean
    s = np.std(y) #find standard deviation
    plt.bar(x,y)  #plot a bar graph
    plt.plot([x.min(), x.max()],[m,m],'k-', label = 'Mean')  #same lines as in the 30 minute section, mean, std*0.75
    plt.plot([x.min(),x.max()],[m+0.75*s, m+0.75*s], 'k--', label = '+- 0.75*Std')
    plt.plot([x.min(),x.max()],[m-0.75*s, m-0.75*s], 'k--')
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d'))
    plt.xticks(rotation=45)
    plt.legend(loc = 'best')
    plt.xlabel('Date')
    plt.ylabel('Daily Power Consumption (W)')
    plt.title('Average Daily Power Consumption')
    plt.xlim([x.min(), x.max()])
    plt.show()
    
    #clustering
    pie(y,m,s, 'Daily')
    
    lowdate = []
    low = []
    meddate= []
    medium = []
    highdate = []
    high = []
    for i,j in zip(y, x):  #for each i and j in power and date respectively
        if i <= m-0.75*s:  #if the element is classed as low
            low.append(i)
            lowdate.append(j) #append it's value and it's date to the low lists respectively.
        elif i >= m+0.75*s:  #repeat for high values
            high.append(i)
            highdate.append(j)
        else:
            medium.append(i)  #repeat for medium values
            meddate.append(j)
    plt.bar(lowdate,low, color = 'blue', label = 'Low')  #plot a bar graph with the clusters coloured in
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

    x = sorted(x) #sort the x list in date order
    data['Date2Num'] = pl.date2num(data['Day'])  #create column of date numbers in the dataset
    weekday = []
    for i in data['Date2Num']: #for each row in the date number dataset
        count = -1
        for j in x: #for each element in the sorted list of unique dates
            count += 1
            if count%7 ==0: #this starts the count again every time it hits a monday
                count = 0
            if i == j:  #this appends the weekday list with the days corresponding number
                weekday.append(count)
    data['Weekday'] = weekday #add the weekday column to the dataset
    for i,j in zip([0,1,2,3,4,5,6],['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']): #create a pie chart for each day, the list of days and corresponding numbers is evident here  
         dd = data[data['Weekday'] == i] 
         pie(dd[1],m,s,j)
daily(df)  

