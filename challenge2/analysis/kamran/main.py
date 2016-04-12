Cimport pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import datetime
from mpl_toolkits import mplot3d
import scipy.cluster.vq as vq

def visualise_raw(raw_file):
	"""
	Plots consumption as a function of time, binned in 30-minute intervals. Can be seen on an intra-day scale if one zooms in on the interactive graph.
	"""
	thirty_mean = raw_file.mean()[0]
	thirty_median = raw_file.median()[0]
	thirty_std_dev = round(raw_file.std()[0],2)
	plt.figure(0)
	l0 = plt.plot(raw_file['Date-Time'],raw_file['Consumption'], label = '30-min Consumption', linewidth = 0.5)
	mean0 = plt.axhline(y = thirty_mean, color = 'g', ls = 'dashed', label = '30-min Mean')
	mean0_plus = plt.axhline(y = thirty_mean + thirty_std_dev, color = 'g', ls = '-.', label = '30-min Mean $ \pm \, \sigma$')
	median0 = plt.axhline(y = thirty_median, color = 'r', ls = 'dashed', label = '30-min Median')
	plt.legend(frameon = False)
	plt.xlabel('Date & Time')
	plt.ylabel('Consumption (Wh)')
	plt.title('Consumption for 30-min intervals')
	plt.gcf().autofmt_xdate(bottom = 0.15, rotation = 45)
	plt.savefig('30-min_consumption.jpg')

def visualise_grouped(raw_file):
	"""
	Plots consumption as a function of time, binned into one day intervals.
	"""
	grouped_by_day = raw_file.groupby(raw_file['Date']).sum() #grouped and summed by day. No longer contains time info, as grouping loses non-numerical columns
	daily_mean = grouped_by_day.mean()[0]
	daily_median = grouped_by_day.median()[0]
	daily_std_dev = round(grouped_by_day.std()[0],2)
	plt.figure(1)
	b1 = plt.bar(grouped_by_day.index, grouped_by_day['Consumption'], label = 'Daily Consumption')
	mean1 = plt.axhline(y = daily_mean, color = 'g', ls = 'dashed', label = 'Daily Mean')
	mean1_plus = plt.axhline(y = daily_mean + daily_std_dev, color = 'g', ls = '-.', label = 'Daily Mean $ \pm \sigma$')
	mean1_minus = plt.axhline(y = daily_mean - daily_std_dev, color = 'g', ls = '-.', label = 'Daily Mean $ \pm \sigma$')
	median1 = plt.axhline(y = daily_median, color = 'r', ls = 'dashed', label = 'Daily Median')
	plt.legend([b1,mean1,mean1_minus,median1], ['Daily Consumption', 'Daily Mean', 'Daily Mean $ \pm \, \sigma$', 'Daily Median'] , frameon = False)
	plt.xlabel('Date')
	plt.ylabel('Consumption (Wh)')
	plt.title('Consumption aggregated per day')
	plt.gcf().autofmt_xdate(bottom = 0.15, rotation = 45)
	plt.savefig('daily_consumption.jpg')

def visualise_raw_3d(raw_file):
	"""
	Plot Consumption as a function of time and date separately, giving a great visualisation of when the peak consumption occurs along these two dimensions. (xx, yy) is a 2-d array containing x-y domain. Consumption is plotted on z-axis.
	"""
	pv = raw_file.pivot(index='Time', columns='Date', values='Consumption') #get 2d grid of consumption values for mesh of surface
	pv = pv.fillna(0.) #fill in blanks in consumption values grid
	xx, yy = np.mgrid[0:len(pv),0:len(pv.columns)] #get 2d grid of times and dates
	zz = pv.values
	plt.figure(2)
	s2 = plt.gca(projection = '3d').plot_surface(xx, yy, zz, cmap = 'jet', cstride=1, rstride=1)
	plt.xlabel('Time')
	plt.ylabel('Date')
	plt.gca().set_zlabel('Consumption (Wh)')
	plt.title('Consumption for 30-min intervals')
	plt.gcf().colorbar(s2, shrink=0.5, aspect=10)
	times = [x.strftime('%H:%M') for x in pv.index]
	dates = [x.strftime('%m-%d') for x in pv.columns]
	plt.gca().set_xticklabels(times[::10])
	plt.gca().set_xticks(xx[::10,0])
	plt.gca().set_yticklabels(dates[::10])
	plt.gca().set_yticks(yy[0,::10])
	plt.gca().set_zticklabels(['','2000','4000','6000','8000','10000'])
	plt.savefig('daily_consumption_3d.jpg')

