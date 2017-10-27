function [sensor]=checkDoubleCoverage(sensor, target)
%create zero vector of length number of targets
coverageVect=zeros(1,target.number);

%get list of possible targets form target.inDiam cell array.
for i=1:size(sensor.leastLocation,2)
    if ~isnan(sensor.leastLocation(1,i));
        %pass into candidate vector and compute distance form sensor to all
        %targets.
        check=[sensor.leastLocation(1,i).*ones(1, target.number); sensor.leastLocation(2,i).*ones(1, target.number)];
        diff=target.location-check;
        %use square distance for less computation
        dist2=sum(diff.^2);
        vectInd= dist2<=sensor.squareRadius;
        %add one if the target is within the radius. this means that it is
        %covered by the sensor.
        coverageVect(vectInd)=coverageVect(vectInd)+1;
    end
end

%make a list in increasing order of which sensors have the fewest targets.
%this can be done by summing accross the coverage matrix rows, appending
%the row number to this in another matrix M=[rowNum, sum]and calling sorted=sortrows(M,2).
%Then we can strip the first column off of sorted and use this in hte loop to 
%calculate the double coverage.
rowSum=sum(sensor.leastCovering, 2);
rowNum=1:size(sensor.leastCovering,1);
check=[rowNum(rowSum>0)',rowSum(rowSum>0)];
sorted=sortrows(check,2);

%use the first column. it should return the indices in sorted order.
sortRow=full(sorted(:,1));

%now go through covered vector. If all the the targets in a given sensor
%are covered by other sensors then that sensor can be eliminated. this does
%not assign the targets to a given sensor. it only eliminates extraneous
%sensors. This should be addressed at a later time if this is to be used
%for plotting locations.
for j=sortRow'
    a=logical(sensor.leastCovering(j,:));
    if all(coverageVect(a)>1)
        coverageVect(a)=coverageVect(a)-1;
        sensor.leastLocation(:,j)=NaN;
        sensor.leastNum=sensor.leastNum-1;
    end
end
end
