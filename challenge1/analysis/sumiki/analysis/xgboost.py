# Execute with PyCharm Scientific Mode
import sys
sys.path.extend(['challenge1/analysis/sumiki/analysis'])
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from xgboost import XGBRegressor
from sklearn.model_selection import GridSearchCV
from sklearn import preprocessing
from utilities import *


train, test = get_input_data()

all = pd.concat([train, test], axis=0)

all['Mon'] = (all['Month'].apply(lambda x: str(x).zfill(2)))
all = pd.concat((all, pd.get_dummies(all['Mon'], prefix='Mon_')), axis = 1)

train = pd.DataFrame(all, columns=all.columns.values, index=train.index.values )
test = pd.DataFrame(all, columns=all.columns.values, index=test.index.values )
#print(train.columns.values)
#print(test.columns.values)

filter_col = [col for col in train if col.startswith('Mon_')]
columns = ['Temperature', 'Daylight'] + (filter_col)

x_train = train[columns]
y_train = train['EnergyProduction']

x_test = test[columns]
y_test = test['EnergyProduction']

x_train = preprocessing.normalize(x_train, norm='l2')
x_test = preprocessing.normalize(x_test, norm='l2')


#%%
'''
Best parameters:
  XGBRegressor(base_score=0.5, booster='gbtree', colsample_bylevel=1,
       colsample_bytree=1.0, gamma=0, importance_type='gain',
       learning_rate=0.1, max_delta_step=0, max_depth=100,
       min_child_weight=1, missing=None, n_estimators=100, n_jobs=1,
       nthread=None, objective='reg:linear', random_state=0, reg_alpha=0,
       reg_lambda=1, scale_pos_weight=1, seed=None, silent=True,
       subsample=0.9)
Best TrainingData score:
  5.494431968166113e-05
TestData score:
  0.4110840606765431
'''
params = {'max_depth': [5, 10], 'learning_rate': [0.05, 0.1], 'max_depth': [3, 10, 100], 'subsample': [0.8, 0.9], 'colsample_bytree': [0.5, 1.0]}
mod = XGBRegressor()
cv = GridSearchCV(mod, params, cv = 3, n_jobs =1, scoring=mape_score)
cv.fit(x_train, y_train)
show_best_parameter(cv, x_test, y_test)