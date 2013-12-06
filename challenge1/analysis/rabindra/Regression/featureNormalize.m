function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard iation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly


% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the 
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
[r,c]=size(X);
for i=1:c
Xcu=X(:,i);
m=length(Xcu);
mu(:,i)=sum(Xcu)/m;
flagVec=mu(:,i)*[ones(m,1)];
sigma(:,i)=std(Xcu(:,1));
X_norm(:,i)=(Xcu-flagVec)./sigma(:,i);

%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       





% ============================================================

end
