function [J, D] = cost(nn_params, hidden_layer_size,X, Y, lambda)

    % i will use 2 hidden layer network with 20 units in each
    [m, n] = size(X);
    input_layer_size = n;
    % get the weights by rolling the unrolled weights
    Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

    Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 1, (hidden_layer_size + 1));
             
     % the variables to be returned
     J = 0;
     Theta1_grad = zeros(size(Theta1));
     Theta2_grad = zeros(size(Theta2));
     
     % feedforward Propagation
    a1 = [ones(m, 1), X]'; % adding bias'
    z2 = Theta1 * a1;
    a2 = [ones(1, size(z2, 2)); sigmoid(z2)];
    z3 = Theta2 * a2;
    h = sigmoid(z3');

    % The cost
    % i will still use the sigmoid, but with small scaling constant so that
    % the shape is almost linear for range -1 to 1
    % and beyond that it cutoff to 0 and 1 respectively
    % this will not effect the  output, as output has been scaled to range
    % 0 to 1
    % so cost function i use is same as of classification
    
    J = (-1/m) * sum(sum(Y .* log(h) + (1-Y) .* log(1-h) )) + ...
            lambda /(2*m) * (sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));

    % backpropagation
    d3 = (h - Y)';
    d2 = (Theta2(:,2:end)' * d3) .* sigmoidGradient(z2);

    Theta1_grad = (1/m) * d2 * a1';
    Theta2_grad = (1/m) * d3 * a2';

    Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + lambda/m * Theta1(:, 2:end);
    Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + lambda/m * Theta2(:, 2:end);

    % -------------------------------------------------------------

    % =========================================================================

    % Unroll gradients
    D = [Theta1_grad(:) ; Theta2_grad(:)];
    
end
