
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d



MY_FILE = 'total_watt.csv'

df = pd.read_csv(MY_FILE, parse_dates=[0], header=None, names=['datetime', 'consumption'])

df['date'] = [x.date() for x in df['datetime']]
df['time'] = [x.time() for x in df['datetime']]

pv = df.pivot(index='time', columns='date', values='consumption')

# to avoid holes in the surface
pv = pv.fillna(0.0)

xx, yy = np.mgrid[0:len(pv),0:len(pv.columns)]

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

surf=ax.plot_surface(xx, yy, pv.values, cmap='jet', cstride=1, rstride=1)

fig.colorbar(surf, shrink=0.5, aspect=10)

dates = [x.strftime('%m-%d') for x in pv.columns]
times = [x.strftime('%H:%M') for x in pv.index]

ax.set_title('Energy consumptions Clusters', color='lightseagreen')
ax.set_xlabel('time', color='darkturquoise')
ax.set_ylabel('date(year 2011)', color='darkturquoise')
ax.set_zlabel('energy consumption', color='darkturquoise')
ax.set_xticks(xx[::10,0])
ax.set_xticklabels(times[::10], color='lightseagreen')
ax.set_yticks(yy[0,::10])
ax.set_yticklabels(dates[::10], color='lightseagreen')

ax.set_axis_bgcolor('black')

plt.show()


#Thanks for reading! Looking forward to the Skype Interview.