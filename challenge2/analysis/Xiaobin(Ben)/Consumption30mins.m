function Consumption30mins(timestamp,y)

x = zeros(1,48);
ydis = zeros(1,48);
ynum = zeros(1,48);
for i=1:48
    x(i) = timestamp(i) - floor(timestamp(i));
end

for i=1:size(y,1)
    ydis(mod(i-1,48)+1)+=y(i);
    ynum(mod(i-1,48)+1)+=1;
end

index = 1;
for i=1:47
    if(x(i)<x(i+1))
        index = i+1;
    else
        break;
    end
end

x(1:index) -= 1;

%ynum+=(ynum == zeros(1,size(ydis,2)));
ydis = ydis./ynum;



figure('Position',[100,100,900,500]);
bar(x,ydis)
datetick('x','HH:MM')
xlabel('HH:MM')
ylabel('Comsumption Every 30 mins')
title('Energy Comsmption from 18 Apr to 23 May')

end