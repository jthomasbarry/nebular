function makePlot2(sensor, target, radius2,isCovered, index)
  radius=sqrt(radius2);
  check=any(~isnan(sensor));
  indeces=find(check==1);
  theta=0:pi/200:2*pi;
  x=radius*cos(theta);
  y=radius*sin(theta);
%    npts = size(target,2);
%    color = zeros(1,npts);
%    for jj = 1:npts
%        color(jj) = find(full(isCovered(:,jj)));
%    end
   
  %plot the circles with loop
  %figure(index)
  hold off
  plot(target(1,:),target(2,:),'r.')
  axis square
  hold on
  sensorx=sensor(1,:);
  sensory=sensor(2,:);
  for i=indeces
    plot(x+sensorx(i),y+sensory(i))
  end
  
 end