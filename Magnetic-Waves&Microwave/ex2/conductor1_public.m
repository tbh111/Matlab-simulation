%真空垂直入射导体，合成波E1，H1
%静态
% aleko 2020.05.18
%% 清空
clc
clear
close all
% clf
%% 初始化
u0 = 4*pi*10.^(-7);
e0 = 1/(36*pi)*10^(-9);
u1 = u0;
e1 = e0;
omiga = 2*pi*10^(3);
k1 = omiga *sqrt(u1*e1);
eta1 = sqrt(u1/e1);
Ei0 = 1;
%% 描绘
%% 多次
n=2;
figure,hold on
lambda1 = 2*pi/k1;
z = -n*lambda1:lambda1/100:0;
%电场  多次 驻波
for t = 0:0.00001:0.001
    E1 = 2*Ei0* sin(k1*z).*sin(omiga*t);
    plot(z,E1);
    axis([ -n*lambda1,0,-inf,inf])
    title('电场在导体外侧的波形,多次')
end
%磁场 多次 驻波
figure,hold on
for t = 0:0.00001:0.001
    H1 = 2*Ei0/eta1* cos(k1*z).*cos(omiga*t);
    plot(z,H1);
    axis([ -n*lambda1,0,-inf,inf])
    title('磁场在导体外侧的波形,多次')
end
%% 单次
%电磁场 单次 合并
n=2;
figure,hold on
lambda1 = 2*pi/k1;
z = -n*lambda1:lambda1/100:0;
%电场  单次
t=0.1;
E1 = 2*Ei0* sin(k1*z).*sin(omiga*t);
plot(z,E1);
axis([ -n*lambda1,0,-inf,inf])
title('电场在导体外侧的波形 t=0.1s')
%磁场 单次
figure,hold on

H1 = 2*Ei0/eta1* cos(k1*z).*cos(omiga*t);
plot(z,H1);
axis([ -n*lambda1,0,-inf,inf])
title('磁场在导体外侧的波形 t=0.1s')

%% 单次 合并一张3维图
zero=0*ones(size(z));
figure
%% 描绘

%电场
quiver3(z,zero,zero,zero,zero,E1,'R');
hold on;
%磁场
quiver3(z,zero,zero,zero,H1,zero,'B');
ti=title(' 电磁波垂直入射理想导体','color','k');
set(ti,'fontsize',16);
xlabel(' 电磁波传播方向','fontSize',12);
ylabel(' 磁场变化方向','fontSize',12);
zlabel(' 电场变化方向','fontSize',12);

hold off;