% use linear regression to predict comsumption
% Initialization
clear ; close all; clc

% get X and y from csv file
[X,y] = preProcessData('training_dataset_500_no_hdrs.csv',8);

k = size(X,2);
%normalization
[X(:,15:k), mu, sigma] = normalization(X(:,15:k));

m = size(X,1);
X = [ones(m,1) X];

% initialize theta
initial_theta = zeros(size(X,2), 1);
% Weight regularization parameter
lambda = 0;

fprintf('training model\n');
% train model
options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, J, exit_flag] = fminunc(@(t)(costFunction(t, X, y, lambda)), initial_theta, options);


fprintf('begin testing\n');
% testing
[Xtest,ytest] = preProcessData('test_dataset_500_no_hdrs.csv',8);

% normalization
Xtest(:,15:k) = (Xtest(:,15:k) .- mu) ./sigma;

% add constant variable 1
mtest = size(Xtest,1);
Xtest = [ones(mtest,1) Xtest];

mape = sum(abs((Xtest*theta-ytest)./ytest))/mtest





