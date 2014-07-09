%=======================================================================
%Energy Data Simulation Challenge
%Challenge 1 update_h()
%This function updates the coefs of high order terms in the polynomial.
%Guanqun Wang
%2014/7/9
%e-mail: gemini910621@gmail.com
%=======================================================================

function theta_h_new=update_h(m,n,training_set,y_pre,theta_h,u,lambda,d)
    for j=1:n
        e_sum=0;%initial value for sum of error
        for i=1:m % calculate sum of error for each training data entries
            x_current_h=training_set(i,1:n);% matrix of input for higher order terms
            y=training_set(i,n+1);% matrix of output
            e_sum=e_sum+(y_pre(i)-y)*x_current_h(j)^d;
        end
        theta_h_new(j)=theta_h(j)*(1-u*lambda/m)-(u/m)*e_sum;
    end
end

