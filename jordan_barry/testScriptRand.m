%This script is used to compute coverage of a random group of
%points.
%clear all
close all
%p=parpool();
index=1;
location =rand(2,100);
numTarget=size(location,2);
r2 = 0.1^2;
[sensorNumber, t, numIt, sensor]=sensorFunction(numTarget,1,location,r2);
figure(2)
plot(sensor.number)
hold on
plot(numIt, sensor.leastNum, 'r*')
figure(3)
makePlot2(sensor.leastLocation, location, r2, sensor.leastCovering, index)
figure(4)
makePlot2(location,location,r2)