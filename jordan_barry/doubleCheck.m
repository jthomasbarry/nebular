function sensor=doubleCheck(sensor, target)
for i=1:length(sensor.coveringTarget)
    normv=norm(sensor.velocity(:,i));
    if normv~=0 && ~isnan(sensor.location(1,i))
        check=find(full(sensor.coveringTarget(i,:))==1);
        newSide = 0;
        for j=1:length(check)
            vect=target.location(:,check(j))-sensor.location(:,i);
            d2=vect'*vect;
            if d2>sensor.squareRadius
                d_cosTheta=-sensor.velocity(:,i)'*vect/normv;
                b=(d_cosTheta)^2-d2+sensor.squareRadius;
                b = max(b,0);
                newSide=max(d_cosTheta-sqrt(b),newSide);
            end
        end
        newSide = min(newSide,normv);
        newV=newSide*sensor.velocity(:,i)/normv;%use new velocity to to move back along vector.
        sensor.location(:,i)=sensor.location(:,i)-newV;
        %%% Debugging routine -- check lengths
        for j=1:length(check)
            vect=target.location(:,check(j))-sensor.location(:,i);
            d2=vect'*vect;
            if d2>sensor.squareRadius+1e-5
                %keyboard()
            end
        end
    end
end
end