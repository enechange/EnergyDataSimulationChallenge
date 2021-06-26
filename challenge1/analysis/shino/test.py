import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

train_df = pd.read_csv('../../data/training_dataset_500.csv')
test_df = pd.read_csv('../../data/test_dataset_500.csv')

from sklearn.ensemble import RandomForestClassifier

model = RandomForestClassifier(max_depth=1000)

X = train_df.drop(['ID', 'Label', 'Year'], axis=1)
test_X = test_df.drop(['ID', 'Label', 'Year'], axis=1)
Y = train_df[['EnergyProduction']].values
test_Y = test_df[['EnergyProduction']].values

model.fit(X,Y)
predicted = model.predict(test_X)
model.score(test_X, test_Y)

plt.scatter(test_X[['House']].values, predicted, color='red')
plt.scatter(test_X[['House']].values, test_Y, color='blue')

X_hdm = train_df.drop(['ID', 'Label', 'Year', 'Temperature'], axis=1)
test_X_hdm = test_df.drop(['ID', 'Label', 'Year', 'Temperature'], axis=1)

model_hdm = RandomForestClassifier(max_depth=1000)
model_hdm.fit(X_hdm,Y)
predicted_hdm = model_hdm.predict(test_X_hdm)

plt.scatter(test_X_hdm[['House']].values, predicted, color='red')
plt.scatter(test_X_hdm[['House']].values, test_Y, color='blue')

model_hdm.score(test_X_hdm, test_Y)