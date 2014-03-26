% Cleaning and clearing and keeping tidiness over your workspace :-) 
clear all; close all; clc 


% import data into an octave structure and extract them 

fprintf("1) Importing Data \n"); 
fprintf('Program paused. Press enter to continue.\n');
pause;


data = importdata("total_watt.csv", ","); 
time_data = data(1).textdata ;
production_per_30min = data(1).data;

% serialize time data 

fprintf("\n2) Serialising time data. This might take a few seconds...\n ");
fprintf('Program paused. Press enter to continue.\n');
pause;
fprintf('\n Serialising done.\n');


for i = 1:size(time_data,1), 
	date_serial(i,1) = datenum(time_data(i,1)); 
			i = i+1;
				end;

% make the plot for visualizing the 30 min data 

fprintf("\n3) Press any key to visualize production per 30 minutes\n ");
fprintf('Program paused. Press enter to continue.\n');
pause;


figure(1); subplot(2, 1, 1); plot(date_serial, production_per_30min); 
legend("Visualization of production per 30 min"); 
xlabel("Date")
ylabel("Production (W)")
datetick(20); 
hold on; 
fprintf("\nWhen you are happy with the visualization press any key\n ");
fprintf('Program paused. Press enter to continue.\n');
pause;


fprintf("\n4) Next step is to calculate the days from the dates\n ");
fprintf('Program paused. Press enter to continue.\n');
pause;

% create a matrix that can be extracted in json form for D3js streaming visualization 

for_json = [date_serial, production_per_30min]; 

 
 a= zeros(size(for_json, 1)- 1, 1) ; 

i = 1; 

for i =1:size(a, 1) ; 

% Find the days. When day number from datestr changes it is another day 
% This is what I like to call day change detector part of the script :-) (elegant ain't not?)

a(i, 1:2)  = datestr(for_json(i,1), 7) == datestr(for_json(i+1,1), 7); 
i = i + 1; 
end

% remember that you miss one last production value for the last day that way 


% count the days 

days = 1; 
for j = 1:1600 ; 
	if a(j, 2) == 0 
		days = days + 1 ; 
	endif 
	end 
	

	fprintf("\nThe number of days in our sample is : %.0f \n", days);

fprintf('Program paused. Press enter to continue calculating production per day.\n');
pause;


% calculate the production per day value in a matrix 
	 
clear production_per_day;
production_per_day = zeros(days, 1) ; 
l = 1 ; 
for k = 1:1599; % 
	if a(k, 2) > 0 
		production_per_day(l, 1) = production_per_day(l, 1) + for_json(k, 2);
	k = k + 1 ;
		if a(k, 2) == 0 
			production_per_day(l, 1) = production_per_day(l, 1) + for_json(k, 2);
			k = k + 1;
			l = l + 1 ;
		endif 
	endif 
	 
end

 % add the last value in production_per_day that was not counted before 
production_per_day(35, 1) = production_per_day(35,1) + for_json(1600, 2); 
production_per_day(35, 1) = production_per_day(35,1) + for_json(1601, 2); 



% make the days matrix for visualization  

days_serial = zeros(days, 1) ; 
l = 1 ;
for k = 1:1599 ; 
	if a(k, 2) > 0 
		days_serial(l,1) = for_json(k, 1);
		k = k + 1 ;

	if a(k,2) == 0 
		k = k + 1;
		l = l + 1;
	endif 
	endif
	end 

% include last day 

days_serial(days, 1) = for_json(1601, 1); 

fprintf("\n4) Press any to visualize production data per day \n ");
fprintf('Program paused. Press enter to continue.\n');
pause;


% Plot Production Per day 
	
figure(1); subplot(2,1,2); bar(days_serial, production_per_day); 
legend("Visualization of production per day"); 
xlabel("Date")
ylabel("Production (W)")
datetick(20); 



