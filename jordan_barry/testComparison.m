clear all
close all

numTarget=500;
locations=rand(2,numTarget);
sqRad=0.05^2;
region=1;

size=20;
col=4;
dataMatrix=zeros(size,col);

for i=1:size
    
    [sensorNumber, t, numIt, sensor]=sensorFunction(numTarget,1,locations,sqRad);
    dataMatrix(i,:)=[numTarget, sensorNumber, t, numIt];
end


csvwrite('comparison2.csv',dataMatrix)