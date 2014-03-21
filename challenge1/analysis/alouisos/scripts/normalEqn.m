function [theta] = normalEqn(X, y)
%NORMALEQN Computes the closed-form solution to linear regression 
%   NORMALEQN(X,y) computes the closed-form solution to linear 
%   regression using the normal equations.

X = [ones(length(X),1) X] ;  % add the ones for theta(0) initialization 
theta = zeros(size(X, 2), 1);

 
%

% ----------------------Normal Equation Computation -----------

theta = pinv(X'*X) * X' * y ; 


% -------------------------------------------------------------


% ============================================================




% Display normal equation's result
fprintf('Theta computed from normal equation: \n');
fprintf(' %f \n', theta);
fprintf('\n');


end