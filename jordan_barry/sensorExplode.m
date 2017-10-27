function [sensor,explodeFlag]=sensorExplode(sensor, target)
%display(sum(sum(sensor.coveringTarget)),'begin') %for debugging
minVel=-1.5;
maxVel=1.5;
explodeFlag=0;
activeSensor=find(~isnan(sensor.location(1,:)));
for i=activeSensor
    if rand<sensor.explodeProb
        explodeFlag=1;
        index=find(full(sensor.coveringTarget(i,:)));
        sensor.location(:,index)=target.location(:,index);
        sensor.velocity(:,index)=(maxVel-minVel).*rand(2,length(index))+minVel;
        sensor.coveringTarget(index,:)=0;
        %%% Debug -- check to see if target in exploded sensor is also somewhere else
        if max(sensor.coveringTarget(:,index))>0
            keyboard()
        end
        sensor.coveringTarget(index,index) = eye(length(index),length(index));
        %%% Debug
        if min(sum(sensor.coveringTarget(index,:),2))==0
            keyboard()
        end
        if sum(sum(sensor.coveringTarget))>target.number
            keyboard()
        end
%         for j=index
%             sensor.coveringTarget(j,j)=1;
%         end
    end
end
%display(sum(sum(sensor.coveringTarget)),'end') %for debugging
end     