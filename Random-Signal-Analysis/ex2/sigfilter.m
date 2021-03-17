function [sig_edge] = sigfilter(yt, Fs) %对信号进行滤波操作

dt=1/Fs; %采样时间
N=length(yt); %采样点数
y=fft(yt); %fft变换
% figure
% subplot(1,2,1),plot([0:N-1]/Fs,yt);
% xlabel('时间/s'),title('时间域');
% 
% 
% subplot(1,2,2),plot([0:N-1]/(N*dt),abs(y)*2/N);
% xlabel('频率/kHz'),title('幅频图');
% ylabel('振幅');

f1=695; %带通滤波器频率
f2=1480;
yy=zeros(1,length(y));
for m=0:N-1   %将频率落在该频率范围及其大于Nyquist频率的波滤去
   if(m/(N*dt)<f1||m/(N*dt)>f2)...   %小于Nyquist频率的滤波范围
   ||(m/(N*dt)<(1/dt-f2)&&m/(N*dt)>(1/dt-f1))  %大于Nyquist频率的滤波范围
%1/dt为一个频率周期
      yy(m+1)=0.0;       %置在此频率范围内的振动振幅为零
   else
      yy(m+1)=y(m+1);     %其余频率范围的振动振幅不变
   end
end
% 
% plot(handles.fft_show,[0:N-1]/(N*dt),abs(yy)*2/N)
% 
% set(handles.fft_show,'xlim',[0 2000]);
ifft_yy = real(ifft(yy)); %ifft变换还原时域信号
% figure,plot([0:N-1]/Fs,real(ifft_yy))
% title('通过IFFT回到时间域');
% xlabel('时间/s');
maxy = max(ifft_yy); %信号最大幅值
for i=1:length(ifft_yy)
    if(ifft_yy(i)>0 && ifft_yy(i) <= maxy*0.20) || (ifft_yy(i)<0 && ifft_yy(i) >= -maxy*0.20) %将幅值低于0.2倍maxy的信号置0
        ifft_yy(i) = 0.0;
    end
end
% figure
% plot([0:N-1]/Fs,ifft_yy)
% sound(ifft_yy,Fs)
% find(ifft_yy(1:length(ifft_yy))~=0)
% plot(handles.sig_show,ifft_yy)

es = ifft_yy.^2; %信号能量
% plot(handles.sig_show,es)
% set(handles.text7,'String','energy');
threshold = 10^-6; %信号能量阈值
flag = zeros(1,length(ifft_yy));

flag(find(es>threshold)) = 1; %将大于阈值信号置1
flag(find(es<=threshold)) = 0; %反之置0
% figure
% plot(flag)
% title('flag')
% axis([-inf,inf,0,2])
sig = find(flag==1); %得到为1的信号的位置
left = [sig(1)];
right = [];

for i=1:length(sig)-1
    if(sig(i+1)-sig(i) >= 2000) %滤去两点之间间隔小于2000点的信号
        right = [right sig(i)]; 
        left = [left sig(i+1)];
    end
end
right = [right sig(end)];
sig_edge = [left;right];
if(size(sig_edge,2) > 1)
    tmp_edge = [];
    for j=1:length(sig_edge)
        if (sig_edge(2,j)-sig_edge(1,j)) > 2000 %再次滤去两点之间间隔小于2000点的信号
            tmp_edge = [tmp_edge sig_edge(:,j)];
        end
    end
    sig_edge = tmp_edge;
end