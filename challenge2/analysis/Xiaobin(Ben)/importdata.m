data=textread("total_watt.csv", "%s", "delimiter", ","); 
m = size(data,1);
timestamp = [];
y = [];
for i=1:m/2
    timestamp = [timestamp; datenum(data{2*i-1,1},'yyyy-mm-dd HH:MM:SS')];
    y = [y; str2double(data{2*i,1})];
end