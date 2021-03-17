function varargout = ex1(varargin)
% EX1 MATLAB code for ex1.fig
%      EX1, by itself, creates a new EX1 or raises the existing
%      singleton*.
%
%      H = EX1 returns the handle to a new EX1 or the handle to
%      the existing singleton*.
%
%      EX1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EX1.M with the given input arguments.
%
%      EX1('Property','Value',...) creates a new EX1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ex1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ex1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ex1

% Last Modified by GUIDE v2.5 10-May-2020 11:45:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ex1_OpeningFcn, ...
                   'gui_OutputFcn',  @ex1_OutputFcn, ...
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


% --- Executes just before ex1 is made visible.
function ex1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ex1 (see VARARGIN)

% Choose default command line output for ex1
handles.output = hObject;
handles.a = 1;
handles.flag = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ex1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ex1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in generate_btn.
function generate_btn_Callback(hObject, eventdata, handles)
% hObject    handle to generate_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N_str = get(handles.n_edit,'String');
N = str2double(N_str);
t = linspace(-1,1,1000);
y = square(2*pi*t,50);
n = 1:2:N;
M = 4./(pi*n);
f = sin(2*pi*n'*t);
x = M*f;
highest = sin(2*pi*N*t);
plot(handles.highest_fig,t,highest)
title(handles.highest_fig,'最高次谐波')
axis(handles.highest_fig,[-inf inf -1.5 1.5])
plot(handles.combine_result,t,y,'b',t, x,'r')
title(handles.combine_result,'合成结果')


function n_edit_Callback(hObject, eventdata, handles)
% hObject    handle to n_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_edit as text
%        str2double(get(hObject,'String')) returns contents of n_edit as a double


% --- Executes during object creation, after setting all properties.
function n_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rst_btn.
function rst_btn_Callback(hObject, eventdata, handles)
% hObject    handle to rst_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.n_edit,'String','');
plot(handles.highest_fig,0,0)
title(handles.highest_fig,'最高次谐波')
axis(handles.highest_fig,[-inf inf -1.5 1.5])
plot(handles.combine_result,0,0)
title(handles.combine_result,'合成结果')


% --- Executes on selection change in sel_sig_popupmenu.
function sel_sig_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to sel_sig_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sel_sig_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_sig_popupmenu
set(handles.slider1,'Value',1.0);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sel_sig_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_sig_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generate_btn2.
function generate_btn2_Callback(hObject, eventdata, handles)
% hObject    handle to generate_btn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider1,'Enable','on');
index = get(handles.sel_sig_popupmenu,'Value');
fourier_trans(hObject,handles,index);
% t = linspace(-1,1,1000);

function fourier_trans(hObject,handles,index)
    dt = 0.01;
    t = -5:dt:5;
    switch(index)
    % 请选择信号..
    % 正弦信号
    % 方波信号
    % 三角波信号
    % 单位冲激信号
    % 阶跃信号
    % 直流信号
    % 抽样信号
    % 单边指数信号
    % 符号函数
    case 1
        h = warndlg('请选择信号','警告','modal');
        y = 0;
        set(handles.slider1,'Enable','off');
    case 2
        y = sin(2*pi*t*handles.a);
%         handles.a
        str = strcat('y = sin(2*pi*',num2str(handles.a),'*t)');
        set(handles.cur_sig,'String',str);
    case 3
        y = square(2*pi*t,50+handles.a*2);
        str = strcat('占空比为',num2str(50+handles.a*2),'%的方波信号');
        set(handles.cur_sig,'String',str);
    case 4
        y = sawtooth(2*pi*t,0.5+handles.a*0.01);
        str = strcat('宽度为',num2str(0.5+handles.a*0.01),'的三角波信号');
        set(handles.cur_sig,'String',str);
    case 5
        set(handles.slider1,'Enable','off');
        y = (t==0);
        str = '单位冲激信号';
        set(handles.cur_sig,'String',str);
    case 6
        y = stepfun(t,handles.a*0.2-5);
        str = strcat('起点为',num2str(handles.a*0.2-5),'的单位阶跃信号');
        set(handles.cur_sig,'String',str);
    case 7
        y = exp(-handles.a*t);
        str = strcat('y = exp(-',num2str(handles.a),'*t)');
        set(handles.cur_sig,'String',str);
    case 8
        set(handles.slider1,'Enable','off');
        y = sign(t);
        str = '符号函数';
        set(handles.cur_sig,'String',str);
    end
    
    N = length(t);
    n = [0:1:N-1];
    k = [0:1:N-1];
    WN = exp(-1j*2*pi/N);
    nk = n'*k;
    WNnk = WN.^(nk);
    Xk = y*WNnk;
    dw = [-5*pi:0.01*pi:5*pi];
    plot(handles.fig_show,t,y)
    plot(handles.frequency_show,dw,abs(Xk))
    plot(handles.phase_show,angle(Xk))
    if index == 2 || index == 3 || index == 4
        axis(handles.fig_show,[-inf inf -1.5 1.5])
    elseif index == 5
        axis(handles.frequency_show,[-inf inf 0 1.5])
        axis(handles.fig_show,[-10 20 -inf inf])
    elseif index == 6
        axis(handles.fig_show, [-inf inf -0.5 1.5])
    end
