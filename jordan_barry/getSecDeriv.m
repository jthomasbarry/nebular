  function [sensor]=getSecDeriv(k, target, sensor)
  leng=length(sensor.location);
  
  %set acceleration equal to zero
  sensor.acceleration=zeros(2,leng);
  for i=1:leng
    inDiam=target.inDiam{i};
    x_i=sensor.location(:,i);
    
    %initialize xsum to zero for accumulation.
    xSum=zeros(2,1);
    if ~isnan(x_i(1))  
      for j=1:length(inDiam)%compute length in other function
          col=inDiam(j);
          x_j=sensor.location(:,col);
          if ~isnan(x_j(1)) && full(sensor.coveringTarget(i,col))==0 %&& x_i~=x_j
            dif=x_i-x_j;
            difSquared=dif'*dif;%%% + 1e-7;%%%%% I don't understand why this is 0 sometimes
              if any(difSquared ==0)
                keyboard()
              end
            xSum=xSum+(x_j-x_i)./difSquared; %maybe cubed?           
          end
      end
    end
    sensor.acceleration(:,i)=xSum-k*sensor.velocity(:,i); 
  end
end
      