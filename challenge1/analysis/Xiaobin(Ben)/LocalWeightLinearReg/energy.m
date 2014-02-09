% use linear regression to predict comsumption
% Initialization
clear ; close all; clc

% get X and y from csv file
[X,y] = preProcessData('training_dataset_500_no_hdrs.csv');
[m,k] = size(X);

% normalization, except for the first given x1 1
[X(:,2:k), mu, sigma] = normalization(X(:,2:k));

% initialize theta
initial_theta = zeros(k, 1);

% Weight regularization parameter
lambda = 0;
% the rate of the weight changing in cost function
tspeed = 0.00001;

% get testing data
[Xtest,ytest] = preProcessData('test_dataset_500_no_hdrs.csv');
mtest = size(Xtest,1);
% mtest = 20;
% train model
options = optimset('GradObj', 'on', 'MaxIter', 50);

error = 0;
for i=1:mtest
    xpredict = Xtest(i,:);
    xpredict(2:k) = [(xpredict(2:k)-mu)./sigma];
    [theta, J, exit_flag] = fminunc(@(t)(costFunction(t, X, y, lambda,xpredict,tspeed)), initial_theta, options);
    abs((xpredict*theta-ytest(i))/ytest(i))
    error += abs((xpredict*theta-ytest(i))/ytest(i));
    i
end

error = error/mtest








