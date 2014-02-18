% use linear regression to predict comsumption
% Initialization
clear ; close all; clc

% get X and y from csv file
[X,y] = preProcessData('training_dataset_500_no_hdrs.csv');
m = size(X,1);

%divide training set into training part and validation part
mtrain = round(0.7*m);
mVal = m - mtrain;
Xtrain = X(1:mtrain,:);
ytrain = y(1:mtrain,:);
Xval = X(mtrain+1:m,:);
yVal = y(mtrain+1:m,:);

% initialize theta
initial_theta = zeros(size(Xtrain,2), 1);
% Weight regularization parameter
lambda = 0;

% train model
options = optimset('GradObj', 'on', 'MaxIter', 400);

% draw learning Curve 
error_train = zeros(floor(mtrain/100), 1);
error_val   = zeros(floor(mtrain/100), 1);

fprintf('preparing learning curve\n');
for ii = 1:floor(mtrain/100)
    i = ii*100;
    [theta, J, exit_flag] = fminunc(@(t)(costFunction(t, Xtrain(1:i,:), ytrain(1:i,:), lambda)), initial_theta, options);
    error_train(ii) = (Xtrain(1:i,:)*theta-ytrain(1:i))'*(Xtrain(1:i,:)*theta-ytrain(1:i))/2/i;
    error_val(ii) = (Xval*theta-yVal)'*(Xval*theta-yVal)/2/mVal;
end

plot(1:floor(mtrain/100), error_train, 1:floor(mtrain/100), error_val);
fprintf('from learning curve we can we the model has a little bit high bias\n');
title(sprintf('Learning Curve'));
xlabel('Number of training examples per 100')
ylabel('Error')
axis([0 floor(mtrain/100) 0 10000])

fprintf('begin testing.\n');
% testing
[Xtest,ytest] = preProcessData('test_dataset_500_no_hdrs.csv');

mtest = size(Xtest,1);
[cost2, grad2] = costFunction(theta, Xtest, ytest, lambda);
mape = sum(abs((Xtest*theta-ytest)./ytest))/mtest





