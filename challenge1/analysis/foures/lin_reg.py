import numpy as np
import matplotlib.pyplot as plt
from sklearn import linear_model


def compute_mape(Y_model,Y_truth):
    mape = 100*float(1)/nhouse * np.sum(np.abs((Y_model-Y_truth)/Y_truth))
    print('Mape is: %f%%.' % mape)
    return 0     

filename = '../../data/dataset_500.csv'

data = np.genfromtxt(filename, delimiter = ',', names = True, dtype= None)
print(data.dtype)

label = list(data['Label'])
set_label = list(set(label))
nlabel = len(set_label)
house = list(data['House'])
set_house = list(set(house))
nhouse = len(set_house)
year = list(data['Year'])
month = list(data['Month'])
temp = list(data['Temperature'])
temp2 = [temp_val**2 for temp_val in temp]
light = list(data['Daylight'])
light2 = [light_val**2 for light_val in light]
ener = list(data['EnergyProduction'])

# Prediction label
label_predict = 23

# Define training data-set
for label_start in range(10):                  # Starting label
    label_train = label_predict - 12 # Find previous similar month
    
    # Light + temp
    X_train = [light[nlabel*(house_i-1)+label_start:nlabel*(house_i-1)+label_train] + temp[nlabel*(house_i-1)+label_start:nlabel*(house_i-1)+label_train] for house_i in set_house]
    # Light only
    X_train = [light[nlabel*(house_i-1)+label_start:nlabel*(house_i-1)+label_train] for house_i in set_house]
    Y_train = [light[nlabel*(house_i-1)+label_train] for house_i in set_house]
    
    # Train
    clf = linear_model.LinearRegression()
    clf.fit(X_train,Y_train)
    
    # Check accuracy of the model
    Y_model_train = clf.predict(X_train)
    compute_mape(Y_model_train,Y_train)
    
    # Define test data-set
    label_test = label_predict - label_train  # Find starting month for test
    
    # Light + temp
    X_test = [light[nlabel*(house_i-1)+label_test+label_start:nlabel*(house_i-1)+label_predict] + temp[nlabel*(house_i-1)+label_test+label_start:nlabel*(house_i-1)+label_predict]  for house_i in set_house]
    # Light only
    X_test = [light[nlabel*(house_i-1)+label_test+label_start:nlabel*(house_i-1)+label_predict]  for house_i in set_house]
    Y_test = [light[nlabel*(house_i-1)+label_predict] for house_i in set_house]
    
    # Predict
    Y_model_test = clf.predict(X_test)  
    
    # Check accuracy
    compute_mape(Y_model_test,Y_test)    
    
#     for house_i in set_house:
#         plt.subplot(2,4,1)
#         plt.plot(month[nlabel*(house_i-1)+label_start:nlabel*(house_i-1)+label_train+1])
#         plt.subplot(2,4,2)
#         plt.plot(temp[nlabel*(house_i-1)+label_start:nlabel*(house_i-1)+label_train+1])
#         plt.subplot(2,4,3)
#         plt.plot(light[nlabel*(house_i-1)+label_start:nlabel*(house_i-1)+label_train+1])
#         plt.subplot(2,4,4)
#         plt.plot(ener[nlabel*(house_i-1)+label_start:nlabel*(house_i-1)+label_train+1])
#         plt.plot(label_test-1-label_start,Y_model_train[house_i-1],'.')
#         
#         plt.subplot(2,4,5)
#         plt.plot(month[nlabel*(house_i-1)+label_test+label_start:nlabel*(house_i-1)+label_predict+1])
#         plt.subplot(2,4,6)
#         plt.plot(temp[nlabel*(house_i-1)+label_test+label_start:nlabel*(house_i-1)+label_predict+1])
#         plt.subplot(2,4,7)
#         plt.plot(light[nlabel*(house_i-1)+label_test+label_start:nlabel*(house_i-1)+label_predict+1])
#         plt.subplot(2,4,8)
#         plt.plot(ener[nlabel*(house_i-1)+label_test+label_start:nlabel*(house_i-1)+label_predict+1])
#         plt.plot(label_test-1-label_start,Y_model_test[house_i-1],'.')
    
    
#     plt.show()
    
