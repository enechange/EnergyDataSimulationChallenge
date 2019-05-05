# Execute with PyCharm Scientific Mode
import sys
sys.path.extend(['challenge1/analysis/sumiki/analysis'])
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.svm import SVR
from sklearn.model_selection import GridSearchCV
from utilities import *
import matplotlib.pyplot as plt

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

#print(x_train)
#print(x_test)

#%%
sv_regressor = SVR(C=100, cache_size=200, coef0=0.0, degree=3, epsilon=0.1, gamma=100,
                    kernel='rbf', max_iter=-1, shrinking=True, tol=0.001, verbose=False)

sv_regressor.fit(x_train, y_train)
mape_value = mape(sv_regressor, x_test, y_test)
print(mape_value)

#%%
test_input = pd.read_csv("challenge1/data/test_dataset_500.csv")
predictions = sv_regressor.predict(x_test)
predictions = pd.DataFrame( dict( EnergyProduction=predictions ) )
predictions = pd.concat((test_input.iloc[:, 0], predictions), axis = 1)
predictions.to_csv('challenge1/analysis/sumiki/predicted_energy_production.csv', sep=",", index = False)

# writing the mape value
with open('challenge1/analysis/sumiki/mape.txt','w') as outfile:
    outfile.write('MAPE: %f\n'%mape_value)

#%%
# Ploting the result
compare_df = pd.DataFrame( dict( ID=test_input.iloc[:, 0],
                          EnergyTrue=test_input.iloc[:,-1],
                          EnergyProduction=predictions['EnergyProduction'] ) )\
            .sort_values(by='EnergyTrue').reset_index(drop=True)


ax = compare_df.reset_index().plot.scatter(
    y=['EnergyTrue'],
    x='index',
    label='EnergyTrue',
    color='DarkBlue'
)
compare_df.reset_index().plot.scatter(
    y=['EnergyProduction'],
    x='index',
    label='EnergyProduction',
    color='DarkGreen',
    ax=ax,
)
plt.show()


