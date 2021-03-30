
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
    lambda1 = 2*pi/k1;
    z0 = -n*lambda1:lambda1/100:0;
    zero=0*ones(size(z0));
    %电场
    ww0=(exp(-k1*z0*i)+exp(k1*z0*i));
    ww2=(exp(-k1*z0*i)-exp(k1*z0*i));
    figure
    for t = 0:0.3/omiga:100/omiga
        %电场
        E10 = Ei0*abs(ww0).* cos(omiga*t+angle(ww0));
        H10 = Ei0/eta1*abs(ww2).* cos(omiga*t+angle(ww2));
        quiver3(z0,zero,zero,zero,zero,E10,'.R');
        hold on;
        %磁场
        quiver3(z0,zero,zero,zero,H10,zero,'.B');
        ti=title('电磁波垂直入射理想导体','color','k');
        set(ti,'fontsize',16);
        xlabel('电磁波传播方向','fontSize',12);
        ylabel('磁场变化方向','fontSize',12);
        zlabel('电场变化方向','fontSize',12);
        axis([ -n*lambda1,n*lambda1,-100000,100000,-50000,50000]);
        hold off;
        pause (0.001);
    end
