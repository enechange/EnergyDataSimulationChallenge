function [J, grad] = costFunctionReg(theta, X, y, lambda)
m = length(y);
h = sigmoid(X * theta);
theta2 = [0; theta(2 : end)];
J = (-1/m) * (y' * log(h) + (1 - y') * log(1 - h)) + ((lambda / (2*m)) * (theta2' * theta2));
grad = (1/m) * (X' * (h - y)) + ((lambda / m) * theta2);
%=============================================================
end
