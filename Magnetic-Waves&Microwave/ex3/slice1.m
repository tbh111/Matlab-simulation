%% 清空环境
clear
clc
close all
%% 初始参数
a = 22.86/1000;
b = 10.16/1000;
vc = 299792458;
d = 15;
H0 = 1;
f = 9.375*10^9;
omega = 2*pi*f;
u = 4*pi*10^(-7);
t = 0;
%% 计算数据并显示
lambda_c = 2*a;           %TE10截止波长
lambda_0 = vc/f;      %工作波长
x = a/2;
z = 0:lambda_0/d:a;
if(lambda_0 > lambda_c)
    return;
else
    c = lambda_0/sqrt(1-(lambda_0/lambda_c)^2);
    beta = 2*pi/c;
    figure

	t = 0.0001;
    ey = omega.*u.*a.*H0.*sin(pi./a.*x).*cos(omega*t-beta.*z-pi/2)./pi;
    hold on
    plot(z,ey);
    pause(0.1)

end