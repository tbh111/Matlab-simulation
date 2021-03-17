%本程序用于判别所给数据源在置信率为0.05时的概率分布形式。A的形式为n×1。
function f=p_judge(A,alpha)
[mu,sigma]=normfit(A);
p1=normcdf(A,mu,sigma);
[H1,s1]=kstest(A,[A,p1],alpha);
n=length(A);
if H1==0
    disp('该数据源服从正态分布。')
else
    disp('该数据源不服从正态分布。')
end
phat=gamfit(A,alpha);
p2=gamcdf(A,phat(1),phat(2));
[H2,s2]=kstest(A,[A,p2],alpha)
if H2==0
    disp('该数据源服从γ分布。')
else
    disp('该数据源不服从γ分布。')
end
lamda=poissfit(A,alpha);
p3=poisscdf(A,lamda);
[H3,s3]=kstest(A,[A,p3],alpha)
if H3==0
    disp('该数据源服从泊松分布。')
else
    disp('该数据源不服从泊松分布。')
end
mu=expfit(A,alpha);
p4=expcdf(A,mu);
[H4,s4]=kstest(A,[A,p4],alpha)
if H4==0
    disp('该数据源服从指数分布。')
else
    disp('该数据源不服从指数分布。')
end
[phat,pci] = raylfit(A, alpha);
p5=raylcdf(A,phat);
[H5,s5]=kstest(A,[A,p5],alpha)
if H5==0
    disp('该数据源服从rayleigh分布。')
else
    disp('该数据源不服从rayleigh分布。')
end

[ahat, bhat] = unifit(A, alpha);
p6=unifcdf(A,ahat,bhat);
[H6,s6]=kstest(A,[A,p6],alpha)
if H6==0
    disp('该数据源服从均匀分布。')
else
    disp('该数据源不服从均匀分布。')
end