function dailyConsumption(timestamp,y)

temp = floor(timestamp);
m = size(y,1);
sDay = floor(timestamp(1));
eDay = floor(timestamp(m));
x = timestamp(1):timestamp(m);
ydis = zeros(1,eDay-sDay+1);
ynum = zeros(1,size(ydis,2));
for i=1:m
    ydis(temp(i)-sDay+1)+=y(i);
    ynum(temp(i)-sDay+1)+=1;
end
ynum+=(ynum == zeros(1,size(ydis,2)));
ydis = ydis./ynum;
figure('Position',[100,100,900,500]);
bar(x,ydis)
hold on

datetick('x','mm-dd')
xlabel('Date')
ylabel('Daily Comsumption Average')
title('Energy Comsmption from 18 Apr to 23 May')
hold on

plot(x,ydis,'r','lineWidth',1.4)
end