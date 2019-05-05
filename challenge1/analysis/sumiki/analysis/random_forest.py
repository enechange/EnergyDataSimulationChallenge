# Execute with PyCharm Scientific Mode
import sys
sys.path.extend(['challenge1/analysis/sumiki/analysis'])
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.ensemble import RandomForestRegressor
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
RandomForestRegressor
0.39269714186094506
'''

rfr = RandomForestRegressor()
rfr.fit(x_train, y_train)
mape_value = mape(rfr, x_test, y_test)
print(mape_value)


#%%
'''
Best parameters:
  RandomForestRegressor(bootstrap=True, criterion='mse', max_depth=100,
           max_features=3, max_leaf_nodes=None, min_impurity_decrease=0.0,
           min_impurity_split=None, min_samples_leaf=3,
           min_samples_split=8, min_weight_fraction_leaf=0.0,
           n_estimators=500, n_jobs=None, oob_score=False,
           random_state=None, verbose=0, warm_start=False)
Best TrainingData score:
  0.0028554884733438257
TestData score:
  0.3907009440433749
'''
param_grid = {
    'bootstrap': [True],
    'max_depth': [80, 100],
    'max_features': [2, 3],
    'min_samples_leaf': [3, 5],
    'min_samples_split': [8, 12],
    'n_estimators': [100, 500, 1000]
}
rf = RandomForestRegressor()
grid_search = GridSearchCV(estimator = rf, param_grid = param_grid,
                          cv = 3, n_jobs = -1, verbose = 2, scoring=mape_score)
grid_search.fit(x_train, y_train)
show_best_parameter(grid_search, x_test, y_test)