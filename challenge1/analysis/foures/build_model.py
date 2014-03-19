import numpy as np
import matplotlib.pyplot as plt
import pylab
from sklearn import linear_model

# plt.ion()

# filename = '../../data/training_dataset_500.csv'
filename = '../../data/dataset_500.csv'

data = np.genfromtxt(filename, delimiter = ',', names = True, dtype= None)
print(data.dtype)

label = data['Label']
set_label = list(set(label))
nlabel = len(set_label)
house = data['House']
set_house = list(set(house))
nhouse = len(set_house)
year = data['Year']
month = data['Month']
temperature = data['Temperature']
daylight = data['Daylight']
energy_production = data['EnergyProduction']


n = 0
mean_temp = []

mean_temperature = [0]*nlabel
mean_daylight = [0]*nlabel
mean_energy_production = [0]*nlabel

plt.figure(0)
for house_i in set_house:
    
    mean_temperature = [ (n*mean_temperature[label_i] + temperature[nlabel*(house_i-1):nlabel*house_i][label_i])/(n+1) for label_i in set_label ]
    mean_daylight = [ (n*mean_daylight[label_i] + daylight[nlabel*(house_i-1):nlabel*house_i][label_i])/(n+1) for label_i in set_label ]
    mean_energy_production = [ (n*mean_energy_production[label_i] + energy_production[nlabel*(house_i-1):nlabel*house_i][label_i])/(n+1) for label_i in set_label ]
    
    plt.subplot(3,3,1)
    plt.plot(set_label,temperature[nlabel*(house_i-1):nlabel*house_i])
    plt.subplot(3,3,2)
    plt.plot(set_label,daylight[nlabel*(house_i-1):nlabel*house_i])
    plt.subplot(3,3,3)
    plt.plot(set_label,energy_production[nlabel*(house_i-1):nlabel*house_i])

    n += 1
    
#     raw_input('Here.')
#     plt.draw()

plt.subplot(3,3,4)
plt.plot(set_label,mean_temperature,linewidth = 2)
plt.subplot(3,3,5)
plt.plot(set_label,mean_daylight,linewidth = 2)
plt.subplot(3,3,6)
plt.plot(set_label,mean_energy_production,linewidth = 2)

diff_temperature = []
diff_daylight = []
diff_energy_production = []
    

for house_i in set_house:
    
    diff_temperature += [ temperature[nlabel*(house_i-1):nlabel*house_i][label_i] - mean_temperature[label_i] for label_i in set_label ]
    diff_daylight += [ daylight[nlabel*(house_i-1):nlabel*house_i][label_i] - mean_daylight[label_i] for label_i in set_label ]
    diff_energy_production += [ energy_production[nlabel*(house_i-1):nlabel*house_i][label_i] - mean_energy_production[label_i] for label_i in set_label ]
    
    plt.figure(0)
    plt.subplot(3,3,7)
    plt.plot(set_label,diff_temperature[nlabel*(house_i-1):nlabel*house_i])
    plt.subplot(3,3,8)
    plt.plot(set_label,diff_daylight[nlabel*(house_i-1):nlabel*house_i])
    plt.subplot(3,3,9)
    plt.plot(set_label,diff_energy_production[nlabel*(house_i-1):nlabel*house_i])

    plt.figure(1)
    plt.subplot(1,3,1)
    plt.plot(np.mean(temperature[nlabel*(house_i-1):nlabel*house_i]),np.mean(daylight[nlabel*(house_i-1):nlabel*house_i]),'.')
    plt.subplot(1,3,2)
    plt.plot(np.mean(temperature[nlabel*(house_i-1):nlabel*house_i]),np.mean(energy_production[nlabel*(house_i-1):nlabel*house_i]),'.')
    plt.subplot(1,3,3)
    plt.plot(np.mean(daylight[nlabel*(house_i-1):nlabel*house_i]),np.mean(energy_production[nlabel*(house_i-1):nlabel*house_i]),'.')
    
#     raw_input('Here.')
#     plt.draw()

    mode = 'full'
    tt = np.correlate(temperature[nlabel*(house_i-1):nlabel*house_i], temperature[nlabel*(house_i-1):nlabel*house_i], mode=mode)
#     tt = tt[len(tt)/2:]
    dd = np.correlate(daylight[nlabel*(house_i-1):nlabel*house_i], daylight[nlabel*(house_i-1):nlabel*house_i], mode=mode)
    dd = dd[len(dd)/2:]
    ee = np.correlate(energy_production[nlabel*(house_i-1):nlabel*house_i], energy_production[nlabel*(house_i-1):nlabel*house_i], mode=mode)
    ee = ee[len(ee)/2:]
    td = np.correlate(temperature[nlabel*(house_i-1):nlabel*house_i], daylight[nlabel*(house_i-1):nlabel*house_i], mode=mode)
    td = td[len(td)/2:]
    te = np.correlate(temperature[nlabel*(house_i-1):nlabel*house_i], energy_production[nlabel*(house_i-1):nlabel*house_i], mode=mode)
    te = te[len(te)/2:]
    de = np.correlate(daylight[nlabel*(house_i-1):nlabel*house_i], energy_production[nlabel*(house_i-1):nlabel*house_i], mode=mode)
    de = de[len(de)/2:]
    

    plt.figure(2,figsize=(10,5))
    plt.subplot(3,2,1)
    plt.plot(tt)
    plt.ylabel('Temp-Temp')
    plt.subplot(3,2,3)
    plt.plot(dd)
    plt.ylabel('Light-Light')
    plt.subplot(3,2,5)
    plt.plot(ee)
    plt.ylabel('Ener-Ener')
    plt.subplot(3,2,2)
    plt.plot(td)
    plt.ylabel('Temp-Light')
    plt.subplot(3,2,4)
    plt.plot(te)
    plt.ylabel('Temp-Ener')
    plt.subplot(3,2,6)
    plt.plot(de)
    plt.ylabel('Light-Ener')

plt.show()
    
    
# Linear regression

# clf = linear_model.LinearRegression()
# 
# a = [0]*nhouse
# b = [0]*nhouse
# c = [0]*nhouse
# for house_i in set_house:
#     clf.fit([[daylight[nlabel*(house_i-1):nlabel*house_i][label_i],temperature[nlabel*(house_i-1):nlabel*house_i][label_i]] for label_i in set_label],[energy_production[nlabel*(house_i-1):nlabel*house_i][label_i] for label_i in set_label])
#     a[house_i-1] = clf.coef_[0]
#     b[house_i-1] = clf.coef_[1]
#     c[house_i-1] = clf.intercept_  
# 
# plt.figure(1)
# plt.subplot(3,1,1)
# plt.plot(a,'.')
# plt.subplot(3,1,2)
# plt.plot(b,'.')
# plt.subplot(3,1,3)
# plt.plot(c,'.')
# 
# plt.show()