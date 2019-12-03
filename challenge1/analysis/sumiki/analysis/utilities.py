import pandas as pd
import numpy as np
from sklearn import preprocessing

def get_input_data():
    train = pd.read_csv("challenge1/data/training_dataset_500.csv", index_col=0)
    test = pd.read_csv("challenge1/data/test_dataset_500.csv", index_col=0)
    '''
    train.info()
    ID                  11500 non-null int64
    Label               11500 non-null int64
    House               11500 non-null int64
    Year                11500 non-null int64
    Month               11500 non-null int64
    Temperature         11500 non-null float64
    Daylight            11500 non-null float64
    EnergyProduction    11500 non-null int64
    dtypes: float64(2), int64(6)
    '''
    print(train.shape)
    print(test.shape)
    return train, test

def mape(regressor, x, y_true):
    y_pred = regressor.predict(x)
    return abs(np.mean(abs((y_true - y_pred) / y_true)))

def mape_score(regressor, x, y_true):
    return -mape(regressor, x, y_true)

def show_best_parameter(clf, test_x, test_y):
    print("Best parameters:")
    print(' ',clf.best_estimator_)
    print("Best TrainingData score:")
    print(' ', -clf.best_score_ )
    print("TestData score:")
    print(' ', mape(clf.best_estimator_, test_x, test_y))

'''
Make sure how mape works

# np.mean(abs((y_true - y_pred) / y_true))
a = np.array([1,2,3])
b = np.array([1.1,2.1,3.1])
print(np.mean((a - b) / a))

# -0.061111111111111165

a = np.array([1,2,3])
b = np.array([0.9,1.9,2.9])
print(np.mean((a - b) / a))

# 0.06111111111111112

a = np.array([1,2,3])
b = np.array([2,4,6])
print(np.mean((a - b) / a))

# 1

a = np.array([1,2,3])
b = np.array([0.5,1,3])
print(np.mean((a - b) / a))

# 0.3333333333333333
'''