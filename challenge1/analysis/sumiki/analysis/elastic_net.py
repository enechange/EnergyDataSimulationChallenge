# Execute with PyCharm Scientific Mode
import sys
sys.path.extend(['challenge1/analysis/sumiki/analysis'])
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.svm import SVR
from sklearn.model_selection import GridSearchCV
from sklearn import preprocessing
from utilities import *

train, test = get_input_data()

x_train = train[['Month', 'Temperature', 'Daylight']]
y_train = train['EnergyProduction']
x_test = test[['Month', 'Temperature', 'Daylight']]
y_test = test['EnergyProduction']

x_train = preprocessing.normalize(x_train, norm='l2')
x_test = preprocessing.normalize(x_test, norm='l2')

#%%

'''
##With dummy months
Best parameters:
  ElasticNet(alpha=1e-05, copy_X=True, fit_intercept=True, l1_ratio=1.0,
      max_iter=1000, normalize=False, positive=False, precompute=False,
      random_state=None, selection='cyclic', tol=0.0001, warm_start=False)
Best TrainingData score:
  0.13107105416275366
TestData score:
  0.14279379648688076

##Without dummy months
Best parameters:
  ElasticNet(alpha=0.001, copy_X=True, fit_intercept=True, l1_ratio=1.0,
      max_iter=1000, normalize=False, positive=False, precompute=False,
      random_state=None, selection='cyclic', tol=0.0001, warm_start=False)
Best TrainingData score:
  0.15783931005650717
TestData score:
  0.13970042999137455
  
'''

tuned_parameters = [{'alpha': [1e-5,1e-3,.2,.5,1.0],'l1_ratio':[1e-3,.1,0.5,.8,1.0]}]
clf = GridSearchCV(ElasticNet(), tuned_parameters, cv=20, scoring=mape_score)
clf.fit(x_train, y_train)
mape_value = mape(clf, x_test, y_test)
print(mape_value)
show_best_parameter(clf, x_test, y_test)
#%%

