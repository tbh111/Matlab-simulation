% �������ڵ糡3ά�ֲ�
% BJ-100
% ���a��22.86mm
% խ��b��10.16mm
% ����Ƶ�� 9.375GHz
% aleko 2020.05.22

%% ��ջ���
clear
clc
close all
%% ��ʼ����
ao = 22.86;bo = 10.16;
d  = 15;H0 = 1;
f  = 9.375*10^9;
t=0;
% t=0:1:2 ;
%% �������ݲ���ʾ
%d     ��������
%t     tʱ�̵ĳ��ṹͼ
a=ao/1000;b=bo/1000;
lc=2*a;    %TE10��ֹƵ��
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
    quiver3(z1,x1,y1,ez,ex,ey,'r');title('�������ڵ糡�ֲ�ͼ')
    xlabel('���䷽��');ylabel('�������a');zlabel('����խ��b');
end