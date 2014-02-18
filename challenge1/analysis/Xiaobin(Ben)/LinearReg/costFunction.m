% compudate the cost and the gradient
function [J, grad] = costFunction(theta, X, y, lambda)

m = length(y); % number of training examples

J = 0;
grad = zeros(size(theta));
k = length(theta);
htheta = X*theta;

J = ((htheta-y)'*(htheta-y)+ theta(2:k)'*theta(2:k)*lambda)/2/m;
grad(1) = X(:,1)'*(htheta-y)/m;
grad(2:k) = X(:,2:k)'*(htheta-y)/m + lambda/m*theta(2:k);

end
