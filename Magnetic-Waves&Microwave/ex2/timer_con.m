function timer_con()
    global t
    t = t+1;
% ��ʼ��
    u0 = 4*pi*10.^(-7);
    e0 = 1/(36*pi)*10^(-9);
    u1 = u0;
    e1 = e0;
    omiga = 2*pi*10^(3);
    k1 = omiga *sqrt(u1*e1);
    eta1 = sqrt(u1/e1);
    Ei0 = 1;
    n=2;
    t1 = t*0.5/omiga;
%% ���
    lambda1 = 2*pi/k1;
    z = -n*lambda1:lambda1/1000:0;
    zero = 0*ones(size(z));
    E1 = 2*Ei0*sin(k1*z).*sin(omiga*t1);
    disp(E1(1))
    H1 = 2*Ei0/eta1*cos(k1*z).*cos(omiga*t1);
    figure(1)
    plot(z,E1);
    axis([-n*lambda1,0,-2*Ei0,2*Ei0])
    title('�糡�ڵ������Ĳ���,���')
    
    figure(2)
    plot(z,H1);
    axis([-n*lambda1,0,-2*Ei0/eta1,2*Ei0/eta1])
    title('�ų��ڵ������Ĳ���,���')
    %�糡
    figure(3)
    q1 = quiver3(z,zero,zero,zero,zero,E1,'-R');
    set(q1,'ShowArrowHead','off');
    hold on;
    %�ų�
    q2 = quiver3(z,zero,zero,zero,H1,zero,'-B');

    set(q2,'ShowArrowHead','off');
    hold off;
end