import numpy as np
import numpy.fft as fft
import matplotlib.pyplot as plt
import matplotlib.dates as md
import datetime as dt
import time
import pylab
import re

# Import dataset
data = np.genfromtxt('../../data/total_watt.csv', delimiter=',', dtype = None , names = ['time','energy'])

# Simple names
energy = data['energy']
datetime = data['time']

# Dimension
n = len(energy)

# String to timestamps and simple formats
datetime_new = [ dt.datetime.strftime(dt.datetime.strptime(date, '%Y-%m-%d %H:%M:%S'),'%m-%d %H:%M') for date in datetime]
timestamps = [time.mktime(dt.datetime.strptime(date, '%m-%d %H:%M').timetuple()) for date in datetime_new]   # In seconds
dates=[dt.datetime.fromtimestamp(ts) for ts in timestamps]
datenums = md.date2num(dates)
seconds = [ts - timestamps[0] for ts in timestamps]
minutes = [1/float(60)*ts for ts in seconds]
hours   = [1/float(60)*ts for ts in minutes]
days    = [1/float(24)*ts for ts in hours]


        
# Compute mean and std for raw data
mean_energy = np.mean(energy)
std_energy = np.std(energy)



# Interpolation for evenly spaced data
dts = np.min(np.diff(seconds))  # in seconds
dtm = np.min(np.diff(minutes))  # in minutes
dth = np.min(np.diff(hours))    # in hours
dtd = np.min(np.diff(days))     # in days

# Interpolation because uneven sampling
n_int = np.round((seconds[-1] - seconds[0])/dts) 
seconds_int = np.linspace(seconds[0],seconds[-1],n_int)
energy_int = np.interp(seconds_int,seconds,energy)
 
# Frequency in Hz
fft_energy = abs(fft.fft(energy_int))/n
fft_energy = 2*fft_energy[0:n/2]
k = np.arange(n_int)
fs = fft.fftfreq(n, dts); fs = fs[0:n/2]
fm = fft.fftfreq(n, dtm); fm = fm[0:n/2]
fh = fft.fftfreq(n, dth); fh = fh[0:n/2]
fd = fft.fftfreq(n, dtd); fd = fd[0:n/2] 
 
# Plot 0
plt.figure(0,figsize=(10,4))
time_axis = datenums;
plt.semilogy(time_axis,energy,'.')
plt.plot([time_axis[0],time_axis[-1]],[mean_energy,mean_energy],'--r')
xfmt = md.DateFormatter('%m-%d %H:%M')
ax=plt.gca()
ax.xaxis.set_major_formatter(xfmt)
plt.xticks( rotation=25 )
plt.xlabel('Date (m-d H:M)')
plt.ylabel('Energy consumption (W)')
plt.axis([np.min(time_axis),np.max(time_axis),0.8*np.min(energy),1.2*np.max(energy)])
plt.legend(('Raw data','Mean'))
plt.title('Energy consumption time-series (log/lin)')
plt.tight_layout()

# Plot 1
plt.figure(1,figsize=(10,4))
freq_axis = fh
plt.loglog(freq_axis,fft_energy)
plt.xlim([np.min(freq_axis),np.max(freq_axis)])
plt.xlabel('Frequency (1/hour)')
plt.ylabel('Energy consumption (W)')
indmax = np.argmax(fft_energy[1:])
plt.plot([freq_axis[indmax+1],freq_axis[indmax+1]],[0.8*np.min(fft_energy),1.2*np.max(fft_energy)],'r--')
plt.axis([np.min(freq_axis),np.max(freq_axis),0.8*np.min(fft_energy),1.2*np.max(fft_energy)])
plt.legend(('FFT of raw data','Dominant frequency'))
plt.title('Fourier analysis of the energy consumption time series')
plt.tight_layout()

# Plot 2
plt.figure(2,figsize=(10,4))
plt.hist(energy,10,log=True,histtype='stepfilled',alpha=1)
plt.hist(energy,100,log=True,histtype='stepfilled',alpha=1)
plt.hist(energy,1000,log=True,histtype='stepfilled',alpha=1)
plt.legend(('10 intervals','100 intervals','1000 intervals'))
plt.xlim([np.min(energy),np.max(energy)])
plt.xlabel('Energy range (W)')
plt.ylabel('Occurences')
plt.title('Histograms of the energy consumption time series')
plt.tight_layout() 
  
# Convert to hours or day visualization
time_unit = 'day'
if time_unit == 'hour':
    datetime_ave = [ dt.datetime.strftime(dt.datetime.strptime(date, '%Y-%m-%d %H:%M:%S'),'%m-%d %H:00') for date in datetime]
    timestamps_ave = [time.mktime(dt.datetime.strptime(date, '%m-%d %H:%M').timetuple()) for date in datetime_ave]   # In seconds
    dates_ave=[dt.datetime.fromtimestamp(ts) for ts in timestamps_ave]
    datenums_ave = md.date2num(dates_ave)
    time_to_ave = [dt.datetime.strptime(datetime_new[i], '%m-%d %H:%M').timetuple().tm_hour for i in range(n)]
elif time_unit == 'day':
    datetime_ave = [ dt.datetime.strftime(dt.datetime.strptime(date, '%Y-%m-%d %H:%M:%S'),'%m-%d 0') for date in datetime]
    timestamps_ave = [time.mktime(dt.datetime.strptime(date, '%m-%d %H').timetuple()) for date in datetime_ave]   # In seconds
    dates_ave=[dt.datetime.fromtimestamp(ts) for ts in timestamps_ave]
    datenums_ave = md.date2num(dates_ave)
    time_to_ave = [dt.datetime.strptime(datetime_new[i], '%m-%d %H:%M').timetuple().tm_mday for i in range(n)]

