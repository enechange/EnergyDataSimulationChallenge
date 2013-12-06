%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Training Data Loading Process %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
data = csvread('training_dataset_500.csv');

data_size=length(data(2:end,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Training Data Selection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = data(2:round(0.7*data_size),4:7); 
y = data(2:round(0.7*data_size),8);
max_y = max(y);
min_y = min(y);
y = (y - min_y)./(max_y - min_y) * 0.6 + 0.2;
for i=1:4
    X(:,i) = (X(:,i) - min(X(:,i)))./(max(X(:,i)) - min(X(:,i)));
end
X=[ones(length(X(:,1)),1) X];
[m, n] = size(X);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cross validation data Selection %%%%%%%%%%%%%%%%%%%%%%%%%%%
ylim=round(0.7*data_size);
CX = data(ylim:end,4:7); 
Cy = data(ylim:end,8);
for i=1:4
    CX(:,i) = (CX(:,i) - min(CX(:,i)))./(max(CX(:,i)) - min(CX(:,i)));
end
CX=[ones(length(CX(:,1)),1) CX];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Neural Network Formation and Training %%%%%%%%%%%%%%%
hidden_layer_size = 4;
input_layer_size = n;
epsilon = 2 * 6.^0.5./hidden_layer_size;
error=100;
selectedLambda=0;
selectedTheta1=[];
selectedTheta2=[];
fid = fopen('MAPE.txt','wt');
%for lambda=0.00005:0.00003:0.0004
CX(1,:)
X(1,:)
for lambda=0.0006:0.0003:0.004
     clear Theta1;  clear Theta2; clear nn_params; clear cost; clear costFunction; clear options; clear p;
     Theta1 = (rand(hidden_layer_size, (input_layer_size + 1)) -0.5)*epsilon;
     Theta2 = (rand(1, (hidden_layer_size + 1)) - 0.5)*epsilon;
     nn_params_initial = [Theta1(:) ; Theta2(:)];
     % setup for optimization
     options = optimset('MaxIter',200);
     % handle to the matlab function
     costFunction = @(p) cost(p, hidden_layer_size,X, y, lambda);      
     % Now, costFunction is a function that takes in only one argument (the
     % neural network parameters)
     [nn_params, cost] = fmincg(costFunction, nn_params_initial, options);
	 unlink('nn_params');
     save nn_params
     % Obtain Theta1 and Theta2 back from nn_params
     Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                      hidden_layer_size, (input_layer_size + 1));
     
     Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                      1, (hidden_layer_size + 1));
     				 
     				 
     
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cross Validating Code %%%%%%%%%%%%%%%%%%%%%%%
     
     p = predict(Theta1,Theta2,CX,max(Cy),min(Cy));
     MAPE=mean(abs(p-Cy)./Cy)
     fprintf(fid,'\n.......................................................................\n');
     fprintf(fid,'\n'); 
     fprintf(fid,'Regularization : %f \n',lambda);
     fprintf(fid,'MAPE : %f',MAPE);
     	if(error>MAPE)
     	 error=MAPE;
		 selectedTheta1=[];
         selectedTheta2=[];
     	 selectedTheta1=Theta1;
     	 selectedTheta2=Theta2;
     	 selectedLambda=lambda;	 
     	end	 
end	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Loading Training Set%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tdata = csvread('test_dataset_500.csv');
data_size=length(Tdata(2:end,1));
TX = Tdata(2:end,4:7); 
Ty = Tdata(2:end,8);
for i=1:4
    TX(:,i) = (TX(:,i) - min(TX(:,i)))./(max(TX(:,i)) - min(TX(:,i)));
end
TX=[ones(length(TX(:,1)),1) TX];
CX(1,:)
X(1,:)
TX(1,:)
tp = predict(selectedTheta1,selectedTheta2,TX,max(Ty),min(Ty));
fpid = fopen('predicted_energy_production.csv ','wt');
for cnt=1:data_size
fprintf(fpid,'%d,%f \n',Tdata(1+cnt,1),tp(:,1));
end
fclose(fpid);
TMAPE=mean(abs(tp-Ty)./Ty);
%checking the correctness
plot(Ty(1:50,:), 'r');hold on;plot(tp(1:50,:), 'g');
legend({'original', 'predicted'});
fprintf(fid,'\n\n\n\nSelected Regularization : %f \n',selectedLambda);
fprintf(fid,'Minimum Test MAPE : %f',TMAPE);
fclose(fid);

