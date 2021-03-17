function varargout = test_gui(varargin)
% TEST_GUI MATLAB code for test_gui.fig
%      TEST_GUI, by itself, creates a new TEST_GUI or raises the existing
%      singleton*.
%
%      H = TEST_GUI returns the handle to a new TEST_GUI or the handle to
%      the existing singleton*.
%
%      TEST_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_GUI.M with the given input arguments.
%
%      TEST_GUI('Property','Value',...) creates a new TEST_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test_gui

% Last Modified by GUIDE v2.5 03-May-2020 22:16:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @test_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before test_gui is made visible.
function test_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test_gui (see VARARGIN)

% Choose default command line output for test_gui
handles.output = hObject;
% global T;
handles.numsig = [];
handles.dir = './';
set(handles.text7,'String','amplitude');
set(handles.text9,'String','frequency');
global count;
count = 0;
% T = timer('TimerFcn',{@draw_sig,handles},'Period',0.1,'ExecutionMode','fixedRate');
% start(T);
% handles.numshow = [];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in num1.
function num1_Callback(hObject, eventdata, handles)
% hObject    handle to num1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count; %定义全局变量count用于在gui中显示当前是第几个信号
t1 = [1:410]; %410个采样点
% t1 = linspace(0,1,410);
x =sin(2*pi*697*t1/8192)+sin(2*pi*1209*t1/8192); % 拨号音为1的信号
sound(x,8192); %播放信号

space = zeros(1,410); %410点静音信号
phone = [x,space]; %将拨号音和静音信号拼接成一个完整的拨号信号
handles.numsig = [handles.numsig,phone]; %在储存所有接收到信号的数组末尾添加当前信号
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1); %调用拨号音识别函数read_number, result为识别到的数字
num = [get(handles.num_show,'string'),result]; %获得当前识别到的号码并在末尾添加当前的数字
set(handles.num_show,'string',num); %更新gui中号码显示区域
count = count+1; %识别到的信号数+1
t = linspace(count,count+1,820); %创建数组作为绘图的横坐标
p = plot(handles.sig_show,t,handles.numsig(end-819:end),'-r','MarkerSize',5); %画出幅度图
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5); %画出频谱图
guidata(hObject, handles); %更新句柄

% --- Executes on button press in num2.
function num2_Callback(hObject, eventdata, handles)
% hObject    handle to num2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
% t2 = linspace(0,1,410);
t2 = [1:410];
x =sin(2*pi*697*t2/8192)+sin(2*pi*1336*t2/8192);
sound(x,8192);
count = count+1;
space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
[result,w,a1] = read_number(x,8192,1);
% sound(d1,Fs);