i = 0 # Raw data index
j = 0 # Averaging index
k = 0 # Final average index
energy_ave = []
date_ave = []
for i in range(n):
    if i == 0:
        energy_ave.append(0)
        date_ave.append(datenums_ave[i])
    if i > 0 and time_to_ave[i] != time_to_ave[i-1]:
        j = 0
        k += 1
        energy_ave.append(0)
        date_ave.append(datenums_ave[i])
    energy_ave[k] = (j*energy_ave[k] + energy[i])/(float(j)+1)
    j += 1
    
time_ave = range(k+1)
time_ave = [time_ave_val - 0.5 for time_ave_val in time_ave] 

# Compute moment
mean = np.mean(energy_ave)
std = np.std(energy_ave)
lim_up = mean + std/2
lim_down = mean - std/2


# Plot 3
plt.figure(3,figsize=(10,4))
time_axis = date_ave
if time_unit == 'day':
    width = 1
elif time_unit == 'hour':
    width = 1/float(24)
b1 = plt.bar(time_axis,energy_ave,width=width,edgecolor = 'k')
p2, = plt.plot([time_axis[0],time_axis[-1]],[mean,mean],'--k')
p3, = plt.plot([time_axis[0],time_axis[-1]],[lim_up,lim_up],'-.k')
p4, = plt.plot([time_axis[0],time_axis[-1]],[lim_down,lim_down],'-.k')
plt.axis([time_axis[0],time_axis[-1],np.min(energy_ave)*0.8,np.max(energy_ave)*1.2])
xfmt = md.DateFormatter('%m-%d')
ax=plt.gca()
ax.xaxis.set_major_formatter(xfmt)
plt.xticks( rotation=25 )
plt.legend([b1,p2,p3],['Daily energy consumption','Mean daily energy consumption','Mean +/-  0.5*std'])
plt.title('Daily energy consumption')
if time_unit == 'day':
    plt.xlabel('Date (m-d)')
elif time_unit == 'day':
    plt.xlabel('Date (m-d H:00)')
plt.ylabel('Energy consumption (W)')
plt.tight_layout()

# Cluster
low_energy = []
medium_energy = []
high_energy = []
low_date_ave = []
medium_date_ave = []
high_date_ave = []
for i in range(len(energy_ave)):
    if energy_ave[i] <= lim_down:
        low_energy.append(energy_ave[i])
        low_date_ave.append(date_ave[i])
    elif lim_down < energy_ave[i] <= lim_up:
        medium_energy.append(energy_ave[i])
        medium_date_ave.append(date_ave[i])
    elif lim_up <= energy_ave[i]:
        high_energy.append(energy_ave[i])
        high_date_ave.append(date_ave[i])


# Pie chart
total_low_ener = np.sum(low_energy)
total_medium_ener = np.sum(medium_energy)
total_high_ener = np.sum(high_energy)
n_low_ener = len(low_energy)
n_medium_ener = len(medium_energy)
n_high_ener = len(high_energy)

# plot 4
plt.figure(4,figsize=(12,6))
plt.subplot(1, 2, 1)
labels = ('Low', 'Medium', 'High')
fracs = [total_low_ener, total_medium_ener, total_high_ener]
plt.pie(fracs, labels=labels,autopct='%1.1f%%',startangle=90,explode=[0.01,0.01,0.01],labeldistance=1.1)
plt.title('Daily energy consumption (% of energy volume)')
plt.tight_layout()

plt.subplot(1, 2, 2)
labels = ('Low', 'Medium', 'High')
fracs = [n_low_ener, n_medium_ener, n_high_ener]
plt.pie(fracs, labels=labels,autopct='%1.1f%%',startangle=90,explode=[0.01,0.01,0.01],labeldistance=1.1)
plt.title('Daily energy consumption (% of days)')
plt.tight_layout()


# plot 5
plt.figure(5,figsize=(10,4))
b1 = plt.bar(low_date_ave,low_energy,width=width,color='b',edgecolor ='k')
b2 = plt.bar(medium_date_ave,medium_energy,width=width,color='g',edgecolor ='k')
b3 = plt.bar(high_date_ave,high_energy,width=width,color='r',edgecolor ='k')
p4, = plt.plot([time_axis[0],time_axis[-1]],[mean,mean],'--k')
p5, = plt.plot([time_axis[0],time_axis[-1]],[lim_up,lim_up],'-.k')
p6, = plt.plot([time_axis[0],time_axis[-1]],[lim_down,lim_down],'-.k')
plt.axis([time_axis[0],time_axis[-1],np.min(energy_ave)*0.8,np.max(energy_ave)*1.2])
xfmt = md.DateFormatter('%m-%d')
ax=plt.gca()
ax.xaxis.set_major_formatter(xfmt)
plt.xticks( rotation=25 )
plt.legend([b1,b2,b3,p4,p5],['Low','Medium','High','Mean daily energy consumption','Mean +/-  0.5*std'])
plt.title('Daily energy consumption coloured by level')
if time_unit == 'day':
    plt.xlabel('Date (m-d)')
elif time_unit == 'day':
    plt.xlabel('Date (m-d H:00)')
plt.ylabel('Energy consumption (W)')
plt.tight_layout()


# Show
pylab.show()
