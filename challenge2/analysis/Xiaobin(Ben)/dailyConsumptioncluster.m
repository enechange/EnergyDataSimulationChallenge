function dailyConsumptioncluster(timestamp,y)

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

sigma = std(ydis);
mu = mean(ydis);
figure('Position',[100,100,900,500]);
for i=1:size(x,2)
    temp = bar(x(1,i),ydis(1,i),0.5);
    hold on
    if( ydis(i) < mu - sigma*0.5)        
        set(temp, 'FaceColor', 'g');
    elseif( ydis(i) > mu + sigma*0.5)
        set(temp, 'FaceColor', 'r');
    else
        set(temp, 'FaceColor', 'y');
end

datetick('x','mm-dd')
xlabel('Date')
ylabel('Daily Comsumption Average')
title('Energy Comsmption from 18 Apr to 23 May')
hold on
plot(x,ydis,'b','lineWidth',1.5);
end