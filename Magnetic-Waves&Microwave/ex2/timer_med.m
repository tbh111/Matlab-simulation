function timer_med()
    global t
    t = t+1;

% 初始化
    u0 = 4*pi*10.^(-7);
    e0 = 1/(36*pi)*10^(-9);
    u1 = u0;
    u2 = u0;
    e1 = e0*2;
    e2 = e0*20;
    omiga = 2*pi*10^(3);
    k1 = omiga*sqrt(u1*e1);
    k2 = omiga*sqrt(u2*e2);
    eta1 = sqrt(u1/e1);
    eta2 = sqrt(u2/e2);
    Ei0 = 1;
    n=2;
    t1 = t*0.5/omiga;
    R=(eta2-eta1)/(eta2+eta1);
    T=(2*eta2)/(eta2+eta1);
%% 描绘
    lambda1 = 2*pi/k1;
    z0 = -n*lambda1:lambda1/1000:0;
    z1 = lambda1/1000:lambda1/1000:n*lambda1+lambda1/1000;
    z = [z0 z1];
    zero = 0*ones(size(z));
    t1 = t1*ones(size(z0));
%     E1 = 2*Ei0*sin(k1*z).*sin(omiga*t1);
    v_E1 = exp(-1i*k1*z0)+R*exp(1i*k1*z0);
    E1 = Ei0*abs(v_E1).*cos(omiga*t1+angle(v_E1));
    v_E2 = Ei0*exp(-1i*k2*z1);
    E2 = T*abs(v_E2).*cos(omiga*t1+angle(v_E2));
%     H1 = 2*Ei0/eta1*cos(k1*z).*cos(omiga*t1);
    v_H1 = (exp(-1i*k1*z0)-R*exp(1i*k1*z0));
    H1 = Ei0/eta1*abs(v_H1).*cos(omiga*t1+angle(v_H1));
    v_H2 = exp(-1i*k2*z1);
    H2 = T*Ei0/eta2*abs(v_H2).*cos(omiga*t1+angle(v_H2));
    E = [E1 E2];
    H = [H1 H2];
    figure(1)
    plot(z,E);
    axis([-n*lambda1,n*lambda1,-2*Ei0,2*Ei0])
    title('电场在导体外侧的波形,多次')
    
    figure(2)
    plot(z,H);
    axis([-n*lambda1,n*lambda1,-2*Ei0/eta1,2*Ei0/eta1])
    title('磁场在导体外侧的波形,多次')
    %电场
    figure(3)
    q1 = quiver3(z,zero,zero,zero,zero,E,'-R');
    set(q1,'ShowArrowHead','off');
    hold on;
    %磁场
    q2 = quiver3(z,zero,zero,zero,H,zero,'-B');

    set(q2,'ShowArrowHead','off');
    hold off;

end