function [sensorNumber, t, numIt, sensor]=sensorFunction(numberOfTargets, regionSize, targetLocation, radius2)
tic;
numItBest=20;
%this program computes sensor locations for a (possibly) sub-optimal
%covering given some target locations

%target is an object of Target class with initialization handled by
%constructor method.
target=Target(numberOfTargets, radius2, targetLocation);

%sensor is an object of Sensor class with initialization handled by
%constructor method.
sensor=Sensor(target, radius2);

%set iterations to one on each run through the function.
numIt=1;

%square of samll positive number used for merging
%eps2=0.5;

%this is a dampening coefficient used in computing acceleration. should be
%a number between 0 and 1. 0.5 seems to work well enough in most cases.
k=.5;

valid=1;
%loop through iterations to compute location. In most cases 20 seems like a
%good amount of iterations.
%%%uncomment to view plots leave comment for benchmarking
%makePlot2(sensor.location, target.location,sensor.squareRadius, sensor.coveringTarget, 1)
while valid 
    tmpi = max(numIt-1,1);
    sensor.explodeProb=0.07*exp(-mod(numIt,ceil(10*log10(sensor.number(tmpi))))/log10(sensor.number(tmpi)));
    % every 20 iterations we change epsilon to catch as many sensors as
    % possible. I have graphed this and it is potentially much more
    % efficient.
    if mod(numIt, 25)==0
        eps2=4*sensor.squareRadius;
    else 
        eps2=0.0625*sensor.squareRadius;
    end
    
    %newMerge function merges sensors that can merge. Input is sensor and
    %targeg objects and squared epsilon number. Output is the new updated
    %sensor object.
    sensor=newMerge(sensor, target, eps2);
    
    %getSecDeriv used to compute acceleration. Input k coefficient and target
    %and sensor objects. Output is the updated sensor object.
    sensor=getSecDeriv(k,target, sensor);
    
    %euler2 is a simple function that uses an euler method for differential
    %equation solutions. Input sensor object and output is the updated sensor
    %object
    sensor=euler2(sensor);
    
    %doubleCheck is used as a way to ensure that the sensors don't move
    %away from the targets they are covering.
    sensor=doubleCheck(sensor, target);
    
    %checkDist recomputes the square distance between sensors.
    %sensor=checkDist(target, sensor);
    
    %sums up all the sensors.
    a=sum(sensor.coveringTarget,2);
    
         %debug
   indsCheck= sum(sensor.coveringTarget,2)==0;
   sensorsCheck=sensor.location(1,indsCheck);
   if ~all(isnan(sensorsCheck))
       keyboard()
   end
    
    %explode sensors with small probability
      [sensor, flag]=sensorExplode(sensor, target);
      if flag
          a=sum(sensor.coveringTarget,2);
      end
%     
     %debug
   indsCheck= sum(sensor.coveringTarget,2)==0;
   sensorsCheck=sensor.location(1,indsCheck);
   if ~all(isnan(sensorsCheck))
       keyboard()
   end
     
    sensor.number(numIt)=length(find(full(a)>0));
    
    if sensor.number(numIt)<sensor.leastNum
        sensor.leastNum=sensor.number(numIt);
        numItBest=numIt;
        sensor.leastLocation=sensor.location;
        sensor.leastCovering=sensor.coveringTarget;
    end

    if numIt-numItBest>100
       break
    end
    
    
    
%%%comment out for benchmarking     
%makePlot2(sensor.location, target.location, sensor.squareRadius, sensor.coveringTarget, 1)
%pause(0.25)
    numIt=numIt+1;
end
%vectorized and sorted low to high
sensor=checkDoubleCoverage(sensor, target);
%now we should recheck the numbers and positions
if sensor.number(numIt)<sensor.leastNum
    sensor.leastNum=sensor.number(numIt);
    sensor.leastLocation=sensor.location;
    sensor.leastCovering=sensor.coveringTarget;
end
%for loops additive 
%sensor=checkDoubleCoverage2(sensor, target);
%makePlot2 is a plot function for visualization. Comment this out when
%running performance tests or uncomment when you need to visualize the
%solutions.
%makePlot2(sensor.location, target.location, sensor.squareRadius, sensor.coveringTarget)

sensorNumber=sensor.leastNum; %sensor.number(numIt);
t=toc;
end
