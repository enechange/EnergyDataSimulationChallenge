%==================================================
%Energy Data Simulation Challenge
%Challenge 1 Main Script
%Guanqun Wang
%2014/7/9
%e-mail: gemini910621@gmail.com
%==================================================

clc
clear all
%==================================================
%Read data from csv files
%==================================================
fid=fopen('test_dataset_500.csv');
temp=textscan(fid,'%f%f%f%f%f%f%f%f','Delimiter',',','HeaderLines',1);
fclose(fid);
test_data=cell2mat(temp);%raw data for testing

fid=fopen('training_dataset_500.csv');
temp=textscan(fid,'%f%f%f%f%f%f%f%f','Delimiter',',','HeaderLines',1);
fclose(fid);
training_data=cell2mat(temp);%raw data for training

%Get rid of ID and Label, which is not useful for the prediction
test_set=test_data(:,3:8);
training_set=training_data(:,3:8);

%===============================================================
%Feature scaling
% Unit length scaling is used here. I think it's the simplest scaling
% method for all positive features in this case. more complex method can
% be chosen if we don't get a good convergence later
%===============================================================
% the scales are decided based on the training set only
[n_row,n_col]=size(training_set);
for i=1:n_col
    scale=max(training_set(:,i));
    training_set(:,i)=training_set(:,i)/scale;
    test_set(:,i)=test_set(:,i)/scale;
end

%===============================================================
%Randomly break the training set into a new training set and a
% cross validation set
%===============================================================
[n_row,n_col]=size(training_set);
training_set=training_set(randperm(n_row),:);%shuffle entries in training set
n_cv=round(n_row*0.2);% take 20% training data for cross validation
cv_set=training_set(1:n_cv,:);% cross validation set
training_set=training_set(n_cv+1:n_row,:);% the rest data will be new training set

%================================================================
%Polynomial Regression (Gradient Descent)
% 
% Some explainations for algorithm choices:
% 
% Regression:
% Among all the supervised machines learning algorithms I know, regression
% should those which are most efficient for such prediction problems. They
% take relatively little time to develop and usually have good performance
% when solving problems similar to this challenge.
%
% Polynomial Regression:
% If I'm working on a real project, I may start with linear regression
% since it takes very little time to build. If it satisfies the 
% requirements we don't need to spend more time for other algorithms
% and if it doesn't, we may build more complex algorithm build on it.
% The results of linear regression will also help us have a general
% better feeling of the data and an expectation of bias/variance problems.
% 
% For this challenge, I will skip the linear regression and go directly
% to polynomial regression. If the goal is always to make the accuracy as
% high as possible, polynomial regression should always be a better choice
% since no system in our world is really linear.
%
% Gradient Descent:
% The size of dataset in this challenge still seems acceptable for a normal 
% equation method, but in real project about household energy consumption,
% the dataset size should be much larger and the normal equation method
% with a complexity near O(n^3) won't be practical anymore. To make this
% script more flexible for large dataset size, I choose the gradient decent
% method.
%
% Cost Function:
% Mean square error is used at first since it works for most of
% generalization problem and is the one I most familiar with. If we meet
% problems later, we can think about a new cost function after that.
%
% Learning Rate(u) Tuning
% The learning curve for each learning rate value (0.001, 0.003, 0.01,
% 0.03,0.1,0.3,1) is plotted as shown in 'UTuning.jpg'. Obviously, we can
% get best convergence with u=0.1.
%
% Regularization Parameter(lambda) Tuning
% The cross validation set error is compared with training set error for
% each lambda value(0.01,0.02,0.04,0.08,0.16,0.32,0.64,1.28,2.56,5.12,10.24
% ). The result is shown in 'LambdaTuning.jpg' and it turned out the value
% of lambda doesn't affect the overall performance very much.
%
% Choice of Polynomial Model
% The tuning method should be the same as what I did for the lambda.In this
% case, I tried a cubic function model at first. Since there isn't any
% very obvious bias/variance problem, I didn't try other polynomial
% functions. 
%================================================================

%================================================================
%Setup for Gradient Descent method
%================================================================
[n_row,n_col]=size(training_set);
m=n_row;% # of training data entries
n=n_col-1;% # of features

[n_row,n_col]=size(cv_set);
m_cv=n_row;% # of cross validation data entries

theta_1=zeros(1,n+1);% coef for 1st order terms
theta_2=zeros(1,n);% coef for higher order terms
theta_3=zeros(1,n);% coef for 3rd order terms

u=0.1;% learning rate
lambda=0.08;% Regularization parameter

counter=0; %counter of the interation
n_iteration=220;% maximum number of iterations

%================================================================
%Iteration part (with regularization)
%================================================================
while counter<n_iteration
counter=counter+1;

%Prediction based on features in training set
y_pre=prediction(m,n,training_set,theta_1,theta_2,theta_3);
%Prediction based on features in cross validation set
y_pre_cv=prediction(m_cv,n,cv_set,theta_1,theta_2,theta_3);

%Actual output values in training set
y_act=training_set(:,n+1);

%Calculate mean square error of training prediction
J_t(counter)=MSE(y_act,y_pre,m);

%Final mean square error of cross validation prediction for lambda tuning
if counter==n_iteration
    y_act_cv=cv_set(:,n+1);
    J_cv=MSE(y_act_cv,y_pre_cv,m_cv);
end

%calculate new coef of 1st order terms
theta_1_new=update_l(m,n,training_set,y_pre,theta_1,u,lambda);
%calculate new coef of 2rd order terms
theta_2_new=update_h(m,n,training_set,y_pre,theta_2,u,lambda,2);
%calculate new coef of 3rd order terms
theta_3_new=update_h(m,n,training_set,y_pre,theta_3,u,lambda,3);

%update coefs
theta_1=theta_1_new;
theta_2=theta_2_new;
theta_3=theta_3_new;

end

%================================================================
%Testing
%================================================================
[n_row,n_col]=size(test_set);
m_t=n_row;
n_t=n_col-1;
%Prediction based on features in testing set
y_pre_t=prediction(m_t,n_t,test_set,theta_1,theta_2,theta_3);

%Actual output values in testing set
y_act_t=test_set(:,n_t+1);

% calculate MAPE for testing set
MAPE=abs((y_act_t'-y_pre_t)./y_act_t');
MAPE=mean(MAPE);

%================================================================
%Output Files
%================================================================
y_pre_t=y_pre_t*scale;
test_result=[test_data(:,3),y_pre_t'];
csvwrite('predicted_energy_production.csv',test_result);
dlmwrite('mape.txt',MAPE,'precision','%3.5f')

