function [data, y] = preProcessData(filename)

% read raw data
rawdata = load(filename);
m = size(rawdata,1);

% get house and year info; 
data = rawdata(:,3:4);

% code month into 1*12 feature
% for example, Jan -> 100000000000, Tue ->010000000000

months = repmat(rawdata(:,5),1,12); %m*12 matrix indicates the months
months2 = 1:12;
months2 = repmat(months2,m,1);
data = [data (months == months2)];
% get tempreture and daylight info
data = [data rawdata(:,6:7)];

% add constant variable 1
data = [ones(m,1) data];

% get y
y = rawdata(:,8);

end