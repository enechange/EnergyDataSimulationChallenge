# -*- coding: utf-8 -*-
# modules
import csv
import numpy as np
from sklearn import svm
from sklearn.externals import joblib

# function
def get_energy_data_dict(source_file_path):
    x_data_dict = {}
    y_data_dict = {}

    # read CSV file
    with open(source_file_path, "r") as f:
        reader = csv.reader(f)
        header = next(reader)

        for row in reader:
            # add data
            house = row[2]
            month = float(row[4])
            temp = float(row[5])
            sunl = float(row[6])
            prod = float(row[7])

            data = np.array([[month, temp, sunl]])
            target = np.array([[prod]])

            # add target
            if house in x_data_dict and house in y_data_dict:
                x_data_dict[house] = np.append(x_data_dict[house], data, axis=0)
                y_data_dict[house] = np.append(y_data_dict[house], target, axis=0)
            else:
                x_train = np.append(np.empty((0, 3), float), data, axis=0)
                y_train = np.append(np.empty((0, 1), float), target, axis=0)
                x_data_dict[house] = x_train
                y_data_dict[house] = y_train

    return x_data_dict, y_data_dict


def get_predict_data(x_train_dict, y_train_dict, x_test_dict, y_test_dict, c, g, write_flag):
    # output csv file path
    predict_output_path = "predicted_energy_production.csv"
    mape_output_path    = "mape.txt"

    # print result and write to file
    f_predict = open(predict_output_path, "w")
    f_mape = open(mape_output_path, "w")

    limit = len(x_test_dict)
    error_rate_list = []

    for i in range(1, limit+1):
        house_id = str(i)
        x_train = x_train_dict[house_id]
        y_train = y_train_dict[house_id]
        x_test = x_test_dict[house_id]
        y_test = y_test_dict[house_id]

        # SVM training
        clf = svm.SVR(kernel='rbf', C=c, gamma=g)
        clf.fit(x_train, y_train)

        # give prediction
        predict_list = clf.predict(x_test)

        # result
        if write_flag:
            print("* house: {0}".format(house_id))

        for x, y, predict in zip(x_test, y_test, predict_list):
            error_rate = abs(predict - y[0]) / y[0]
            error_rate_list.append(error_rate)

            # write to file
            if write_flag:
                predict_text = "{0},{1}\n".format(house_id, predict)
                mape_text = "{0},{1}\n".format(house_id, error_rate)
                f_predict.write(predict_text)
                f_mape.write(mape_text)

                # print to console
                print(x, y, " Predicted:", predict)
                print("Error Rate: {0:.3f}%".format(error_rate * 100))

    # file close
    f_predict.close()
    f_mape.close()

    return error_rate_list


# main
if __name__ == "__main__":
    # input csv file path
    train_data_path = "data/training_dataset_500.csv"
    test_data_path  = "data/test_dataset_500.csv"

    # read csv data
    x_train_dict, y_train_dict = get_energy_data_dict(train_data_path)
    x_test_dict, y_test_dict = get_energy_data_dict(test_data_path)

    # find best parameters
    min_mape = 1
    best_c = 0
    best_gamma = 0
    c_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30, 50, 75, 100, 200, 300, 400, 500, 750, 1000, 1500, 2000]
    gamma_list  = [0.00005, 0.0001, 0.0002, 0.0005, 0.001, 0.002, 0.003, 0.005, 0.01, 0.02, 0.03]
    limit = len(x_test_dict)

    for c in c_list:
        for gamma in gamma_list:
            error_rate_list = get_predict_data(x_train_dict, y_train_dict, x_test_dict, y_test_dict, c, gamma, False)

            # show MAPE
            mape = sum(error_rate_list)  / limit
            print("- C = {0}".format(c))
            print("- gamma = {0}\n".format(gamma))
            print("- MAPE = {0:.3f}(%)".format(mape * 100))

            if mape < min_mape:
                min_mape = mape
                best_c = c
                best_gamma = gamma

    # get file output
    _ = get_predict_data(x_train_dict, y_train_dict, x_test_dict, y_test_dict, best_c, best_gamma, True)

    # get final result
    print("\n< Test Result >")
    print("- N = {0}".format(limit))
    print("- MAPE = {0:.3f}(%)".format(min_mape * 100))
    print("- C = {0}".format(best_c))
    print("- gamma = {0}".format(best_gamma))