num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in num3.
function num3_Callback(hObject, eventdata, handles)
% hObject    handle to num3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
count = count+1;
% t3 = linspace(0,1,410);
t3 = [1:410];
x =sin(2*pi*697*t3/8192)+sin(2*pi*1477*t3/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in num4.
function num4_Callback(hObject, eventdata, handles)
% hObject    handle to num4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
count = count+1;
% t4 = linspace(0,1,410);
t4 = [1:410];
x =sin(2*pi*770*t4/8192)+sin(2*pi*1209*t4/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in num5.
function num5_Callback(hObject, eventdata, handles)
% hObject    handle to num5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
count = count+1;
t5 = [1:410];
% t5 = linspace(0,1,410);
x =sin(2*pi*770*t5/8192)+sin(2*pi*1336*t5/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in num9.
function num9_Callback(hObject, eventdata, handles)
% hObject    handle to num9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
count = count+1;
% t9 = linspace(0,1,410);
t9 = [1:410];
x =sin(2*pi*852*t9/8192)+sin(2*pi*1477*t9/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in del.
function del_Callback(hObject, eventdata, handles)
% hObject    handle to del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 删除功能部分
global count;

if (count <= 1) %若当前只有一个信号 将储存信号的数组置为空 若不判断下面的代码会出现错误
    numsig = [];
    count = 0;
    t = linspace(count,count+1,820);
    p = plot(t,0,'-r','MarkerSize',5);
    q = plot(handles.fft_show,0,0,'-r','MarkerSize',5);
else
    count = count-1; %总数-1
    handles.numsig = handles.numsig(1:end-820); %将数组最后820个点删除
    t = linspace(count,count+1,820);
    [result,w,a1] = read_number(handles.numsig(end-819:end),8192,1); %识别上一个信号的数字并显示
    p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
    q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
end
num = get(handles.num_show,'string'); %获得当前识别数字
L = length(num);
num_del = strrep(num,num,num(1:L-1)); %删除最后一个数字
set(handles.num_show,'string',num_del);

% 播放声音部分
t_del = [1:410];%410个采样点
x =sin(2*pi*941*t_del/8192)+sin(2*pi*1209*t_del/8192); %删除键声音信号
sound(x,8192); %播放声音

guidata(hObject, handles);


% --- Executes on button press in num8.
function num8_Callback(hObject, eventdata, handles)
% hObject    handle to num8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
count = count+1;
% t8 = linspace(0,1,410);
t8 = [1:410];
x =sin(2*pi*852*t8/8192)+sin(2*pi*1336*t8/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in num7.
function num7_Callback(hObject, eventdata, handles)
% hObject    handle to num7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
count = count+1;
% t7 = linspace(0,1,410);
t7 = [1:410];
x =sin(2*pi*852*t7/8192)+sin(2*pi*1209*t7/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in num6.
function num6_Callback(hObject, eventdata, handles)
% hObject    handle to num6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
count = count+1;
t6 = [1:410];
% t6 = linspace(0,1,410);
x =sin(2*pi*770*t6/8192)+sin(2*pi*1477*t6/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in num0.
function num0_Callback(hObject, eventdata, handles)
% hObject    handle to num0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
count = count+1;
t0 = [1:410];
% t1 = linspace(0,1,410);
x =sin(2*pi*941*t0/8192)+sin(2*pi*1336*t0/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);

% --- Executes on button press in sharp.
function sharp_Callback(hObject, eventdata, handles)
global count;
count = count+1;
ts = [1:410];
% ts = linspace(0,1,410);
x =sin(2*pi*941*ts/8192)+sin(2*pi*1477*ts/8192);
sound(x,8192);

space = zeros(1,410);
phone = [x,space];
handles.numsig = [handles.numsig,phone];
% sound(d1,Fs);
[result,w,a1] = read_number(x,8192,1);
num = [get(handles.num_show,'string'),result];
set(handles.num_show,'string',num);
t = linspace(count,count+1,820);
p = plot(t,handles.numsig(end-819:end),'-r','MarkerSize',5);
q = plot(handles.fft_show,w(1:205),a1(1:205),'-r','MarkerSize',5);
guidata(hObject, handles);


function numsig_Callback(hObject, eventdata, handles)
% hObject    handle to num_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_show as text
%        str2double(get(hObject,'String')) returns contents of num_show as a double


% --- Executes during object creation, after setting all properties.
function num_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.

%    plot(T,handles.numsig,'-b','MarkerSize',5); 


% --- Executes on mouse press over axes background.
function sig_show_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sig_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function sig_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate sig_show


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sw.
function sw_Callback(hObject, eventdata, handles) %按下识别按键后执行录音识别操作
% hObject    handle to sw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    tic
    index = get(handles.popupmenu1,'value'); %选择文件所在目录
    fileName = get(handles.popupmenu1,'string'); %获取所有文件

    path = handles.dir;
    if class(fileName) == 'char' %若未选择目录
        h = warndlg('请选择目录和文件','警告','modal');
    else
    fileName = fileName(index); % 1*1 cell
    file = strcat(num2str(path),'/',fileName{1}); %文件路径
    
    % file = 'test0.wav';
    total = [];
    [y,Fs] = audioread(file);

    % sound(y,Fs);
    y = y';
    answer = []; %识别出的数字
    sig_edge = sigfilter(handles,hObject,file); %调用编写的sigfilter函数对录音进行滤波等处理，得到每一个按键声音开始和结束的点
    left_edge = sig_edge(1,:); %开始点
    right_edge = sig_edge(2,:); %结束点
    for k=1:size(sig_edge,2)
        [result,w,a1] = read_number(y(left_edge(k):right_edge(k)),Fs,0); %调用read_number函数对每一个信号逐一识别
        answer = [answer result]; %将当前识别的数字放在已识别数字末尾
    end
    
    set(handles.result,'String',answer); %更新gui中识别的数字
    toc
    set(handles.total_time,'String',toc);
    guidata(hObject, handles);
end


function [result,w,a1] = read_number(sig,Fs,flag) %sig:输入用于判断的信号 Fs:采样率 flag:判断用于按键检测或整段音频的识别
if flag == 1 % 按键检测
    N = floor(Fs/20);
else %音频识别
    N = Fs;
end
m = [1:N]; %fft点数
f = fft(sig,N); %N点fft
w = Fs/N*m; %频率

a = abs(f); %将fft后信号取模
a1 = a*2/N; %还原实际幅值
r = [w;a1]; %将每个频率点与幅度相对应
max_sig1 = 0; %判断行
max_sig1_index = 0;
max_sig2 = 0; %判断列
max_sig2_index = 0;
row = 0;
col = 0;
for i=1:N
   if r(1,i)>1 && r(1,i)<1000 %行频
       if r(2,i)>max_sig1 %如果当前的频率比频率的最大值大
           max_sig1 = r(2,i); %更新最大值
           max_sig1_index = r(1,i);
       end

   elseif r(1,i)>1000 && r(1,i)<1700 %列频
      if r(2,i)>max_sig2
           max_sig2 = r(2,i);
           max_sig2_index = r(1,i);
      end
   end
end

 
if(max_sig1_index<730) %判断行频
    row = 1;
elseif(max_sig1_index<810)
    row = 2;
elseif(max_sig1_index<900)
    row = 3;
else
    row = 4;
end

if(max_sig2_index<1250)  %判断行频
    col = 1;
elseif(max_sig2_index<1370)
    col = 2;
elseif(max_sig2_index<1550)
    col = 3;
else
    col = 4;
end

switch mat2str([row col]) %根据行列坐标判断数字
    case {'[1 1]'}
        result = '1';
    case {'[1 2]'}
        result = '2';
    case {'[1 3]'}
        result = '3';
    case {'[2 1]'}
        result = '4';
    case {'[2 2]'}
        result = '5';
    case {'[2 3]'}
        result = '6';
    case {'[3 1]'}
        result = '7';
    case {'[3 2]'}
        result = '8';
    case {'[3 3]'}
        result = '9';
    case {'[4 1]'}
        result = '*';
    case {'[4 2]'}
        result = '0';
    case {'[4 3]'}
        result = '#';

end


% --- Executes on button press in btn_dir.
function btn_dir_Callback(hObject, eventdata, handles)
% hObject    handle to btn_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
default_path = './';
path = uigetdir(default_path,'选择样本目录');
% set(handles.dir,uigetdir(default_path,'选择样本目录'));
handles.dir = path;
% disp(handles.dir);
if(handles.dir == 0)
    handles.dir = pwd;
else
    audio_file = {};
    file = dir(handles.dir);

    for i=1:length(file)
        if(length(file(i).name) >=4)
            name = file(i).name;
            if(name(end-2:end) == 'm4a') | (name(end-2:end) == 'mp3') | (name(end-2:end) == 'wav')
                audio_file = [audio_file name];
                set(handles.popupmenu1,'string',audio_file);
            end
        end
    end
    % disp(audio_file);
end

 guidata(hObject, handles);
 
function [sig_edge] = sigfilter(handles,hObject,file) %对信号进行滤波操作

% file = strcat('./进阶任务样本/E1.m4a');
[yt,Fs] = audioread(file); %读取音频
% sound(y,Fs);
  
dt=1/Fs; %采样时间
N=length(yt); %采样点数

y=fft(yt); %fft变换

% figure
% subplot(2,2,1),plot([0:N-1]/Fs,yt);
% xlabel('时间/s'),title('时间域');
% 
% 
% subplot(2,2,2),plot([0:N-1]/(N*dt),abs(y)*2/N);
% xlabel('频率/kHz'),title('幅频图');
% ylabel('振幅');

f1=695; %带通滤波器频率
f2=1480;
yy=zeros(1,length(y));
for m=0:N-1   %将频率落在该频率范围及其大于Nyquist频率的波滤去
   if(m/(N*dt)<f1|m/(N*dt)>f2)...   %小于Nyquist频率的滤波范围
|(m/(N*dt)<(1/dt-f2)&m/(N*dt)>(1/dt-f1))  %大于Nyquist频率的滤波范围
%1/dt为一个频率周期
      yy(m+1)=0.0;       %置在此频率范围内的振动振幅为零
   else
      yy(m+1)=y(m+1);     %其余频率范围的振动振幅不变
   end
end

plot(handles.fft_show,[0:N-1]/(N*dt),abs(yy)*2/N)

set(handles.fft_show,'xlim',[0 2000]);
ifft_yy = real(ifft(yy)); %ifft变换还原时域信号
% subplot(2,2,3),plot([0:N-1]/Fs,real(ifft_yy))
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
plot(handles.sig_show,ifft_yy)

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

guidata(hObject, handles);
