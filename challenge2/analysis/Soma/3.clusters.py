import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.mixture import GMM
from sklearn.preprocessing import LabelEncoder
import matplotlib as mpl
from matplotlib import style
style.use('ggplot')

MY_FILE= 'total_watt.csv'

#read MY_FILE---------------------------------------------------------------------------------------------

df = pd.read_csv(MY_FILE, parse_dates=[0], index_col=[0])   #parse_dates decides which column to read in datetime and index_col---decide index column.
df = df.resample('1D', how='sum')
df = df.dropna()                                            #sklearn is not NaN tolerant.

#set date and consumption---------------------------------------------------------------------------------

date = df.index.tolist()                                    #tolist returns the array as a list
date = [x.strftime('%m-%d') for x in date]
le = LabelEncoder()                                         #LabelEncoder converts text data into numeric form.
date = le.fit_transform(date)
consumption = df[df.columns[0]].values

#ser X, fig and ax-----------------------------------------------------------------------------------------

X = np.array([date, consumption]).T                         #.T accesses the attribute T of the object.
fig, ax = plt.subplots(figsize=(12,8))

#to add spheres surrounding my plots-----------------------------------------------------------------------

gmm = GMM(n_components=3)
gmm.fit(X)                                                  #call 'fit'
y_pred = gmm.predict(X)
for i, color in enumerate('grb'):
    width, height = 2 * 1.96 * np.sqrt(np.diagonal(gmm._get_covars()[i]))
    ell = mpl.patches.Ellipse(gmm.means_[i], width, height, color=color)
    ell.set_alpha(0.3)
    ax.add_artist(ell)
    Xdata = X[y_pred == i]
    ax.scatter(Xdata[:,0], Xdata[:,1], color=color)
    ax.scatter(gmm.means_[i][0], gmm.means_[i][1], marker='x', s=300, c=color)


#setting title, x/y label and ticks. ----------------------------------------------------------------------------------

a = np.arange(0, len(X), 3)
ax.set_xticks(a)
ax.set_xticklabels(le.inverse_transform(a.astype(int)))     #to set the x-ticks as dates
ax.set_title('Energy consumptions Clusters (high/medium/low)')
ax.set_xlabel('date (year 2011)')
ax.set_ylabel('energy consumption')
ax.tick_params(axis='x', colors='midnightblue')
ax.tick_params(axis='y', colors='midnightblue')

#finally!
plt.show()