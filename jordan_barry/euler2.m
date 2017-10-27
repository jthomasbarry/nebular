function [obj]=euler2(obj)
dt=obj.deltat;
obj.velocity=[obj.velocity]+[obj.acceleration].*dt;
%sub-routine for checking v
obj.location=[obj.location]+[obj.velocity].*dt;
end
