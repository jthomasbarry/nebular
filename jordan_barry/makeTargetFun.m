function [Map,Pts,ds]=makeTargetFun(file,incr)
% clear all
% close all
% %Map = imread('RabbitMap.gif');
% Map = imread('europe_blank.gif');
% 
% %Map = imread('ushams.png');
% %Map = reshape(Map(:,:,2),size(Map,1),size(Map,2));%%% Necessary for png
reg='(?<=\.)[^.]*$';
fileType=regexp(file,reg,'match');
ispng=0;
Map = imread(file);
%need to reshape data for png files but not for the gif file
if strcmp('png',fileType)
    Map = reshape(Map(:,:,2),size(Map,1),size(Map,2));
    ispng=1;
end


[Nx,Ny] = size(Map);
ip = 0;
Pts = zeros(2,ceil(Nx/incr)*ceil(Ny/incr));
for ii = 1:incr:Nx
    for jj = 1:incr:Ny
        if ~ispng
            if (Map(ii,jj) >30)|(Map(ii,jj)<29) %%% For europe map
                ip=ip+1;
                Pts(:,ip)=[jj ii];
            end
        else
            if Map(ii,jj) < 10 % For ushams    
                ip = ip+1;
                Pts(:,ip) = [jj ii];
            end
        end
    end
end
Pts = Pts(:,1:ip);
Pts(2,:) = max(Pts(2,:)) - Pts(2,:);
ds=1/max(max(Pts));
Pts = Pts * ds;
%plot(Pts(1,1:ip),Pts(2,1:ip),'r.')
            
end