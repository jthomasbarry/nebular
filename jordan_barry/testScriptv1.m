%This is a testing script for sensorCover program. It should generate
%inputs and put outputs in a matrix. form there, the output will be written
%into a csv file or saved as a mat file (this can be determined later). For
%the test, to compute the region size we will solve for it using the vector
%of density coefficients [0.25 0.5 0.75 1.0 1.25]. I will use a floor
%function to round the numbers down. output will be in the
%form of the vector [numSensInit numSensFin density region rad time numIt].
%sensosFunctin will accept as input sensorNumber region squareRadius and
%location output will be finalSensorNum time numIt. 
region = 1;
sensorNumber=floor(logspace(1,4,5));
densityCoefficient=[0.25 0.5 0.75 1 1.25];
numRow=length(sensorNumber)*length(densityCoefficient)*1*5;
dataMatrix=zeros(numRow,7);
%this will keep track of the matrix row for data storage
matIt=1;
%start loop
for i=sensorNumber
    for j=densityCoefficient
        squareRadius=j/(i*pi);
        radius = sqrt(squareRadius);
        
        %generate multiple random numbers
        for num=1:5
            targetLocation=rand(2,i)*region;
            %run the test three times with the exact same data
            for k=1:1
                [finalSensorNumber, time, numIt]=sensorFunction(i, region, targetLocation, squareRadius);
                dataMatrix(matIt,:)=[i, finalSensorNumber, j, region, radius, time, numIt];
                disp(matIt)
                matIt=matIt+1;
            end
        end
    end
end

%write the matrix to an excel file for ease of viewing.
NumberInitial=dataMatrix(:,1);
NumberFinal=dataMatrix(:,2);
Density=dataMatrix(:,3);
RegionSize=dataMatrix(:,4);
Radius=dataMatrix(:,5);
ExecutionTime=dataMatrix(:,6);
NumberIterations=dataMatrix(:,7);
PercentChange=(NumberInitial-NumberFinal)./NumberInitial;
SensorAreatoTotalArea=(pi*(Radius.^2).*NumberFinal)./(RegionSize.^2);
TargetPerSensor=NumberInitial./NumberFinal;

%myTable=table(NumberInitial, NumberFinal, Density, RegionSize, Radius,...
%    ExecutionTime, NumberIterations, PercentChange, SensorAreatoTotalArea,...
%    TargetPerSensor);

%writetable(myTable, 'testScriptData1.csv','Delimiter',',')
fileName=sprintf('testScriptData%s.csv',date);
csvwrite(fileName, dataMatrix)