%     axis(handles.fig_show,[-inf inf -inf inf])
    guidata(hObject, handles);
    
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.a = get(hObject,'Value');
index = get(handles.sel_sig_popupmenu,'Value');
fourier_trans(hObject,handles,index);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in start_btn.
function start_btn_Callback(hObject, eventdata, handles)
% hObject    handle to start_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
global timelength
global sig_y
global sig_Fs
[file,path,index] = uigetfile({'*.mp3';'*.wav';'*.m4a';'*.mp4'},'File Selector');
if index == 0
    h = warndlg('请选择文件','警告','modal');
else
    fileName = fullfile(path,file);
    set(handles.file_name,'String',fileName);
    file = get(handles.file_name,'String');
    [sig_y,sig_Fs] = audioread(file);
    player = audioplayer(sig_y,sig_Fs);
    timelength = length(sig_y)/sig_Fs;
%     [y,Fs] = audioread(fileName);
%     sound(y,Fs);
end

guidata(hObject, handles);


% --- Executes on button press in toggle_btn.
function toggle_btn_Callback(hObject, eventdata, handles)
% hObject    handle to toggle_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
% global timelength
global sig_y
global sig_Fs
% Hint: get(hObject,'Value') returns toggle state of toggle_btn
% N =  get(player,'TotalSamples');
% N = sig_Fs;
% N = length(t);
% n = [0:1:N-1];
% k = [0:1:N-1];
% WN = exp(-1j*2*pi/N);
% nk = n'*k;
% WNnk = WN.^(nk);
% Xk = y*WNnk;
% dw = [-5*pi:0.01*pi:5*pi];

if sig_Fs~=0
%     N = 1:sig_Fs;
    Xk = fft(sig_y,sig_Fs);
    
%     N = sig_Fs;
%     n = [0:1:N-1];
%     k = [0:1:N-1];
%     WN = exp(-1j*2*pi/N);
%     nk = n'*k;
%     WNnk = WN.^(nk);
%     Xk = sig_y*WNnk;
%     dw = [-5*pi:0.01*pi:5*pi];
    
    
    plot(handles.analysis_show,abs(Xk))
    axis(handles.analysis_show,[0 sig_Fs/2 -inf inf])
    plot(handles.analysis_show_1,angle(Xk));
    title(handles.analysis_show,'frequency')
    title(handles.analysis_show_1,'phase')
    if get(hObject,'Value') == 1
    %     sound(y,Fs);

    %     analyser(handles)
        set(handles.toggle_btn,'String','暂停');
        if handles.flag == 0
            play(player);
        else
            resume(player);
        end

    else
        handles.flag = 1;
        set(handles.toggle_btn,'String','播放');
        pause(player);
    %     isplaying(player);
    end
end
guidata(hObject, handles);



% --- Executes on button press in stop_btn.
function stop_btn_Callback(hObject, eventdata, handles)
% hObject    handle to stop_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
global sig_Fs
if length(sig_Fs)~=0
    stop(player);
    set(handles.toggle_btn,'String','播放');
    set(handles.toggle_btn,'Value',0);
    guidata(hObject, handles);
end

% function result = dft(handles,left_edge,right_edge)
%     global sig_y
%     
%     y = sig_y(left_edge:right_edge);
%     N = length(right_edge-left_edge);
%     n = [0:1:N-1];
%     k = [0:1:N-1];
%     WN = exp(-1j*2*pi/N);
%     nk = n'*k;
%     WNnk = WN.^(nk);
%     Xk = y*WNnk;
%     dw = [-5*pi:0.01*pi:5*pi];
%     result = abs(Xk);
%     
% function analyser(handles)
% %     sig_range = sig_y(cur_time:cur_time+sig_Fs);
% %     time_range = 1:length(sig_Fs);
% %     plot(handles.analysis_show,time_range,sig_range)
% %     drawnow
%     global sig_Fs
%     t=[0];
%     m = dft(handles,1000,1000+sig_Fs);
%     p = plot(handles.analysis_show,t,m,...
%        'EraseMode','background','MarkerSize',5);%%定义数据种类，因此t和m不能为空
%     x=-1.5*pi;           %坐标初始设置小于数据起始位置，任意设置
%     axis([x x+2*pi -1.5 1.5]); %绘图坐标设置，横坐标设置为x的参数
%     grid on;


%     for i=1:1000
%         t=[t 0.1*i];                   %Matrix 1*(i+1)
%         m=[m dft(handles,1000,1000+sig_Fs)]; %Matrix 2*(i+1)
%         set(p(1),'XData',t,'YData',m(1,:))   
%         drawnow
%         x=x+0.1;    
%         axis([x x+2*pi -1.5 1.5]);
%         pause(0.5);
%     end

    
