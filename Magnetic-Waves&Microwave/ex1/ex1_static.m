%% �?空�??�?
clear
clc
close all
%% ??�?????
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
%% 建�??仿�????
for t=0:1/(3*w):10000/w
    E=E0*one.*cos(w*t-k*x);
    disp(E(1:9));
    H=E0*n*one.*cos(w*t-k*x);
%% ??�?
    %?��??
    q1 = quiver3(x,zero,zero,zero,zero,E,'-R');
    set(q1,'ShowArrowHead','off');
    hold on;
    %�???
    q2 = quiver3(x,zero,zero,zero,H,zero,'-B');
    set(q2,'ShowArrowHead','off');
    ti=title(' ?��?波�?��???��?质中�???','color','k');
    set(ti,'fontsize',16);
    xlabel(' ?��?�?�????��??','fontSize',12);
    ylabel(' �??��?????��??','fontSize',12);
    zlabel(' ?��?��?????��??','fontSize',12);
%     axis([0,25,-0.8,0.8,-0.8,0.8]);
    hold off;
    pause(0.05)
end