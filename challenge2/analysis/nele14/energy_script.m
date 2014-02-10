% open the .csv file and load the date and readings into a cell
fileID = fopen('total_watt.csv');
values = textscan(fileID, '%s %f','delimiter', ',');
fclose(fileID);
% get the number of date-reading pairs
num_rec=size(values{1,1},1);

% converting date strings into Matlab-formatted time values
time=zeros(num_rec,1);
for i=1:num_rec,
time(i)=datenum(values{1,1}{i,1});
end

%plot the readings against time of readings, datetick specifies that we'd
%like dayday/monthmont format on the ticks, xlim sets the time limits to be
%equal to the min and max time in the input data. grid on turns the grid on
%on the plot and xlabel and y label print labels for x and y axis,
%respectively
plot(time,values{1,2},'bo')
datetick('x',19);
xlim([time(1) time(num_rec)]);
grid on
xlabel('Time of measurement','fontsize',14)
ylabel('Energy reading (W)','fontsize',14)

% preparation of variables for a loop to go through the readings and calculate per-day
% consumption. datevec as given below returns a double containing the day
% value in date, e'g. for the 14th of February 2013 it will return 14. I
% kept it simple, with the drawback that the gaps cannot be larger than a
% month. This can be fixed, it'd only require a more complex if
% statements in the loop below
day_consum=[];
timing_consum=[];
sum_consum = 0;
[~, ~, start_date, ~, ~, ~] = datevec(time(1));
start_time = time(1);

% loop looks for a change in day value in date (end of day), once it finds
% it calculates the consumption for the day. I have calculated it in kWh
% (as I think that is what I get in my electricity bills :-) so that's why
% the readings are multiplied by 24 (Matlab gives the time difference in
% days) and divided by 1000 to get kWh instead of Wh. The last if statement
% takes care of the last day not being complete.
for i=1:num_rec,
[~, ~, curr_date, ~, ~, ~] = datevec(time(i));

if (curr_date == start_date)
    sum_consum = sum_consum + values{1,2}(i);
else
    day_consum = [day_consum sum_consum * (time(i-1)-start_time) * 24/1000]; %#ok<AGROW>
    timing_consum=[timing_consum time(i-1)]; %#ok<AGROW>
    start_date = curr_date;
    start_time = time(i);
    sum_consum = values{1,2}(i);
end

if (i == num_rec)
    day_consum = [day_consum sum_consum * (time(i)-start_time) * 24/1000]; %#ok<AGROW>
    timing_consum=[timing_consum time(i)]; %#ok<AGROW>
end
end

% plotting the figure with total consumption vs date. I have set thresholds
% at <500 kWh for low consumption and >1000 kWh for high consumption.
% I tried to achieve both daily consumption and clustering in a single plot
% ( please note that there are no values for 04/05 and 05/05)
figure(2)
above1kWh = day_consum;
below500Wh = day_consum;
above1kWh(day_consum<1000) = NaN;
below500Wh(day_consum>500) = NaN;
plot(timing_consum,day_consum,'bo',timing_consum,above1kWh,'ro',timing_consum,below500Wh,'go','MarkerSize',10);
datetick('x',19);
grid on
xlabel('Date of measurement','fontsize',14)
ylabel('Total Daily Energy consumption (kWh)','fontsize',14)
h_legend=legend('Medium Consumption','High Consumption','Low Consumption');
set(h_legend,'FontSize',12);
