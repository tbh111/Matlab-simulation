%% 清空环境
clear
clc
close all
%% 初始参数
grid on;
x = 0:0.01:5;
zero = 0*ones(size(x));
one = ones(size(x));

a = 0;
E0 = 20*sqrt(2);
w = 6*pi*10^8;
t = 3*10^-8*pi;
t = 0;
k = 2*pi;
n = 1/120;
%% 建立仿真量
for t=0:1/(3*w):10000/w
    E=E0*one.*cos(w*t-k*x);
    H=E0*n*one.*cos(w*t-k*x);
%% 描绘
    %电场
    q1 = quiver3(x,zero,zero,zero,zero,E,'-R');
    set(q1,'ShowArrowHead',0);
    hold on;
    %磁场
    q2 = quiver3(x,zero,zero,zero,H,zero,'-B');
    set(q2,'ShowArrowHead',0);
    ti=title(' 电磁波在理想介质中传播','color','k');
    set(ti,'fontsize',16);
    xlabel(' 电磁波传播方向','fontSize',12);
    ylabel(' 磁场变化方向','fontSize',12);
    zlabel(' 电场变化方向','fontSize',12);
%     axis([0,25,-0.8,0.8,-0.8,0.8]);
    hold off;
    pause(0.05)
end