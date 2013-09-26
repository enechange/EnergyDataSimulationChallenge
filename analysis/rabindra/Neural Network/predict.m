function p = predict(Theta1, Theta2, X, max_y, min_y)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)
[m, n] = size(X);
h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
% transform the output  original range
p = (h2 - 0.2)./0.6 .* (max_y - min_y) + min_y;

% =========================================================================
end