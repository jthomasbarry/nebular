%This script is used to compute coverage ofa a regularly spaced group of
%points. Here we convert a map of Europe to points at regularly spaced
%intervals. 

%initialize some paramaters 
%radiusMult is a multiplier for the normalizing factor in the map function.
radiusMult=[4]*1.00000001;% Additinoal factor to prevent radius exactly equal to spacing
%skip will add space between dots to make the region more sparse. lower
%numbers will make the map dense, higher numbers for a sparse region. Start
%with a multiple of 2 then multiply by 1.5 to get successive constants.
%start with 8 for europe
skip=[18];
inFile='europe_blank.gif';
rows=length(skip)*length(radiusMult);
cols=6;
%store data in here and then put in csv file
dataMatrix=zeros(rows,cols);
ind=1;
for i=skip
    [~,location,ds]=makeTargetFun(inFile, i);
    numTarget=size(location,2);
    for j=radiusMult
        %display ind so you can see progress.
        disp(ind)
        r2=(j*i*ds)^2;
        [sensorNumber, t, numIt]=sensorFunction(numTarget,1,location,r2);
        dataMatrix(ind,:)=[numTarget,sensorNumber,r2,i,t,numIt];
        ind=ind+1;
        figure(2)
plot(sensor.number)
hold on
plot(numIt, sensor.leastNum, 'r*')
figure(3)
makePlot2(sensor.leastLocation, location, r2, sensor.leastCovering, index)

    end
end
%output to csv file for later graphing
fileName=sprintf('europeData%s.csv',date);
csvwrite(fileName,dataMatrix)