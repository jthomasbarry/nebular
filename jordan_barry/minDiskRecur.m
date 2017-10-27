function [P,c, r2]=minDiskRecur(ptLoc,P, p, B, b)
if p==0 || b==3
    if b==0
        c=[Inf;Inf];% This replaces empty
        r2=0;
    elseif b==1;
        c=ptLoc(:,B);
        r2=0;
    elseif b==2; 
        P1 = ptLoc(:,B(1));
        P2 = ptLoc(:,B(2));
        c=(P1+P2)./2;
        a=P1-c;
        r2=a'*a;
    else
        [c, r2]=circumscribe(ptLoc(:,B(1:3)));
    end
    return
end
[P,c, r2]=minDiskRecur(ptLoc,P,p-1,B,b);
diff1 = ptLoc(:,p) - c;
if (diff1'*diff1 >r2) % takes care of the case where c is empty
   B=[p,B];
   %move-to-front (back?) heuristic
   [P,c,r2]=minDiskRecur(ptLoc,P,p-1,B,b+1);
   P = [P(p) P(1:p-1) P(p+1:end)];
end
end