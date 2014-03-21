function J = computeCostMulti(X, y, theta)
%COMPUTECOSTMULTI Compute cost for linear regression with multiple variables
%   J = COMPUTECOSTMULTI(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% ====================== COST FUNCTION COMPUTATION ======================
% 


h = X * theta; 
diff = h - y ;
J = 1./2./m * (diff'* diff);   % diff' * diff einai vectorization tou sum tou tetragwnou 





% =========================================================================

end
