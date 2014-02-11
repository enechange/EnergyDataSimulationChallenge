"""
EnergyDataSimulationChallenge - 2

analyse.py is to analyse total_watt.csv and produce files to be used for
d3.js visualisation library

To run:
    python analyse.py <filename>

    e.g

    python analyse.py ../../data/total_watt.csv

    filename is a comma separated file in the below format:

    2011-04-18 13:22:00,925.840613752523
    YYYY-MM-DD HH24:MI:SS, NNNN.nnnnnnnnnnnn

Output: 3 files to be used for d3.js visualisation

    watts_grouped_by_30.csv : for vis1, energy consumption per 30 minutes

    watts_grouped_by_day.csv : for vis2, daily energy consumption

    watts_cluster_areachart.csv : for vis3, clusters in an area chart

    watts_cluster_heatmap.csv : for vis4, clusters in a heatmap(if I get time!)

"""

import sys
import random
import math
from collections import defaultdict
from datetime import datetime


def dist(x, y):
    """ Returns the euclidian distance between two numbers. """
    return math.sqrt((x - y)**2)


def mean(seq):
    """ Returns mean of a sequence """
    return sum(seq)/len(seq)


def kmeans(data=[], k=3, centroids=[], iter=10000):
    """ Implementation of K-Means clustering.

        Args:
        data = a list containing data to be clustered
        k = number of clusters, default 3
        centroids = a list containing initial centroids
        iter = number of iterations, default 10000

        Output:
        A dict with centroids as keys and corresponding cluster data as values
    """
    if centroids == []:
        centroids.extend(random.sample(range(1, int(max(data)) + 2), k))

    while True:
        iter -= 1
        #print "centroids", centroids
        clusters = defaultdict(list)  # {centroid1: [cluster1 data]}
        for d in data:
            dist_small = float("inf")
            band = 10000
            for centroid in centroids:
                dist_centroid = dist(centroid, d)
                if dist_centroid < dist_small:
                    dist_small = dist_centroid
                    band = centroid
            clusters[band].append(d)

        converged = True
        new_centroids = []

        for centroid, cluster in clusters.items():
            cluster_mean = mean(cluster)
            new_centroids.append(cluster_mean)
            if abs(cluster_mean - centroid) > 0:
                converged = False
                #print ("Iteration : %s, centroid_mean_diff : %f" %
                 #      (iter, abs(cluster_mean - centroid)))

        if converged or iter == 0:
            break
        # start all over when number of clusters become < k, because
        # two clusters have same mean
        elif len(new_centroids) != k:
            centroids = random.sample(range(1, int(max(data)) + 2), k)
        else:
            centroids = new_centroids

    return clusters


def get_band(band_tuple_list, val):
    """
    band_tuple_list is a SORTED(on key=centroid) list with the tuples
    (centoid, band_floor,
    band_ceil) values
    e.g
    [(10, 5, 25), (50, 30, 100), (110, 104, 120)]
    """
    band = 0

    for i, bands in enumerate(band_tuple_list):
        centroid, band_floor, band_ceil = bands
        if val >= band_floor and val <= band_ceil:
            band = i

    return str(band)


if __name__ == '__main__':
    filename = sys.argv[1]

# total_watt.csv has only dates, readings which I checked manually.
# So not adding
# any validations e.g charset conversion, invalid values etc
# to keep this simple.

master_data = []

for line in open(filename):
    raw_fields = line.split(',')
    dt = datetime.strptime(raw_fields[0].rstrip('\r\n'), '%Y-%m-%d %H:%M:%S')
    val = float(raw_fields[1])
    master_data.append((dt, val))


master_data.sort(key=lambda x: x[0])  # sort on date

# watts_grouped_by_30.csv : output for vis1
f = open('watts_grouped_by_30.csv', 'w')
f.write('date,watts\n')

for record in master_data:
    dt, watts = record
    f.write(dt.strftime('%Y-%m-%d %H:%M:%S'))
    f.write(',')
    f.write('%0.12f' % watts)
    f.write('\n')

f.close()


# watts_grouped_by_day.csv for vis2

daydict = {}

for record in master_data:
    day = record[0].strftime('%Y-%m-%d')
    # group by day
    if day in daydict:
        daydict[day] += record[1]
    else:
        daydict[day] = record[1]

    # sort again as date and write out

    daylist = [(datetime.strptime(key, '%Y-%m-%d'), val)
               for key, val in daydict.items()]
    daylist.sort(key=lambda x: x[0])

f = open('watts_grouped_by_day.csv', 'w')
f.write('date,watts\n')


for record in daylist:
    day, watts = record
    f.write(day.strftime('%Y-%m-%d %H:%M:%S'))
    f.write(',')
    f.write('%0.12f' % watts)
    f.write('\n')

f.close()

# Cluster the data into low,medium, high

watts = [y for x, y in master_data]
clusters = kmeans(data=watts, k=3)
# bands = [(centroid, band_floor, band_ceil)]
bands = [(key, min(val), max(val)) for key, val in clusters.items()]
bands.sort(key=lambda x: x[0])
print bands

# to sum up low, medium, high value groups for each day
daydict = {'0': {}, '1': {}, '2': {}}

# initialise everything to 0.0 as you need bands with no data to appear in
# output file with values=0
for record in master_data:
    day = record[0].strftime('%Y-%m-%d')
    daydict['0'][day] = 0.0
    daydict['1'][day] = 0.0
    daydict['2'][day] = 0.0

for record in master_data:
    day = record[0].strftime('%Y-%m-%d')
    watts = record[1]
    band = get_band(bands, watts)

    if day in daydict[band]:
        daydict[band][day] += watts
    else:
        daydict[band][day] = watts

# sort on band, day
daylist = [(band, watts, datetime.strptime(day, '%Y-%m-%d'))
           for band, dayval_dict in daydict.items()
           for day, watts in dayval_dict.items()]

daylist.sort(key=lambda x: (x[2], x[0]))

f = open('watts_cluster_areachart.csv', 'w')
f.write('key,value,date\n')

for record in daylist:
    band, watts, day = record
    f.write(band)
    f.write(',')
    f.write('%0.12f' % watts)
    f.write(',')
    f.write(day.strftime('%m/%d/%y'))
    f.write('\n')

f.close()
