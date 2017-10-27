classdef Target
    properties
        location
        dist2
        inDiam
        number
    end
    methods
        function obj=Target(num, radius2, location)
            obj.location=location;
            obj.number=num;
            obj.inDiam=cell(1,length(obj.location));%check diameter not radius.
            adj=zeros(length(obj.location));
            obj.dist2=zeros(length(obj.location));
            for i=1:length(obj.location)
                check=obj.location(:,i);
                for j=i+1:length(obj.location)% go from i+1 to length(location)
                    distance2=(check(1)-obj.location(1,j))^2+(check(2)-obj.location(2,j))^2;
                    if distance2<4*radius2;
                        adj(i,j)=1;
                    end
                    obj.dist2(i,j)=distance2;
                    obj.dist2(j,i)=distance2;
                    
                end
            end
            for i=1:length(adj)
                inVect=find(adj(i,:)==1);
                obj.inDiam{i}=inVect;
                %leave as empty cell if vector empty
            end
        end
    end
end