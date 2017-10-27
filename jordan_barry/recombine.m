function [sensor1, sensor2, coveredTarget1, coveredTarget2]=recombine(sensor1, sensor2, coveredTarget1, coveredTarget2, targetDist2, target, r2)
%sensor1 and sensor2 are locations of some sensors
%coveredTarget vector of 1s and 0s denoting which targets are covered
%target is 2 X n matrix of target locations
%r2 is radius squared
%debug
if any(coveredTarget1>1)|| any(coveredTarget2>1)
    keyboard()
end

%make the vectors full i guess.
ct1Full=full(coveredTarget1);
ct2Full=full(coveredTarget2);

%cTemp2 is necessary for after we update the ct2Full.
cTemp2=ct2Full;
check1=find(ct1Full==1);

%loop through the indices of the targets covered by the first sensor and
%if they are within r2 of the second sensor, add them to the second sensors
%covering array.
for i=1:length(check1)
    if (sensor2(1)-target(1,check1(i)))^2+(sensor2(2)-target(2,check1(i)))^2<=r2
        ct2Full(check1(i))=1;
    end
end

check2=find(cTemp2==1);
%this is the same as before but with the other targets and the other
%sensor.
for i=1:length(check2)
    if (sensor1(1)-target(1,check2(i)))^2+(sensor1(2)-target(2,check2(i)))^2<=r2
        ct1Full(check2(i))=1;
    end
end

%subtract and find the overlapping targets.
ind1=find((ct1Full-ct2Full)==1);
ind2=find((ct2Full-ct1Full)==1);

%get a submatrix to compute minDisk
distMat1=targetDist2(ind1,ind1);
distMat2=targetDist2(ind2,ind2);

%if we have ,more than zero elements in both find center and radius using
%the minimum disk routine.
if ~(isempty(distMat1)||isempty(distMat2))
    l1=size(target(:,ind1),2);
    l2=size(target(:,ind2),2);
    
    [~,center1,rad1]=minDiskRecur(target(:,ind1),1:l1,l1,[],0);
    [~,center2,rad2]=minDiskRecur(target(:,ind2),1:l2,l2,[],0);
    
    %the next statements are used to assign the minimum circle to the
    %fewest target.
    
    if rad1<rad2
        ct1Full(:)=0;
        ct1Full(ind1)=1;
        sensor1=center1;
    else
        ct2Full(:)=0;
        ct2Full(ind2)=1;
        sensor2=center2;
    end
    
    %this is only in place as a debugging precaution
else
    keyboard()
    %      ct2Full(:)=0;
    %      ct2Full(check2)=1;
    %      sensor1=target(:,check2);
    %      ct1Full(check2)=0;
end
coveredTarget1=sparse(ct1Full);
coveredTarget2=sparse(ct2Full);

%%% Debugging -- looking for target assigned to multiple sensors.
if max(coveredTarget1 + coveredTarget2)>1
    keyboard()
end


end