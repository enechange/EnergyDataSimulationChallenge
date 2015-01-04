# -*- coding: utf-8 -*-
#!/usr/local/bin/python

import time
import pandas as pd

import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties

import argparse
import math

import numpy as np

def add_vis_target(c):
    v = M[c] - M[bi[0]]
    x1 = v.dot(e1)
    x2 = v.dot(e2)
    x1, x2 = x1 - tw * x2, x2 - tw * x1
    if -n1 < x1 < 2 * n1 and -n2 < x2 < 2 * n2:
        vis_target.append((x1, x2, vocab[c]))


start = time.time()

parser = argparse.ArgumentParser()
parser.add_argument('--vis', action='store_true', help='visualize')
args = parser.parse_args()

myDataFrame = pd.read_csv('../../data/total_watt.csv',
    parse_dates=['Timestamp'],
    names=['Timestamp','Energy'],
    header=0,
    index_col='Timestamp')

print myDataFrame.head()

if args.vis:
    d1 = M[bi[1]] - M[bi[0]]
    d2 = M[bi[2]] - M[bi[0]]
    n1 = np.linalg.norm(d1, 2)
    n2 = np.linalg.norm(d2, 2)
    e1 = normalize(d1)
    e2 = normalize(d2)
    tw = e1.dot(e2)
    vis_target = []
"""
histogram
"""
# スタージェスの公式 k = log2(n) + 1
k = math.ceil(math.log(len(myDataFrame['Energy']), 2) + 1) # 天井関数(ceiling)
# スコットの選択
k = 3.5 * np.std(myDataFrame['Energy']) / (len(myDataFrame['Energy']) ** (1.0 / 3.0))
# 平方根選択
# k = len(myDataFrame['Energy']) ** (1.0 / 2.0)

print k

plt.hist(myDataFrame['Energy'], bins=k, alpha=0.3, color='y')

fp = FontProperties(fname='font.otf')

plt.xlabel(u'Energy Consumption(Wat)', fontproperties=fp)
plt.ylabel(u'エネルギー消費回数', fontproperties=fp)

###

from matplotlib.ticker import FormatStrFormatter

fig, ax = plt.subplots()
counts, bins, patches = ax.hist(myDataFrame['Energy'], #map(math.ceil, myDataFrame['Energy']),
    facecolor='yellow',
    edgecolor='gray',
    bins=k)

plt.xlabel(u'Energy Consumption(Wat)', fontproperties=fp)
plt.ylabel(u'エネルギー消費回数', fontproperties=fp)


# Set the ticks to be at the edges of the bins.
# ax.set_xticks(bins)
# Set the xaxis's tick labels to be formatted with 1 decimal place...
# ax.xaxis.set_major_formatter(FormatStrFormatter('%0.1f'))

# Change the colors of bars at the edges...
twentyfifth, seventyfifth = np.percentile(myDataFrame['Energy'], [25, 75])
for patch, rightside, leftside in zip(patches, bins[1:], bins[:-1]):
    if rightside < twentyfifth:
        patch.set_facecolor('green')
    elif leftside > seventyfifth:
        patch.set_facecolor('red')
"""
# Label the raw counts and the percentages below the x-axis...
bin_centers = 0.5 * np.diff(bins) + bins[:-1]
for count, x in zip(counts, bin_centers):
    # Label the raw counts
    ax.annotate(str(count), xy=(x, 0), xycoords=('data', 'axes fraction'),
        xytext=(0, -18), textcoords='offset points', va='top', ha='center')

    # Label the percentages
    percent = '%0.0f%%' % (100 * float(count) / counts.sum())
    ax.annotate(percent, xy=(x, 0), xycoords=('data', 'axes fraction'),
        xytext=(0, -32), textcoords='offset points', va='top', ha='center')

"""
plt.subplots_adjust(bottom=0.15)
plt.show()

"""
折れ線グラフ
"""
f = plt.figure(figsize=(16, 6))

myDataFrame.plot(ax=f.gca())

fp = FontProperties(fname='font.otf')

plt.xlabel(u'Time', fontproperties=fp)
plt.ylabel(u'The Consumption of Electricity(W)', fontproperties=fp)
plt.title(u'The Consumption of Electricity per 30 mins', fontproperties=fp)
plt.show()

if args.vis:

    for a in xrange(N):
        d, w, b = ranking[a]
        add_vis_target(b)

    xs, ys, ws = zip(*vis_target)
    ax = plt.figure().add_subplot(111)
    ax.scatter(xs, ys, marker='o')
    ax.set_xlabel("'%s' - '%s'" % (st[1], st[0]), fontdict={'fontproperties':fp})
    ax.set_ylabel("'%s' - '%s'" % (st[2], st[0]), fontdict={'fontproperties':fp})

    x1 = vec.dot(e1)
    x2 = vec.dot(e2)
    x1, x2 = x1 - tw * x2, x2 - tw * x1
    ax.scatter([x1], [x2], marker='o', facecolor='red')

    for x, y, w in vis_target:
        w = unicode(w, 'utf-8')
        plt.annotate(
            w, xy = (x, y),fontproperties=fp)

    plt.savefig(st[0].encode('utf_8') + '_' + st[1].encode('utf_8') + '_'+ st[2].encode('utf_8') + '_vis.png')

"""
差分を折れ線グラフで描画
"""

def sub_energy(postEnergy, preEnergy):
    return postEnergy - preEnergy

# myDataframe['difference(1-order)'] = map(sub_energy, myDataframe['Energy'][1:], myDataframe['Energy'][:-2]) #+= 200.0
myDataFrame['Substraction'][1:] = map(sub_energy, myDataFrame['Energy'][1:-1], myDataFrame['Energy'][0:-2])

f = plt.figure(figsize=(16, 6))

myDataFrame.plot(ax=f.gca())


plt.xlabel(u'Time', fontproperties=fp)
plt.ylabel(u'The Consumption of Electricity - One-order Pre Consumption of Electricity(W)', fontproperties=fp)
plt.title(u'The Substraction of Consumption of Electricity per 30 mins', fontproperties=fp)
plt.show()

lowDataFrame = (lambda x: x < 500.0, myDataFrame['Substraction'][1:])
mediumDataFrame = filter(lambda x: x > 500.0 and x < 1000.0, myDataFrame['Substraction'][1:])
highDataFrame = filter(lambda x: x > 1000.0 , myDataFrame['Substraction'][1:])

end = time.time()
print '[info] TIME: ' + str(end - start) + ' seconds\n'


