%��մ�ֱ���䵼�壬�ϳɲ�E1��H1
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
u1 = u0;
e1 = e0;
omiga = 2*pi*10^(3);
k1 = omiga *sqrt(u1*e1);
eta1 = sqrt(u1/e1);
Ei0 = 1;
%% ���
%% ���
n=2;
figure,hold on
lambda1 = 2*pi/k1;
z = -n*lambda1:lambda1/100:0;
%�糡  ��� פ��
for t = 0:0.00001:0.001
    E1 = 2*Ei0* sin(k1*z).*sin(omiga*t);
    plot(z,E1);
    axis([ -n*lambda1,0,-inf,inf])
    title('�糡�ڵ������Ĳ���,���')
end
%�ų� ��� פ��
figure,hold on
for t = 0:0.00001:0.001
    H1 = 2*Ei0/eta1* cos(k1*z).*cos(omiga*t);
    plot(z,H1);
    axis([ -n*lambda1,0,-inf,inf])
    title('�ų��ڵ������Ĳ���,���')
end
%% ����
%��ų� ���� �ϲ�
n=2;
figure,hold on
lambda1 = 2*pi/k1;
z = -n*lambda1:lambda1/100:0;
%�糡  ����
t=0.1;
E1 = 2*Ei0* sin(k1*z).*sin(omiga*t);
plot(z,E1);
axis([ -n*lambda1,0,-inf,inf])
title('�糡�ڵ������Ĳ��� t=0.1s')
%�ų� ����
figure,hold on

H1 = 2*Ei0/eta1* cos(k1*z).*cos(omiga*t);
plot(z,H1);
axis([ -n*lambda1,0,-inf,inf])
title('�ų��ڵ������Ĳ��� t=0.1s')

%% ���� �ϲ�һ��3άͼ
zero=0*ones(size(z));
figure
%% ���

%�糡
quiver3(z,zero,zero,zero,zero,E1,'R');
hold on;
%�ų�
quiver3(z,zero,zero,zero,H1,zero,'B');
ti=title(' ��Ų���ֱ�������뵼��','color','k');
set(ti,'fontsize',16);
xlabel(' ��Ų���������','fontSize',12);
ylabel(' �ų��仯����','fontSize',12);
zlabel(' �糡�仯����','fontSize',12);

hold off;