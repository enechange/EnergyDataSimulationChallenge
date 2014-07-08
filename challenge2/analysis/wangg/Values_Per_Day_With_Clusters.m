%==================================================
%Energy Data Simulation Challenge
%Challenge 2 visualization of the data-set as values per day(w/ clusters)
%Guanqun Wang
%2014/7/9
%e-mail: gemini910621@gmail.com
%==================================================

% clean up
clc
clear all

% read data
fid=fopen('total_watt.csv');
data=textscan(fid,'%f %f %f %f %f %f %f', 'delimiter','-,:/','collectoutput',1);
data=cell2mat(data);
fclose(fid);

% set up
[n_row,n_col]=size(data);
e_daily=[];% daily energy consumption
date_lb=[];% date stored in string
date_now=0;
day_counter=0;% number of different dates
data_counter=0;% number of different data entries in one day

% calculate average power consumption for each day
for i=1:n_row
    % convert the date to one number for the later comparison
    date_str=num2str(data(i,1:3));
    date_str(find(isspace(date_str)))=[];
    date_num=str2num(date_str);
    
    %if reach a new date
    if date_num~=date_now
        day_counter=day_counter+1;%count how many dates
        date_now=date_num;%record current date
        e_daily(day_counter,1:3)=data(i,1:3);%record the new date in the matrix for plot
        e_daily(day_counter,4)=data(i,n_col);%start adding power consumption for avg calculation
        date_lb{day_counter}=strcat(num2str(e_daily(day_counter,1)),'/',num2str(e_daily(day_counter,2)),'/',num2str(e_daily(day_counter,3)));%record dates in string
        if day_counter>1%calculate avg of last day
            e_daily(day_counter-1,4)=e_daily(day_counter-1,4)/data_counter;
        end
        data_counter=1;% reset counter for entries of each day
    else
        data_counter=data_counter+1;%count how many data entries for each day
        e_daily(day_counter,4)=e_daily(day_counter,4)+data(i,n_col);
    end
end
e_daily(day_counter,4)=e_daily(day_counter,4)/data_counter;% avg calculation of the last day

% thresholds for 3 clusters
lev_h=mean(e_daily(:,4))+std(e_daily(:,4))/2;
lev_l=mean(e_daily(:,4))-std(e_daily(:,4))/2;

% daw a bar for each day
for i=1:day_counter
    if e_daily(i,4)<lev_l
        low=bar(i,e_daily(i,4),'k');
        hold on;
    elseif e_daily(i,4)>lev_h
        high=bar(i,e_daily(i,4),'r');
        hold on;
    else
        med=bar(i,e_daily(i,4),'b');
        hold on;
    end
end

% daw lines for two threshold
th_h=plot([0,day_counter+1],[lev_h,lev_h],'-m');
th_l=plot([0,day_counter+1],[lev_l,lev_l],'-g');
legend([low,med,high,th_h,th_l],'low','medium','high','high threshold(mean+0.5*std)','low threshold(mean-0.5*std)');

% insert dates
[n_row,n_col]=size(e_daily);
set(gca,'XTickLabel',[]);
len=length(e_daily(:,n_col));
YMin=get(gca,'YLim');
ypos=YMin(1)-150;
xpos=1:len;
for i=1:len
    text(xpos(i),ypos,date_lb(i),'Rotation',90);
end

title('visualization of the data-set as values per day');
xlabel('Date');
ylabel('Average Energy Consumption(W)')