def cluster_consumption(raw_file):
	"""
	Performs 1d K-means clustering (K = 3) on consumption values. No need for feature scaling.
	"""
	grouped_by_day = raw_file.groupby(raw_file['Date']).sum() #grouped and summed by day. No longer contains time info, as grouping loses non-numerical columns
	oned_centroids, data_labels = vq.kmeans2(grouped_by_day.values,3) #1d clustering in consumption space. No need to feature scale as it is 1d.
	low_points = []
	med_points = []
	high_points = []
	for i in range(len(data_labels)):
		if data_labels[i] == 0: low_points.append(grouped_by_day.values[i,0])
		elif data_labels[i] == 1: med_points.append(grouped_by_day.values[i,0])
		else: high_points.append(grouped_by_day.values[i,0])
	plt.figure(3, figsize=(10,5))
	low_plot = plt.plot(low_points, len(low_points)*[0], 'y+', alpha = 0.8, ms = 7.5, label = 'Low Cluster Points')
	med_plot = plt.plot(med_points, len(med_points)*[0], 'g+', alpha = 0.8, ms = 7.5, label = 'Medium Cluster Points')
	high_plot = plt.plot(high_points, len(high_points)*[0], 'b+', alpha = 0.8, ms = 7.5, label = 'High Cluster Points')
	clusters_plot = plt.scatter(oned_centroids, len(oned_centroids)*[0], marker = 'x', c = 'r', s = 100, label = 'Cluster Centroids' )
	plt.title('Consumption Clustering for one day intervals')
	plt.xlabel('Consumption (Wh)')
	plt.gca().legend(frameon = False, numpoints = 1, scatterpoints = 1)
	plt.gca().axes.get_yaxis().set_visible(False)
	plt.savefig('1d_cons_clustering.jpg')

def cluster_consumption_date(raw_file): 
	"""
	Performs feature scaling on consumption and (numerical values of) dates, then performs 2d K-means clusterting (K = 3)
	"""
	date_nums = []
	scaled_dates = []
	scaled_cons = []
	for element in raw_file.groupby(raw_file['Date']).first().index: #dates in index of summed group are no longer datetime objects, so I use this subset of the grouped dataframe for the datetime objects
		date_nums.append(matplotlib.dates.date2num(element))
	dates_mean = np.average(date_nums)
	dates_std_dev = np.std(date_nums)
	for element in date_nums:
		scaled_dates.append((element - dates_mean) / dates_std_dev)
	grouped_by_day = raw_file.groupby(raw_file['Date']).sum() #grouped and summed by day. No longer contains time info, as grouping and summing loses non-numerical columns
	daily_cons_mean = grouped_by_day.mean()[0]
	daily_cons_std_dev = grouped_by_day.std()[0]
	for element in grouped_by_day.values:
		scaled_cons.append((element - daily_cons_mean) / daily_cons_std_dev)
	scaled_matrix = np.c_[scaled_dates, scaled_cons]
	twod_centroids, data_labels = vq.kmeans2(scaled_matrix,3) #2d clustering in date-consumption space
	twod_centroids[:,0] = twod_centroids[:,0] * dates_std_dev + dates_mean
	twod_centroids[:,1] = twod_centroids[:,1] * daily_cons_std_dev + daily_cons_mean #'unscale' cluster centroids for final graph
	max_cons_label = np.argmax(twod_centroids[:,1]) #Name labels based on consumption only
	min_cons_label = np.argmin(twod_centroids[:,1])
	low_points = []
	med_points = []
	high_points = []
	for i in range(len(data_labels)):
		if data_labels[i] == min_cons_label: low_points.append([grouped_by_day.index[i], grouped_by_day.values[i,0]])
		elif data_labels[i] == max_cons_label: high_points.append([grouped_by_day.index[i], grouped_by_day.values[i,0]])
		else: med_points.append([grouped_by_day.index[i], grouped_by_day.values[i,0]])
	plt.figure(4)
	low_plot = plt.plot([row[0] for row in low_points], [row[1] for row in low_points], 'y+', alpha = 0.8, ms = 7.5, label = 'Low Cluster Points')
	med_plot = plt.plot([row[0] for row in med_points], [row[1] for row in med_points], 'g+', alpha = 0.8, ms = 7.5, label = 'Medium Cluster Points')
	high_plot = plt.plot([row[0] for row in high_points], [row[1] for row in high_points], 'b+', alpha = 0.8, ms = 7.5, label = 'High Cluster Points')
	clusters_plot = plt.scatter(twod_centroids[:,0], twod_centroids[:,1], marker = 'x', c = 'r', s = 100, label = 'Cluster Centroids' )
	plt.title('Consumption & Date Clustering for one day intervals')
	plt.xlabel('Date')
	plt.ylabel('Consumption (Wh)')
	plt.gca().legend(frameon = False, numpoints = 1, scatterpoints = 1)
	plt.savefig('2d_date_cons_clustering.jpg')

def main():
	"""
	Opens .csv file, saves to DataFrame, adds date and time object columns to end of df. Program doesn't need to be run as images have already been created.
	"""
	inp_file = '../../data/total_watt.csv'
	names = ['Date-Time', 'Consumption']
	seps = ','
	raw_data = pd.read_csv(inp_file, sep = seps, parse_dates=[0], names = names)
	raw_data['Date'] = [x.date() for x in raw_data['Date-Time']] 
	raw_data['Time'] = [x.time() for x in raw_data['Date-Time']] 
	visualise_raw(raw_data)
	visualise_grouped(raw_data)
	visualise_raw_3d(raw_data)
	cluster_consumption(raw_data)
	cluster_consumption_date(raw_data)

if __name__ == '__main__':
	main()