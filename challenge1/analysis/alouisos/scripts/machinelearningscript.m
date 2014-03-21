% ======================  Mupliple Prediction Methods for fitting data in Octave Code ======================
%  
%  This an optimized (vectorized) code for octave for creating machine learning models to predict values of interest
%
%  In this version (0.1 beta) no data cleaning is supported so please check your data before you 
%  use them (garbage in = garbage out) and before invoking the script go to the directory that you have your data.
%
%  Soon more functions to be implemented. For now enjoy the choices of multivariate linear regression through normal equation and gradient descent 
%  MAPE is calculated after every parameters fitting to see the value of your model 

% ---------------------- Main COde  ----------------------

%% Initialize

%% Clean and clear your environment 

clear ; close all; clc

% Loading your training data set -- Works with CSV files -- If you file is txt just use load data 
% Make sure you data are on path, otherwise use the command addpath("path_to_your_file")

% Asking some preparatory questions to help you preload and prepare your design matrix 

name = input ("Enter the name of your file. \n warning: no spaces after the filename: ", "s");  % enter the name of your file without any spaces at the end
first_column = input("Enter the first column in your training data: ");
last_column = input("Enter the last column in your training data i.e. the predicted values: "); 
not_include = input("Enter the number of lines from the beginning you want to omit: ");
separator = input("Enter the type of separator you have between your data: ", "s");

data = dlmread(name, separator, not_include, 0); 

data = data(:, first_column:last_column); 



% Preparing your data for curve fitting i.e. preparing the design matrix 

X = data(:, 1:size(data,2)-1); % this is the design matrix 
y = data(:, size(data,2));  % these are the values which we need to predict 



% Let's decide now which method to use..... 

method = menu("Choose between curve fitting methods", "Linear Regression with Normal Equation", "Linear Regression with Gradient Descent", "Polynomial Regression with Normal Equation", "Polynomial Equation with Gradient Descent");

if method == 1,
	%===================CALCULATING LINEAR REGRESSION PARAMETERS THROUGH NORMAL EQUATION=======================
	theta = normalEqn(X, y);


% ========================Calculating MAPE =================================================
test_data = dlmread("test_dataset_500.csv", ",", 1, 0); 
test_data = test_data(:, first_column:last_column); 
inputs = [ones(length(test_data),1) test_data(:, 1:(last_column-first_column))];
y = test_data(:, size(test_data, 2)); 
predicted_values = zeros(size(inputs,1), size(inputs,2)); 
comparison_matrix = zeros(size(inputs,1), size(inputs,2)); 
predicted_values = inputs*theta; 
comparison_matrix = [predicted_values y]; 
mape = 100* sum(abs((inputs*theta-y)./y))/size(inputs,1)


elseif method == 2, 
%=====================CALCULATING LINEAR REGRESSION PARAMETERS THROUGH GRADIENT DESCENT====================
	[X, X_old] = featureNormalize(X);
	gradientDescent; 
% ========================Calculating MAPE =================================================
test_data = dlmread("test_dataset_500.csv", ",", 1, 0); 
test_data = test_data(:, first_column:last_column); 
inputs = studentize(test_data(:, 1:size(test_data, 2)-1)); 
inputs = [ones(length(inputs),1) inputs];
y = test_data(:, size(test_data, 2)); 
predicted_values = inputs*theta; 
comparison_matrix = [predicted_values y];
mape = 100* sum(abs((inputs*theta-y)./y))/size(inputs,1)

elseif method == 3 
%  =========================Polynomial Regression Normal Equation==============================
for i = 1:(last_column-first_column), 
	X(:,i)= X(:,i).^i; 	
	i = i + 1; 
end; 
	theta = normalEqn(X, y)
% ========================Calculating MAPE =================================================

test_data = dlmread("test_dataset_500.csv", ",", 1, 0); 
test_data = test_data(:, first_column:last_column); 
for i = 1:(last_column-first_column), 
	test_data(:,i) = test_data(:,i).^i;	
	i = i + 1; 
end;  
inputs = [ones(length(test_data),1) test_data(:, 1:(last_column-first_column))];
y = test_data(:, size(test_data, 2)); 
predicted_values = zeros(size(inputs,1), size(inputs,2)); 
comparison_matrix = zeros(size(inputs,1), size(inputs,2)); 
predicted_values = inputs*theta; 
comparison_matrix = [predicted_values y];
mape = 100* sum(abs((inputs*theta-y)./y))/size(inputs,1)


elseif method == 4, 

%  =========================Polynomial Regression with Gradient Descent==============================
for i = 1:(last_column-first_column), 
	X(:,i)= X(:,i).^i; 	
	i = i + 1; 
end; 
%=============CALCULATING POLYNOMIAL REGRESSION PARAMETERS THROUGH GRADIENT DESCENT====================
	[X, X_old] = featureNormalize(X);
	gradientDescent; 
% ========================Calculating MAPE =================================================

test_data = dlmread("test_dataset_500.csv", ",", 1, 0); 
test_data = test_data(:, first_column:last_column); 
for i = 1:(last_column-first_column), 
	test_data(:,i) = test_data(:,i).^i;	
	i = i + 1; 
end; 
inputs = studentize(test_data(:, 1:size(test_data, 2)-1)); 
inputs = [ones(length(inputs),1) inputs];
y = test_data(:, size(test_data, 2)); 
predicted_values = inputs*theta; 
comparison_matrix = [predicted_values y];
mape = 100* sum(abs((inputs*theta-y)./y))/size(inputs,1)


 


% Cleaning the workspace again 
clear first_column; clear last_column; clear name; clear not_include; clear separator; 

end; 
