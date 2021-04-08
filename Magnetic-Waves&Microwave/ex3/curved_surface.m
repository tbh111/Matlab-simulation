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
t = 1;
%% 计算数据并显示
lambda_c = 2*a;           %TE10截止波长
lambda_0 = vc/f;      %工作波长
if(lambda_0 > lambda_c)
    return;
else
    x = 0:a/d:a;
    z = 0:lambda_0/d:lambda_0;
    y = z;
    [y1, z1] = meshgrid(y,z);
    c = lambda_0/sqrt(1-(lambda_0/lambda_c)^2);
    beta = 2*pi/c;
    ey = omega.*u.*a.*H0.*sin(pi./a.*x).*cos(omega*t-beta.*z1-pi/2)./pi;
    surf(y1,z1,ey)
end