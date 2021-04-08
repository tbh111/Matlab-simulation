%BJ-100�������ṹ��������
%��̬
% aleko 2020.05.18
%% ���
clc
clear
close all
% clf
%% ��ʼ��
u0 = 4*pi*10.^(-7);
e0 = 1/(36*pi)*10^(-9);
u = u0;
e = e0;
omiga = 2*pi*9.375*10^(9);
a = 22.86*10^(-3);
c = 299792458 ;
beta = omiga/c;
k = omiga *sqrt(u*e);
lambda = 2*pi*c/omiga;

H10 = 1;
%% ���
%% ���
figure,hold on

x = -a:lambda/10:0;
p=1;
for z =0: 0.001:0.1
    %�糡  ��� פ��
    for t = 0:0.0001:0.0001
        Ey = omiga*u*a/pi*H10* sin(pi*x/a).*cos(omiga*t-beta*z-pi/2);
        plot(x,Ey);
        axis([ -a,0,-inf,inf])
        title('������Eyǿ�Ȳ���,���')
        pause(0.05)
        hold on
    end
    pause(0.05)
    z;
    M(p) = max(abs(Ey));
    p=p+1;
end
figure,plot(M)
