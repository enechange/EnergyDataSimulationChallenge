%=======================================================================
%Energy Data Simulation Challenge
%Challenge 1 update_l()
%This function updates the coefs of 1st order terms in the polynomial.
%Guanqun Wang
%2014/7/9
%e-mail: gemini910621@gmail.com
%=======================================================================
function theta_1_new=update_l(m,n,training_set,y_pre,theta_1,u,lambda)
    for j=1:n+1
        e_sum=0;%initial value for sum of error 
        %note: the sum of error here is actually d{sum[(y_prediction-y)^2]}/d(theta)
        for i=1:m % calculate sum of error for each training data entries
            x_current_l=[1 training_set(i,1:n)];% matrix of input for 1st order terms
            % Note: x_0=1 is added for matrix multiplicaiton
            y=training_set(i,n+1);% matrix of output
            e_sum=e_sum+(y_pre(i)-y)*x_current_l(j);
        end
        theta_1_new(j)=theta_1(j)*(1-u*lambda/m)-(u/m)*e_sum;
    end
end

