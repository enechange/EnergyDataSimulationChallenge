%===============================NOMRALIZING THE FEATURES IN YOUR DESIGN MATRIX=========================

function [X, X_old] = featureNormalize(X)


%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. 

% setting up the matrices for the coming variables.....
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));


% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');


 

     
mu = mean(X); % you will need that value to normalize new inputs for prediction 
sigma = std(X); % you will need that value to normalize new inputs for prediction 
X_norm = studentize(X); % this is the function that normalizes the features in your design matrix 
X_old = zeros(size(X,1), size(X,2)); 
X_old = X; % keep a copy of the old design matrix 
X = X_norm; % make the design matrix the normalized one 

X = [ones(length(X),1) X];  % add the ones for theta(0) initialization 



fprintf('Normalizing Done ...\n');






% ============================================================

end
