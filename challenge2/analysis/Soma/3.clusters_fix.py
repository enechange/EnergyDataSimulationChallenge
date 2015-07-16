import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.cluster import KMeans
from matplotlib import style
style.use('ggplot')

MY_FILE='total_watt.csv'
date = []
consumption = []

df = pd.read_csv(MY_FILE, parse_dates=[0], index_col=[0])
df = df.resample('1D', how='sum')
df = df.dropna()

date = df.index.tolist()
date = [x.strftime('%Y-%m-%d') for x in date]
from sklearn.preprocessing import LabelEncoder

encoder = LabelEncoder()
date_numeric = encoder.fit_transform(date)
consumption = df[df.columns[0]].values

X = np.array([date_numeric, consumption]).T

kmeans = KMeans(n_clusters=3)
kmeans.fit(X)

centroids = kmeans.cluster_centers_
labels = kmeans.labels_


fig, ax = plt.subplots(figsize=(12,8))



colors = ["b.","r.","g."]

for i in range(len(X)):
    ax.plot(X[i][0], X[i][1], colors[labels[i]], markersize = 10)
a = np.arange(0, len(X), 5)
ax.set_xticks(a)
ax.set_xticklabels(encoder.inverse_transform(a.astype(int)))
ax.tick_params(axis='x', colors='midnightblue')
ax.tick_params(axis='y', colors='midnightblue')
plt.scatter(centroids[:, 0],centroids[:, 1], marker = "x", s=100, c="black", linewidths = 5)
ax.set_title('Energy consumptions Clusters (high/medium/low)')
ax.set_xlabel('date (year 2011)')
ax.set_ylabel('energy consumption')

plt.show()