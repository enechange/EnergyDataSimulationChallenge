%==================================================
%Energy Data Simulation Challenge
%Challenge 2 visualization of the data-set as values per day
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

% measure size of matrix
[n_row,n_col]=size(data);

% thresholds for 3 clusters
lev_h=mean(data(:,n_col))+std(data(:,n_col))/2;
lev_l=mean(data(:,n_col))-std(data(:,n_col))/2;

% daw bars
figure(1);
for i=1:n_row
    if data(i,n_col)<lev_l
        low=stem(i,data(i,n_col),'g','markersize',1);
        hold on;
    elseif data(i,n_col)>lev_h
        high=stem(i,data(i,n_col),'r','markersize',1);
        hold on;
    else
        med=stem(i,data(i,n_col),'b','markersize',1);
        hold on;
    end
end

% daw lines for two threshold
th_h=plot([0,n_row+1],[lev_h,lev_h],'-m');
th_l=plot([0,n_row+1],[lev_l,lev_l],'-y');
legend([low,med,high,th_h,th_l],'low','medium','high','high threshold(mean+0.5*std)','low threshold(mean-0.5*std)');

title('visualization of the data-set as values per 30min');
xlabel('# of data sample');
ylabel('energy consumption(W)');

hold off;

% plot of fourier transform of data
y=fft(data(:,n_col),n_row);
mag=2*abs(y)/n_row;
n=0:length(y)-1;
fs=1/(30*60);% sampling frequency
% the missing data for some sampleing times are ignored  
f=fs*n/length(y);
figure(2);
plot(f(1:n_row/2),abs(mag(1:n_row/2)));
title('Fourier Transform of Data per 30 min');
xlabel('Frequency(Hz)');
ylabel('energy consumption(W)');
axis

% plot of energy consumption for different times in a day
one_day=zeros(24*2,4);

% calculate average energy consumption for each sample times in one day
for i=1:24
    for j=1:2
    ind=(i-1)*2+j;
    one_day(ind,1)=i-1;
    one_day(ind,2)=(j-1)*30+22;
    for k=1:n_row
        if data(k,4:5)==one_day(ind,1:2)
            one_day(ind,3)=one_day(ind,3)+data(k,7);
            one_day(ind,4)=one_day(ind,4)+1;
        end
    end
    end
end
one_day(:,3)=one_day(:,3)./one_day(:,4);

% store times in string
for i=1:24*2
    t{i}=strcat(num2str(one_day(i,1)),':',num2str(one_day(i,2)));
end
lev_h=mean(one_day(:,3))+std(one_day(:,3))/2;
lev_l=mean(one_day(:,3))-std(one_day(:,3))/2;

% daw a bar for each sample time
figure(3);
for i=1:24*2
    if one_day(i,3)<lev_l
        low=bar(i,one_day(i,3),'k');
        hold on;
    elseif one_day(i,3)>lev_h
        high=bar(i,one_day(i,3),'r');
        hold on;
    else
        med=bar(i,one_day(i,3),'b');
        hold on;
    end
end


% daw lines for two threshold
th_h=plot([0,24*2+1],[lev_h,lev_h],'-m');
th_l=plot([0,24*2+1],[lev_l,lev_l],'-g');
legend([low,med,high,th_h,th_l],'low','medium','high','high threshold(mean+0.5*std)','low threshold(mean-0.5*std)');

% insert time labels
[n_row,n_col]=size(one_day);
set(gca,'XTickLabel',[]);
len=length(one_day(:,n_col));
YMin=get(gca,'YLim');
ypos=YMin(1)-80;
xpos=1:len;
for i=1:len
    text(xpos(i),ypos,t(i),'Rotation',90);
end

title('Average Energy Consumption for Each Sampling Time');
xlabel('Time');
ylabel('Average Energy Consumption(W)')

