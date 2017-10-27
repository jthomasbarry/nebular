function sensor=checkDist(target, sensor)
for i=1:sensor.number
    check=target.inDiam{i};
    for j=1:length(check)% go from i+1 to length(location)
        distance2_this=(sensor.location(1,i)-sensor.location(1,check(j)))^2+(sensor.location(2,i)-sensor.location(2,check(j)))^2;
        
        sensor.dist2(i,check(j))=distance2_this;
        sensor.dist2(check(j),i)=distance2_this;
    end
end
end