function [s1,s2]=rnd1(m1,m2,v1,v2,num) %±ä»»·¨
x1=rand(1,num);
x2=rand(1,num);

y1=sqrt(-2*log(x1)).*cos(2*pi*x2);
y2=sqrt(-2*log(x1)).*sin(2*pi*x2);

s1=v1*y1+m1;
s2=v2*y2+m2;

h=hist(s1)/max(hist(s1));
hist(s1,100)