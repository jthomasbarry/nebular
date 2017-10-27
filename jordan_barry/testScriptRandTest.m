%This script is used to compute coverage of a random group of
%points.
%clear all
close all
%p=parpool();
index=1;
location =rand(2,100);
numTarget=size(location,2);
r2 = 0.1^2;
for i=1:15
[sensorNumber, t, numIt, sensor]=sensorFunction(numTarget,1,location,r2);
figure(i)
% plot(sensor.number)
% hold on
% plot(numIt, sensor.leastNum, 'r*')
% figure(i+5)
makePlot2(sensor.leastLocation, location, r2, sensor.leastCovering, index)
name=sprintf('fig_%d',i);
print(name,'-dpng')
close
end