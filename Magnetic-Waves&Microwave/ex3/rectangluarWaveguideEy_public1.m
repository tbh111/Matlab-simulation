% 波导管内电场3维分布
% BJ-100
% 宽边a：22.86mm
% 窄边b：10.16mm
% 入射频率 9.375GHz
% aleko 2020.05.22

%% 清空环境
clear
clc
close all
%% 初始参数
ao = 22.86;bo = 10.16;
d  = 15;H0 = 1;
f  = 9.375*10^9;
t=0;
% t=0:1:2 ;
%% 计算数据并显示
%d     采样精度
%t     t时刻的场结构图
a=ao/1000;b=bo/1000;
lc=2*a;    %TE10截止频率
l0=(3*10^8)/f;
u=4*pi*10^(-7);
if(l0>lc)
    return;
else
    lg=l0/((1-(l0/lc)^2)^0.5)
    c=lg;
    B=2*pi/lg;   w=2*pi*(3*10^8);
    x=0:a/d:a;y=0:b/d:b;z=0:c/d:c;
    [x1,y1,z1]=meshgrid(x,y,z);
    ex=zeros(size(x1));ez=ex;
    ey=w.*u.*a.*H0.*sin(pi./a.*x1).*sin(w*t-B.*z1)./pi;
    quiver3(z1,x1,y1,ez,ex,ey,'r');title('波导管内电场分布图')
    xlabel('传输方向');ylabel('波导宽边a');zlabel('波导窄边b');
end