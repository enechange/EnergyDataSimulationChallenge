%=======================================================================
%Energy Data Simulation Challenge
%Challenge 1 prediction()
%This function calculates output prediction based on input and current
%generalization model.
%Guanqun Wang
%2014/7/9
%e-mail: gemini910621@gmail.com
%=======================================================================
function y_pre= prediction(m,n,training_set,theta_1,theta_2,theta_3);
    y_pre=zeros(1,m);
    for i=1:m % calculate sum of error for each training data entries
        x_current_l=[1 training_set(i,1:n)];% matrix of input for 1st order terms
        % Note: x_0=1 is added for matrix multiplicaiton
        x_current_h=training_set(i,1:n);% matrix of input for higher order terms
        y_pre(i)=x_current_l*theta_1'+x_current_h.^2*theta_2'+x_current_h.^3*theta_3';% predicted output
    end
end

