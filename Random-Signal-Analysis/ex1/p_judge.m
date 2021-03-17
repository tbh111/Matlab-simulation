%�����������б���������Դ��������Ϊ0.05ʱ�ĸ��ʷֲ���ʽ��A����ʽΪn��1��
function f=p_judge(A,alpha)
[mu,sigma]=normfit(A);
p1=normcdf(A,mu,sigma);
[H1,s1]=kstest(A,[A,p1],alpha);
n=length(A);
if H1==0
    disp('������Դ������̬�ֲ���')
else
    disp('������Դ��������̬�ֲ���')
end
phat=gamfit(A,alpha);
p2=gamcdf(A,phat(1),phat(2));
[H2,s2]=kstest(A,[A,p2],alpha)
if H2==0
    disp('������Դ���Ӧ÷ֲ���')
else
    disp('������Դ�����Ӧ÷ֲ���')
end
lamda=poissfit(A,alpha);
p3=poisscdf(A,lamda);
[H3,s3]=kstest(A,[A,p3],alpha)
if H3==0
    disp('������Դ���Ӳ��ɷֲ���')
else
    disp('������Դ�����Ӳ��ɷֲ���')
end
mu=expfit(A,alpha);
p4=expcdf(A,mu);
[H4,s4]=kstest(A,[A,p4],alpha)
if H4==0
    disp('������Դ����ָ���ֲ���')
else
    disp('������Դ������ָ���ֲ���')
end
[phat,pci] = raylfit(A, alpha);
p5=raylcdf(A,phat);
[H5,s5]=kstest(A,[A,p5],alpha)
if H5==0
    disp('������Դ����rayleigh�ֲ���')
else
    disp('������Դ������rayleigh�ֲ���')
end

[ahat, bhat] = unifit(A, alpha);
p6=unifcdf(A,ahat,bhat);
[H6,s6]=kstest(A,[A,p6],alpha)
if H6==0
    disp('������Դ���Ӿ��ȷֲ���')
else
    disp('������Դ�����Ӿ��ȷֲ���')
end