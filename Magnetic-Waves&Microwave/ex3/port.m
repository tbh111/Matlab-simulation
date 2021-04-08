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
u=4*pi*10^(-7);
t = 0;
%% 计算数据并显示
lambda_c = 2*a;           %TE10截止波长
lambda_0 = vc/f;      %工作波长
if(lambda_0 > lambda_c)
    return;
else
    c = lambda_0/sqrt(1-(lambda_0/lambda_c)^2);
    beta = 2*pi/c;
    x = 0:a/d:a;
    y = 0:b/d:b;
    z = 0;
    [x1,y1]= meshgrid(x,y);
    ex = zeros(size(x1));
    ez = ex;
    ey = omega.*u.*a.*H0.*sin(pi./a.*x1).*cos(omega*t-beta.*z-pi/2)./pi;
    figure
    q1 = quiver(x1,y1,ex,ey,'r');
    hx = beta.*a.*H0.*sin(pi.*x1./a).*cos(omega*t-beta.*z+pi/2)./pi;
    hy = ex;
    hold on
    q2 = quiver(x1,y1,hx,hy,'b');
end