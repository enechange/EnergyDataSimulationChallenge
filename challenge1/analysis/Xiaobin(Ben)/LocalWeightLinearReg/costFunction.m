% compudate the cost and the gradient
% assume X and x is normalized
% x is the point that needs prediction
% x is 1*k
%cost function J = sum of wi*(yi'-yi)^2 + lambda, where wi is the local weight 
function [J, grad] = costFunction(theta, X, y, lambda, x, t)

m = length(y); % number of training examples

J = 0;
grad = zeros(size(theta));
k = length(theta);
k = length(theta);
htheta = X*theta;
% calculate weight
% weight of xi = e^-(((x(i)-x)/2)^2)
% weight should be m*1
%weight = e.^(-((sum(abs(X - x)/2,2)).^2)) /2t^2, where t controls how fast the weight change

weight = e.^(-((sum(abs(bsxfun(@minus, X, x))/2,2)).^2));
weight = weight/2/t^2;

% calculate cost function
J = ((htheta-y)'*((htheta-y).*weight) + theta(2:k)'*theta(2:k)*lambda)/2/m;

% calculate gradient descent
grad(1) = X(:,1)'*((htheta-y).*weight)/m;
grad(2:k) = X(:,2:k)'*((htheta-y).*weight)/m + lambda/m*theta(2:k);

end
