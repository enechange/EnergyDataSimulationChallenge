%=======================================================================
%Energy Data Simulation Challenge
%Challenge 1 MSE()
%This function calculate the mean square error of current model's predictions.
%Guanqun Wang
%2014/7/9
%e-mail: gemini910621@gmail.com
%=======================================================================
function J = MSE(y_act,y_pre,m)
    J=0;
    for i=1:m
        J=J+(y_pre(i)-y_act(i,1))^2;
    end
    J=J/(2*m);
end

