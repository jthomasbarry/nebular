function [center, rad2]=circumscribe(ptLoc)
% Formula from Wikipedia, "Circumscribed circle"
% Uses complex numbers
Bp = ptLoc(:,2)-ptLoc(:,1);
Cp = ptLoc(:,3)-ptLoc(:,1);
Bp2 = Bp'*Bp;
Cp2 = Cp'*Cp;
D = 2*(Bp(1)*Cp(2)-Bp(2)*Cp(1));
vec = (Bp2*[Cp(2);-Cp(1)] + Cp2*[-Bp(2);Bp(1)])/D;
center = ptLoc(:,1)+ vec;
rad2 = vec'*vec;

end
% function [c, r2]=circumscribe(P1,P2,P3)
% A=[(P1-P3) (P1-P2)]';
% b=[0.5*A(1,:)*(P1+P3) ; 0.5*A(2,:)*(P2+P1)];
% c=A\b;
% temp=P1-c;
% r2=temp(1)^2+temp(2)^2;

% cen1=(P1+P2)/2;
% cen2=(P2+P3)/2;         
% 
% k1=-1/((P1(2)-P2(2))/(P1(1)-P2(1)));   
% b1=cen1(2)-k1*cen1(1);
% 
% k2=-1/((P2(2)-P3(2))/(P2(1)-P3(1)));    
% b2=cen2(2)-k2*cen2(1);
% 
% x0=-(b1-b2)/(k1-k2);             
% y0=-(-b2*k1+b1*k2)/(k1-k2);
% c=[x0; y0];
% 
% temp=P1-c;
% r2=temp(1)^2+temp(2)^2;