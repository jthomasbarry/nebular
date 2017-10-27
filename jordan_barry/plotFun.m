M=load('testScriptData28-Apr-2016.csv');
x=[10,56,316,1778,10000];
y=[0.25,0.5,0.75,1,1.25];


leng=size(M,1);
its=M(:,6);

s=0;
i=1;
j=1;
for k=1:leng
    s=s+its(k);
    if mod(k,5)==0 
       a(i,j)=s/5;
       i=i+1;
       s=0;
    elseif i>5
        i=1;
        j=j+1;
        a(i,j)=s/5
        
        s=0;
    end
end

surf(log10(x),y,log10(a))
title('log_{10}(run time(in sec))')
xlabel('log_{10}(sensor number)')
ylabel('initial coverage density')