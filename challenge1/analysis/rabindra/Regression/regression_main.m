%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Training Phase %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear ; close all; clc
%% Load Data
%  The first 5 columns contains the X values and the 6th column
%  contains the label (y).
data = csvread('training_dataset_500.csv');
data_size=length(data(:,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Loading Training Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = data(1:round(0.7*data_size),4:7); 
y = data(1:round(0.7*data_size),8);
max_y = max(y);
min_y = min(y);
y = (y - min_y)./(max_y - min_y) * 0.6 + 0.2;
XF= mapFeature(X(:,3),X(:,4));
X=[X XF(:,2:end)];
[X mu sigma] = featureNormalize(X);
X(1,:)
m=length(X(:,1));
X=[ones(m,1) X];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Loading cross validation set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CX = data(round(0.7*data_size):end,4:7); 
Cy = data(round(0.7*data_size):end,8);
CXF= mapFeature(CX(:,3),CX(:,4));
CX=[CX CXF(:,2:end)];
Cy = data(round(0.7*data_size):end,8);
[CX mu sigma] = featureNormalize(CX);
CX=[ones(size(CX,1),1) CX];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Writing to file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('MAPE.txt','wt');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%cross validation loop starts here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
error=100;
selectedLambda=0;
for lambda=0.0001:0.0001:0.003
    initial_theta = zeros(size(X,2),1);
    % Set regularization parameter lambda to 1 (you should vary this)
    
    % Set Options
    options = optimset('MaxIter', 500);
    % Optimize
    [theta, J, exit_flag] = ...
    	fmincg(@(t)costFunctionReg(t, X, y, lambda), initial_theta, options);
    % Compute accuracy on our training set
    theta; % This is the saturated value of theta which will be further used for prediction
	fprintf(fid,'\n.......................................................................\n');
	fprintf(fid,'Theta : ');
	for ii = 1:size(theta,2)
	fprintf(fid,'%f\t',theta(:,ii));
	end
	fprintf(fid,'\n');    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cross Validation Phase   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    CY=sigmoid(CX*theta); % output values are obtained for cross validation set
    Y = (CY - 0.2)./0.6 .* (max_y - min_y) + min_y; % Output are transfromed to real output values
	Regularization=lambda
    MAPE=mean(abs(Y-Cy)./Cy)
     fprintf(fid,'\n.......................................................................\n');
     fprintf(fid,'\n'); 
     fprintf(fid,'Regularization : %f \n',lambda);
     fprintf(fid,'MAPE : %f',MAPE);
	if(error>MAPE)
	 selectedTheta=[];
	 error=MAPE;
	 selectedTheta=theta;
	 selectedLambda=lambda;
	end
end	
size(theta)
size(CX)
size(Cy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate Test error of the best selected model %%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = csvread('test_dataset_500.csv');
data_size=length(data(2:end,1));
TX = data(2:end,4:7); 
Ty = data(2:end,8);
size(selectedTheta)
size(CX)
size(Cy)
TXF= mapFeature(TX(:,3),TX(:,4));
TX=[TX TXF(:,2:end)];
[TX mu sigma] = featureNormalize(TX);
TX=[ones(size(TX,1),1) TX];
TY=sigmoid(TX*selectedTheta); % output values are obtained for cross validation set
max_y = max(Ty);
min_y = min(Ty);
Y = (TY - 0.2)./0.6 .* (max_y - min_y) + min_y; % Output are transfromed to real output values
fpid = fopen('predicted_energy_production.csv ','wt');
for cnt=1:data_size
fprintf(fpid,'%d,%f \n',data(1+cnt,1),Y(:,1));
end
fclose(fpid);
MMAPE=mean(abs(Y-Ty)./Ty);
fprintf(fid,'\n\nMinimum MAPE : %f \n',MMAPE);
plot(Ty(1:50,:), 'r');hold on;plot(TY(1:50,:), 'g')
legend({'original', 'predicted'});
fclose(fid);