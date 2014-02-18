% use linear regression to predict comsumption
% Initialization
clear ; close all; clc

% get X and y from csv file
[X,y] = preProcessData('training_dataset_500_no_hdrs.csv');
m = size(X,1);

% initialize theta
initial_theta = zeros(size(X,2), 1);
% Weight regularization parameter
lambda = 0;

% train model
options = optimset('GradObj', 'on', 'MaxIter', 400);

%10-fold cross-validation
index = randperm(m);
thetasum = [];
error_train = zeros(10);
error_val = zeros(10);
fprintf("trainging model\n");
for i = 1:10    
    Xtrain = X;
    Xtrain(floor(m/10*(i-1)+1):floor(m/10*i),:) = [];
    ytrain = y;
    ytrain(floor(m/10*(i-1)+1):floor(m/10*i),:) = [];
    Xval = X(floor(m/10*(i-1)+1):floor(m/10*i),:);
    yval = y(floor(m/10*(i-1)+1):floor(m/10*i),:);
    [theta, J, exit_flag] = fminunc(@(t)(costFunction(t, Xtrain, ytrain, lambda)), initial_theta, options);
    thetasum = [thetasum theta];
end

theta = mean(thetasum,2);
fprintf("done\n");
fprintf("begin testing\n");
% testing
[Xtest,ytest] = preProcessData('test_dataset_500_no_hdrs.csv');

mtest = size(Xtest,1);
[cost2, grad2] = costFunction(theta, Xtest, ytest, lambda);
mape = sum(abs((Xtest*theta-ytest)./ytest))/mtest





