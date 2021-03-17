function [s1] = rnd2(mn,a,num) %中心极限法
n=12;
x1=rand(n,num);
s=zeros(1,num);

for i=1:num
    for j=1:n
        s(i)=s(i)+x1(j,i);
    end
    s(i)=sqrt(12/n)*(s(i)-n/2);
end

s1=zeros(1,num);
for k=1:num
    s1(k)=a*s(k)+mn;
end