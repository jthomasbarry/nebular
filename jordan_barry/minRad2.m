function [center, radius2]=minRad2(targetLoc, targetDist)
n=size(targetLoc,2);
this=1;
[~, maxIndex]=max(targetLoc(1,:));
[~, minIndex]=min(targetLoc(1,:));
while this
    vec2Min=(targetLoc(:,minIndex)*ones(1,n))-targetLoc;
    vec2Max=(targetLoc(:,maxIndex)*ones(1,n))-targetLoc;
    
    numerator=sum(vec2Min.*vec2Max,1);
    denom=max(targetDist(minIndex, :).*targetDist(maxIndex, :), 1*exp(-16));% Need to keep denom from becoming 0
    cosTheta=numerator./denom;
    
    vecDif=vec2Max(:,minIndex);
    vecSign=vecDif(1)*vec2Min(2,:)-vecDif(2)*vec2Min(1,:);
    
    above=find(vecSign>0);
    below=find(vecSign<0);
    
    cosA=cosTheta(above);
    cosB=cosTheta(below);
    
    [cosA, indA] = max(cosA);
    [cosB, indB] = max(cosB);
    
    cosVect=[cosA, cosB];
    
    realInd=[above(indA),below(indB)];
    
    %test if sum of cos less than or equal to zero
    if sum(cosVect)<=0 || length(cosVect)==1 % \\ takes care of case where all are above / below
        [~, select]=max(cosVect);
        ind3=realInd(select);
        a2= targetDist(minIndex,ind3).^2; 
        b2 = targetDist(maxIndex,ind3).^2; 
        c2 = targetDist(minIndex,maxIndex).^2;
        if a2 > b2 + c2
            maxIndex = ind3;
        elseif b2 > a2 + c2
            minIndex = ind3;
        else
            %maxSin=sqrt(1-maxCos^2);
            %radius2=1/2*(distance(minIndex, maxIndex)/maxSin);
            this=0;
            P1=targetLoc(:, minIndex);
            P2=targetLoc(:, maxIndex);
            if all(cosVect<=0)
                center=(P1+P2)/2;
            else
                
                P3=targetLoc(:, ind3);
                
                A = [ (P3-P1) (P3-P2) ]';
                b = [0.5*A(1,:)*(P1+P3) ; 0.5*A(2,:)*(P2+P3)];
                x=A\b;
                %matrix solve x=A\b;
                %solve for x
                %x=(slopeAB*slopeBC*(c(2)-a(2))+slopeAB*(b(1)+c(1))-slopeBC*(a(1)+b(1)))/(2*(slopeAB-slopeBC));
                %sub and sovle for y
                %y=(-1/slopeAB)*(x-(a(1)+b(1))/2)+((a(2)+b(2))/2);
                
                center=x;
                
                this = 0;
            end
        end
    else
        %not extreme in x. extreme in
        %maxx=targetLocation(1,realInd(1));
        maxIndex=realInd(1);
        %minx=targetLocation(1,realInd(2));
        minIndex=realInd(2);
    end
end
temp = center - P1;
radius2 = temp'*temp;
end
