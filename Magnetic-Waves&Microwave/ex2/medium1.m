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
u2 = u0;
e1 = e0*2;
e2 = e0*20;
omiga = 2*pi*10^(3);
k1 = omiga*sqrt(u1*e1);
k2 = omiga*sqrt(u2*e2);
eta1 = sqrt(u1/e1);
eta2 = sqrt(u2/e2);
Ei0 = 1;
n=2;
% t1 = t*0.5/omiga;
R=(eta2-eta1)/(eta2+eta1);
T=(2*eta2)/(eta2+eta1);
%% 描绘
%% 多次
n=2;
figure,hold on
lambda1 = 2*pi/k1;
z0 = -n*lambda1:lambda1/100:0;
z1 = lambda1/100:lambda1/100:n*lambda1+lambda1/100;
z = [z0 z1];
%电场  多次 驻波
for t = 0:0.00001:0.001
    v_E1 = exp(-1i*k1*z0)+R*exp(1i*k1*z0);
    E1 = Ei0*abs(v_E1).*cos(omiga*t+angle(v_E1));
    v_E2 = Ei0*exp(-1i*k2*z1);
    E2 = T*abs(v_E2).*cos(omiga*t+angle(v_E2));
    E = [E1 E2];
    plot(z,E);
    axis([ -n*lambda1,n*lambda1,-inf,inf])
    title('电场在介质两侧的波形,多次')
end
%磁场 多次 驻波
figure,hold on
for t = 0:0.00001:0.001
    v_H1 = (exp(-1i*k1*z0)-R*exp(1i*k1*z0));
    H1 = Ei0/eta1*abs(v_H1).*cos(omiga*t+angle(v_H1));
    v_H2 = exp(-1i*k2*z1);
    H2 = T*Ei0/eta2*abs(v_H2).*cos(omiga*t+angle(v_H2));
    H = [H1 H2];
    plot(z,H);
    axis([ -n*lambda1,n*lambda1,-inf,inf])
    title('磁场在介质两侧的波形,多次')
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