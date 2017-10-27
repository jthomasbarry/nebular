function [center, radius2]=minDisk(target)
n=size(target,2);
R=[];
r=0;
C=[];
target(:,randperm(size(target,2)));%random permutation of targets
[center, radius2,C]=minDiskRecur(target, n, R, r, C);
end


