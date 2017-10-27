function sensor=newMerge(sensor, target, eps2)
%imput is sensor and target objects and epsilon squared. output is sensor
%object.

for i=1:length(target.inDiam)
    %check if any of the distances are less than eps2 for sensors that can
    %merge from the target.inDiam cell array.
    candidateSensors=target.inDiam{i};
    
    minFlag=0;
    
    x=sensor.location(1,i)*ones(1,length(candidateSensors));
    y=sensor.location(2,i)*ones(1,length(candidateSensors));
    
    vect=[x;y];
    diff=target.location(:,candidateSensors)-vect;
    dist=sum(diff.^2);
    
    
    cTemp= dist<=eps2;
    cIndex=candidateSensors(cTemp);
    if ~isempty(cIndex)
        for j=1:length(cIndex)
            maxFlag=0;
            % find indices of all targets covered by both; create restricted
            % targetDist matrix and restricted target location vector
            coverSum=full(sensor.coveringTarget(i,:))+full(sensor.coveringTarget(cIndex(j),:));
            inEither=find(coverSum);
            if ~isempty(inEither)&&~(isnan(sensor.location(1,i))||isnan(sensor.coveringTarget(1,cIndex(j))))
                loc=target.location(:,inEither);
                numLoc=size(loc,2);
                %using Welzl's algorithm compute the center and radius
                %for the targets in either sensor.
                [~,center, radius2]=minDiskRecur(loc,1:numLoc,numLoc,[],0);
                
                %if the radius is less than the radius of the sensor then
                %we can merge both sensors.
                if radius2<=sensor.squareRadius 
                    %min index should always be i maxIndex should always be
                    %cIndex(j)
                    %minIndex=min(i,cIndex(j));
                    %maxIndex=max(i,cIndex(j));
                    sensor.location(:,i)=center;
                    sensor.location(:,cIndex(j))=NaN;
                    sensor.coveringTarget(i,:)=sensor.coveringTarget(i,:)+sensor.coveringTarget(cIndex(j),:);
                    %debug
                    if any(sensor.coveringTarget(i,:)>1) || sensor.coveringTarget(i,i)==0
                        keyboard()
                    end
                    sensor.coveringTarget(cIndex(j),:)=0;
                    %if they are not able to merge then we need to run
                    %recombine algorithm to restructure  the sensors.
                else
%%%% **** commented out recombine temporarily                    
                    [sensor.location(:,i), sensor.location(:,cIndex(j)),sensor.coveringTarget(i,:),sensor.coveringTarget(cIndex(j),:)]= recombine(sensor.location(:,i),sensor.location(:,cIndex(j)),sensor.coveringTarget(i,:),sensor.coveringTarget(cIndex(j),:), target.dist2, target.location, sensor.squareRadius);
                     minIndex=find(sensor.coveringTarget(i,:)==1, 1);
                     maxIndex=find(sensor.coveringTarget(cIndex(j),:)==1, 1);
                     
                     if minIndex~=i || maxIndex~=cIndex(j)
                         if minIndex~=i
                             tempCover=sensor.coveringTarget(i,:);
                             tempPos=sensor.location(:,i);
                             tempV=sensor.velocity(:,i);
                             tempA=sensor.acceleration(:,i);
                             sensor.coveringTarget(i,:)=0;
                             sensor.location(:,i)=NaN;
                             sensor.velocity(:,i)=0;
                             sensor.acceleration(:,i)=0;
                             sensor.coveringTarget(minIndex,:)=tempCover;
                             sensor.location(:,minIndex)=tempPos;
                             sensor.velocity(:,minIndex)=tempV;
                             sensor.acceleration(:,minIndex)=tempA;
                             minFlag=1;
                         end
                         if maxIndex~=cIndex(j)
                             tempCover=sensor.coveringTarget(cIndex(j),:);
                             tempPos=sensor.location(:,cIndex(j));
                             tempV=sensor.velocity(:,cIndex(j));
                             tempA=sensor.acceleration(:,cIndex(j));
                             sensor.coveringTarget(cIndex(j),:)=0;
                             sensor.location(:,cIndex(j))=NaN;
                             sensor.velocity(:,cIndex(j))=0;
                             sensor.acceleration(:,cIndex(j))=0;
                             sensor.coveringTarget(maxIndex,:)=tempCover;
                             sensor.location(:,maxIndex)=tempPos;
                             sensor.velocity(:,maxIndex)=tempV;
                             sensor.acceleration(:,maxIndex)=tempA;
                             maxFlag=1;
                         end
                     end                      
                end
            end
            if maxFlag
                continue
            elseif minFlag
                break
            end
        end
    end
end

end