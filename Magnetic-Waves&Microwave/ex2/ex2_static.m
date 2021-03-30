%% ���
clc
clear
close all
%% ��ʼ��
u0 = 4*pi*10.^(-7);
e0 = 1/(36*pi)*10^(-9);
u1 = u0;
e1 = e0;
omiga = 2*pi*10^(3);
k1 = omiga *sqrt(u1*e1);
eta1 = sqrt(u1/e1);
Ei0 = 1;
%% ���
%% ���
n=2;
figure(1),hold on
lambda1 = 2*pi/k1;
z = -n*lambda1:lambda1/100:0;
%�糡  ��� פ��
for t = 0:0.00001:0.001
    E1 = 2*Ei0* sin(k1*z).*sin(omiga*t);
    plot(z,E1);
    axis([-n*lambda1,0,-inf,inf])
    title('�糡�ڵ������Ĳ���,���')
end
%�ų� ��� פ��
figure(2),hold on
for t = 0:0.00001:0.001
    H1 = 2*Ei0/eta1* cos(k1*z).*cos(omiga*t);
    plot(z,H1);
    axis([-n*lambda1,0,-inf,inf])
    title('�ų��ڵ������Ĳ���,���')
end
%% ��̬
figure(3)
lambda1 = 2*pi/k1;
z = -n*lambda1:lambda1/100:0;
zero=0*ones(size(z));
for t = 0:0.00001:0.01
    E1 = 2*Ei0*sin(k1*z).*sin(omiga*t);
    H1 = 2*Ei0/eta1*cos(k1*z).*cos(omiga*t);
    %�糡
    q1 = quiver3(z,zero,zero,zero,zero,E1,'-R');
    set(q1,'ShowArrowHead','off');
    hold on;
    %�ų�
    q2 = quiver3(z,zero,zero,zero,H1,zero,'-B');
    set(q2,'ShowArrowHead','off');
    hold off;
    pause(0.0001);
end
