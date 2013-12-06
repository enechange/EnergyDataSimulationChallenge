function g = sigmoid(z)
% scaling factor of 0.5 to shape the sigmoid curve
    g = 1.0 ./ (1.0 + 10.0 * exp(-z));
end