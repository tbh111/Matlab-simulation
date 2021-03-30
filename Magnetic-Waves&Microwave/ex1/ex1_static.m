%% æ¸?ç©ºç??å¢?
clear
clc
close all
%% ??å§?????
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
%% å»ºç??ä»¿ç????
for t=0:1/(3*w):10000/w
    E=E0*one.*cos(w*t-k*x);
    disp(E(1:9));
    H=E0*n*one.*cos(w*t-k*x);
%% ??ç»?
    %?µå??
    q1 = quiver3(x,zero,zero,zero,zero,E,'-R');
    set(q1,'ShowArrowHead','off');
    hold on;
    %ç£???
    q2 = quiver3(x,zero,zero,zero,H,zero,'-B');
    set(q2,'ShowArrowHead','off');
    ti=title(' ?µç?æ³¢å?¨ç???³ä?è´¨ä¸­ä¼???','color','k');
    set(ti,'fontsize',16);
    xlabel(' ?µç?æ³?ä¼????¹å??','fontSize',12);
    ylabel(' ç£??ºå?????¹å??','fontSize',12);
    zlabel(' ?µå?ºå?????¹å??','fontSize',12);
%     axis([0,25,-0.8,0.8,-0.8,0.8]);
    hold off;
    pause(0.05)
end