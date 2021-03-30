function timer_sub()
    global t
    t = t+1;
    t1 = t*5*10^-6;
    disp(t)
% 初始化
    u0 = 4*pi*10.^(-7);
    e0 = 1/(36*pi)*10^(-9);
    u1 = u0;
    e1 = e0;
    omiga = 2*pi*10^(3);
    k1 = omiga *sqrt(u1*e1);
    eta1 = sqrt(u1/e1);
    Ei0 = 1;
    n=2;
%% 描绘
    lambda1 = 2*pi/k1;
    z = -n*lambda1:lambda1/1000:0;
    zero=0*ones(size(z));
    E1 = 2*Ei0*sin(k1*z).*sin(omiga*t1);
    H1 = 2*Ei0/eta1*cos(k1*z).*sin(omiga*t1);
    figure(1),hold on
    plot(z,E1);
    axis([-n*lambda1,0,-inf,inf])
    title('电场在导体外侧的波形,多次')
    
    figure(2),hold on
    plot(z,H1);
    axis([-n*lambda1,0,-inf,inf])
    title('磁场在导体外侧的波形,多次')
    
    %电场
    figure(3)
    q1 = quiver3(z,zero,zero,zero,zero,E1,'-R');
    set(q1,'ShowArrowHead','off');
    hold on;
    %磁场
    q2 = quiver3(z,zero,zero,zero,H1,zero,'-B');
    set(q2,'ShowArrowHead','off');
    hold off;

end