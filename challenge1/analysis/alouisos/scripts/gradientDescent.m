

% Choose some alpha value for the gradient descent 
alpha = input ("Enter the value for your alpha of the gradient descent.\n (Recommended starting value of 0.01) : ");  

% Choose the number of iterations for your gradient descent 
num_iters = input("Enter the number of iterations you would like for your gradient descent.\n (Recommended starting value of 500): ");

% Init Theta and Run Gradient Descent 
fprintf('Running gradient descent ...\n');

theta = zeros(size(X,2), 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');
hold on; 


% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');








