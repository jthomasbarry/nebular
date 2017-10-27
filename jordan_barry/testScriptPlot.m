clear all
close all
testScriptData=load('testScriptData28-Apr-2016.csv');
nrep = 1;
ndif = 5;
ndens = 5;
nsens = 5;
Q = reshape(testScriptData,nrep*ndif,ndens*nsens,[]);
Q = mean(Q);
Q = reshape(Q,ndens*nsens,[]);
X = log10(Q(1:ndens:end,1));
Y = Q(1:1:ndens,3);

h=figure(1);
Z = reshape((Q(:,1)-Q(:,2))./Q(:,1),length(X),length(Y));
surf(X,Y,Z)
title('Percentage reduction in sensor number')
xlabel('log_{10}(sensor number)')
ylabel('initial coverage density')
axis([1 4 .25 1.25 0 .7]) 

figure(2)
Z = reshape(Q(:,3).*Q(:,2)./Q(:,1),length(X),length(Y));
surf(X,Y,Z)
title('Final coverage density')
xlabel('log_{10}(sensor number)')
ylabel('initial coverage density')

figure(3)
Z = reshape(log10(Q(:,6)),length(X),length(Y));
surf(X,Y,Z)
title('log_{10}(execution time)')
xlabel('log_{10}(sensor number)')
ylabel('initial coverage density')

% P = reshape(testScriptData,nrep*ndif,ndens*nsens,[]);
% P1 = sqrt((0.5/ndif)*(P(1:2:end,:,:)-P(2:2:end,:,:)).^2);
% P1 = reshape(P1,ndens*nsens,[]);
% 
% figure(4)
% Z = reshape(P1(:,2)./Q(:,2),length(X),length(Y));
% surf(X,Y,Z)
% title(' Rel. standard deviation in final number: same config.')
% xlabel('log_{10}(sensor number)')
% ylabel('initial coverage density')

% P2 = (P(1:2:end,:,:) + P(2:2:end,:,:))/2;
% P2 = std(P2);
% P2 = reshape(P2,ndens*nsens,[]);
% 
% figure(5)
% Z = reshape(P2(:,2)./Q(:,2),length(X),length(Y));
% surf(X,Y,Z)
% title('Rel. standard deviation in final number: diff. configs.')
% xlabel('log_{10}(sensor number)')
% ylabel('initial coverage density')
