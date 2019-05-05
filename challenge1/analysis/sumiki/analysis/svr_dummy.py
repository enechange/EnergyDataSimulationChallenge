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
SVR Linear
0.14696493762126214
'''

sv_regressor = SVR(kernel='linear')
sv_regressor.fit(x_train, y_train)
mape_value = mape(sv_regressor, x_test, y_test)
print(mape_value)

#%%
'''
SVR RBF
0.14455699858118656
'''
sv_regressor = SVR(kernel='rbf')
sv_regressor.fit(x_train, y_train)
mape_value = mape(sv_regressor, x_test, y_test)
print(mape_value)

#%%
'''
Best parameters:
  SVR(C=100, cache_size=200, coef0=0.0, degree=3, epsilon=0.1, gamma=100,
  kernel='rbf', max_iter=-1, shrinking=True, tol=0.001, verbose=False)
Best TrainingData score:
  0.13919744135903045
TestData score:
  0.13391567218260647
'''
tuned_parameters = [{'kernel': ['rbf', 'linear'],'C':[1e-5,1,10,100],'gamma':[1e-5,1,10,100]}]
clf = GridSearchCV(SVR(), tuned_parameters, cv=3, scoring=mape_score)
clf.fit(x_train,y_train)
show_best_parameter(clf, x_test, y_test)

#%%

sv_regressor = SVR(C=100, cache_size=200, coef0=0.0, degree=3, epsilon=0.1, gamma=100,
                    kernel='rbf', max_iter=-1, shrinking=True, tol=0.001, verbose=False)

sv_regressor.fit(x_train, y_train)
mape_value = mape(sv_regressor, x_test, y_test)
print(mape_value)
