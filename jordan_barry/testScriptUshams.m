%This script is used to compute coverage ofa a regularly spaced group of
%points. Here we convert a map of Europe and UShams to points at regularly spaced
%intervals. 

%initialize some paramaters 
%radiusMult is a multiplier for the normalizing factor in the map function.
radiusMult=[1, 2, 4, 8]*1.000001;%small factor to make the radius slightly larger
%skip will add space between dots to make the region more sparse. lower
%numbers will make the map dense, higher numbers for a sparse region. Start
%with a multiple of 2 then multiply by 1.5 to get successive constants.
%start with 8 for europe, 4 for usham round up to 14.
skip=[14 9 6 4];
inFile='ushams.png';
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
        [sensorNumber, t, numIt, sensor]=sensorFunction(numTarget,1,location,r2);
        makePlot2(sensor.location, location, r2,sensor.coveringTarget, ind)
        dataMatrix(ind,:)=[numTarget,sensorNumber,r2,i,t,numIt];
        ind=ind+1;
    end
end
%output to csv file for later graphing
fileName=sprintf('ushamsData%s.csv',date);
csvwrite(fileName,dataMatrix)