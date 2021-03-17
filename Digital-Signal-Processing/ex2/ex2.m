function varargout = ex2(varargin)
% EX2 MATLAB code for ex2.fig
%      EX2, by itself, creates a new EX2 or raises the existing
%      singleton*.
%
%      H = EX2 returns the handle to a new EX2 or the handle to
%      the existing singleton*.
%
%      EX2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EX2.M with the given input arguments.
%
%      EX2('Property','Value',...) creates a new EX2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ex2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ex2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ex2

% Last Modified by GUIDE v2.5 15-Jun-2020 19:14:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ex2_OpeningFcn, ...
                   'gui_OutputFcn',  @ex2_OutputFcn, ...
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


% --- Executes just before ex2 is made visible.
function ex2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ex2 (see VARARGIN)

% Choose default command line output for ex2

handles.output = hObject;
handles.filename = '';
handles.y = [];
handles.fs = 0;
handles.flag = 0;
handles.y_filter = [];
handles.flag1 = 0;
% if ~isempty(timerfind)
%     stop(timerfind);
%     delete(timerfind);
% end
% h = timer;
% handles.tmr = h;
% % h.ExecutionMode = 'fixedRate';
% % h.Period = 1;
% % h.timerFcn = {@disptime,handles};
% % start(h);
% set(handles.tmr,'ExecutionMode','fixedRate');   %定时器，循环执行，循环定时。
% set(handles.tmr,'Period',1);    %定时器，定时间隔 1秒
% set(handles.tmr,'TimerFcn',{@timer_sub,handles});    %定时器，定时会触发 TimerFcn 函数，定时函数(TimerFcn)触发用户自定义的函数(disptime函数)
% start(handles.tmr);   %开启定时器

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ex2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ex2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in noise_choose.
function noise_choose_Callback(hObject, eventdata, handles)
% hObject    handle to noise_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns noise_choose contents as cell array
%        contents{get(hObject,'Value')} returns selected item from noise_choose


% --- Executes during object creation, after setting all properties.
function noise_choose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in filter_choose.
function filter_choose_Callback(hObject, eventdata, handles)
% hObject    handle to filter_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filter_choose contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filter_choose
%用于选择不同滤波器之后界面中参数输入框的变化

set(handles.origin_sig,'Value',0);
set(handles.filt_sig,'Value',1);

contents = cellstr(get(hObject,'String')); 
if get(handles.IIR_btn,'Value') == 1

    if ((get(hObject,'Value')) == 3 || ...
    (get(hObject,'Value')) == 4 || ...
    (get(hObject,'Value')) == 7 || ...
    (get(hObject,'Value')) == 8 || ...
    (get(hObject,'Value')) == 11 || ...
    (get(hObject,'Value')) == 12)

        set(handles.fL2_edit,'Visible','on');
        set(handles.fH2_edit,'Visible','on');
        set(handles.text11,'Visible','on');
        set(handles.text12,'Visible','on');   
    else
        set(handles.fL2_edit,'Visible','off');
        set(handles.fH2_edit,'Visible','off');
        set(handles.text11,'Visible','off');
        set(handles.text12,'Visible','off');  
    end
end

if get(handles.IIR_btn,'Value') == 1
    
    if ((get(hObject,'Value')) == 1 || ...
    (get(hObject,'Value')) == 2 || ...
    (get(hObject,'Value')) == 3 || ...
    (get(hObject,'Value')) == 4)
        set(handles.n_edit,'Visible','off');
        set(handles.text13,'Visible','off');
    
    else
        set(handles.n_edit,'Visible','on');
        set(handles.text13,'Visible','on');
    end
end

if get(handles.FIR_btn,'Value') == 1
    set(handles.n_edit,'Visible','on');
    set(handles.text13,'Visible','on');
    set(handles.fL2_edit,'Visible','off');
    set(handles.fH2_edit,'Visible','off');
    set(handles.text11,'Visible','off');
    set(handles.text12,'Visible','off');
    set(handles.text8,'Visible','off');
    set(handles.text9,'Visible','off');
    set(handles.Rp_edit,'Visible','off');
    set(handles.Rs_edit,'Visible','off');
end

    

% --- Executes during object creation, after setting all properties.
function filter_choose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in play_btn.
function play_btn_Callback(hObject, eventdata, handles)
% hObject    handle to play_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stop_btn.
function stop_btn_Callback(hObject, eventdata, handles)
% hObject    handle to stop_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
% if ~isempty(handles.y)
stop(player);
if ~isempty(timerfind)
    stop(timerfind);
end
handles.flag = 0;
set(handles.sw_btn,'String','播放');
set(handles.sw_btn,'Value',0);
set(handles.play_slider,'Value',0);
set(handles.time_text,'String','00:00/00:00');
guidata(hObject, handles);
set(handles.filt_sig,'Enable','on');
set(handles.origin_sig,'Enable','on');


% --- Executes on button press in file_btn.
function file_btn_Callback(hObject, eventdata, handles)
% hObject    handle to file_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%用于选择要播放的文件
global y1
global y_copy
[file, path] = uigetfile({'*.mp3;*.wav;*.mp4;*.m4a','audio files(*.mp3;*.wav;*.mp4;*.m4a)'},...
    '选择音频文件');
if length(file) == 1 && length(path) == 1
    h = warndlg('请选择文件','警告','modal');
    return;
end
handles.filename = strcat(path,file);
[handles.y,handles.fs] = audioread(handles.filename);
y1 = handles.y;
y_copy = handles.y;
% player = audioplayer(handles.y,handles.fs);
total_sec = length(handles.y)/handles.fs;
set(handles.play_slider,'Max',total_sec);
set(handles.play_slider,'Value',0);
if ~isempty(timerfind)
    stop(timerfind);
    delete(timerfind);
end
h = timer;
handles.tmr = h;
% h.ExecutionMode = 'fixedRate';
% h.Period = 1;
% h.timerFcn = {@disptime,handles};
% start(h);
set(handles.tmr,'ExecutionMode','fixedRate');   %定时器，循环执行，循环定时。
set(handles.tmr,'Period',1);    %定时器，定时间隔 1秒
set(handles.tmr,'TimerFcn',{@timer_sub,handles});    %定时器，定时会触发 TimerFcn 函数，定时函数(TimerFcn)触发用户自定义的函数(disptime函数)
if size(handles.y) == [length(handles.y) 2] %多声道
    
    minutes = fix(total_sec(:,1)/60);
    seconds = fix(total_sec(:,1)-minutes*60);
    set(handles.right_btn,'Visible','On');
    set(handles.stereo_btn,'Visible','On');
    set(handles.left_btn,'String','左声道');
    if get(handles.left_btn,'Value') == 1 %选择左声道
        y1 = y1(:,1);
    elseif get(handles.right_btn,'Value') == 1 %选择右声道
        y1 = y1(:,2);
    else %立体声
        y1 = y1;
    end
    
else
    minutes = fix(total_sec/60); %单声道
    seconds = fix(total_sec-minutes*60);
    set(handles.right_btn,'Visible','Off');
    set(handles.stereo_btn,'Visible','Off');
    set(handles.left_btn,'String','单声道');
end

if minutes <10 %显示音频时长
    set(handles.time_text,'String',strcat('00:00/0',num2str(minutes),':',num2str(seconds)));
elseif seconds < 10
    set(handles.time_text,'String',strcat('00:00/',num2str(minutes),':0',num2str(seconds)));
else
    set(handles.time_text,'String',strcat('00:00/',num2str(minutes),':',num2str(seconds)));
end

t = 1:1:length(handles.y);
t = t./handles.fs;


left_channel_en = get(handles.left_btn,'Value');
right_channel_en = get(handles.right_btn,'Value');
stereo_channel_en = get(handles.stereo_btn,'Value');
% 在界面中画出音频波形
right_flag = get(handles.right_btn,'Visible') == 'on';
right_flag = all(right_flag(:)==1);
if left_channel_en == 1
    y_t = handles.y(:,1);
    y_t = y_t';
    plot(handles.sig_show,t,y_t)
    xlabel(handles.sig_show,'s')
    ylabel(handles.sig_show,'amplitude')
    fft_y = fft(handles.y);
    fft_y = fft_y(:,1);
    N = length(t);
    dw = (0:N-1)*handles.fs/N-handles.fs/2;
    plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
elseif right_channel_en == 1 && right_flag == 1
    y_t = handles.y(:,2);
    y_t = y_t';
    plot(handles.sig_show,t,y_t)
    xlabel(handles.sig_show,'r')
    ylabel(handles.sig_show,'amplitude')
    fft_y = fft(handles.y);
    fft_y = fft_y(:,2);
    N = length(t);
    dw = (0:N-1)*handles.fs/N-handles.fs/2;
    plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
else
    y_t = handles.y(:,1);
    y_t = y_t';
    plot(handles.sig_show,t,y_t,'r')
    hold on
    y_t2 = handles.y(:,2);
    y_t2 = y_t2';
    plot(handles.sig_show,t,y_t2,'b')
    xlabel(handles.sig_show,'s')
    ylabel(handles.sig_show,'amplitude')
    fft_y = fft(handles.y);
    N = length(t);
    dw = (0:N-1)*handles.fs/N-handles.fs/2;
    plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
end
guidata(hObject, handles);

% --- Executes on slider movement.
function play_slider_Callback(hObject, eventdata, handles)
% hObject    handle to play_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function play_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to play_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sw_btn.
function sw_btn_Callback(hObject, eventdata, handles)
% hObject    handle to sw_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sw_btn
% 控制音频的播放与暂停
global player
global y_copy
% sound(y_copy,handles.fs)
if isempty(player)
    if handles.flag1 == 0
        player = audioplayer(y_copy,handles.fs);
        handles.flag1 = 1;
    else
        player = audioplayer(handles.y,handles.fs); %生成audioplayer对象
    end
end
% disp(handles.fs)
if ~isempty(handles.y)
    f = get(hObject,'Value');
    if f == 1 && handles.flag == 0 %第一次按下
        start(handles.tmr);
        play(player);
        set(hObject,'String','暂停');
    elseif f == 1 && handles.flag == 1 %继续播放
        resume(player);
        set(hObject,'String','暂停');
    else %暂停
        pause(player);
        handles.flag = 1;
        set(hObject,'String','播放');
        set(handles.filt_sig,'Enable','off');
        set(handles.origin_sig,'Enable','off');
    end
end

s = get(hObject,'String');
if get(hObject,'Value') == 1 || s(1) == '暂'
    set(handles.filt_sig,'Enable','off');
    set(handles.origin_sig,'Enable','off');
else
    set(handles.filt_sig,'Enable','off');
    set(handles.origin_sig,'Enable','off');
end
guidata(hObject, handles);
    
% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function SNR_edit_Callback(hObject, eventdata, handles)
% hObject    handle to SNR_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SNR_edit as text
%        str2double(get(hObject,'String')) returns contents of SNR_edit as a double


% --- Executes during object creation, after setting all properties.
function SNR_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fL_edit_Callback(hObject, ~, handles)
% hObject    handle to fL_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fL_edit as text
%        str2double(get(hObject,'String')) returns contents of fL_edit as a double


% --- Executes during object creation, after setting all properties.
function fL_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fL_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fH_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fH_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fH_edit as text
%        str2double(get(hObject,'String')) returns contents of fH_edit as a double


% --- Executes during object creation, after setting all properties.
function fH_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fH_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Rp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rp_edit as text
%        str2double(get(hObject,'String')) returns contents of Rp_edit as a double


% --- Executes during object creation, after setting all properties.
function Rp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rs_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Rs_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rs_edit as text
%        str2double(get(hObject,'String')) returns contents of Rs_edit as a double


% --- Executes during object creation, after setting all properties.
function Rs_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rs_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% function edit5_Callback(hObject, eventdata, handles)
% % hObject    handle to edit5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit5 as text
% %        str2double(get(hObject,'String')) returns contents of edit5 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit5_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



% function edit6_Callback(hObject, eventdata, handles)
% % hObject    handle to edit6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit6 as text
% %        str2double(get(hObject,'String')) returns contents of edit6 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit6_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes on button press in gen_filter_btn.
function gen_filter_btn_Callback(hObject, eventdata, handles)
% hObject    handle to gen_filter_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 生成滤波器进行滤波
global A
global B
global player
global y1
global y_copy
contents = cellstr(get(handles.filter_choose,'String'));
filter_name = contents{get(handles.filter_choose,'Value')};
disp(strcat('name: ',filter_name));
fL = str2double(get(handles.fL_edit,'String'));
fH = str2double(get(handles.fH_edit,'String'));
Rp = str2double(get(handles.Rp_edit,'String'));
Rs = str2double(get(handles.Rs_edit,'String'));
fL1 = str2double(get(handles.fL2_edit,'String'));
fH1 = str2double(get(handles.fH2_edit,'String'));
step = str2double(get(handles.n_edit,'String'));
if step <1
    return
end
if handles.fs == 0 %未输入信号
    fs = 2000;
    Wp = fL/(fs/2);
    Ws = fH/(fs/2);
    Wp1 = fL1/(fs/2);
    Ws1 = fH1/(fs/2);
    disp('using default sample freq 1000Hz')
    if fL < 1000 || fH < 1000
        h = warndlg('freqency should less than 1000Hz','警告','modal');
        return;
    end
else
    Wp = fL/(handles.fs/2);
    Ws = fH/(handles.fs/2);
    Wp1 = fL1/(handles.fs/2);
    Ws1 = fH1/(handles.fs/2);
    disp(strcat('using input sample freq:',num2str(handles.fs),'Hz'));
end

if get(handles.IIR_btn,'Value') == 1
    disp('IIR')

    Wp2 = [Wp Wp1]; %选择带通和带阻输入两个参数
    Ws2 = [Ws Ws1];
    vi = get(handles.fL2_edit,'Visible');
    vi = (vi(2) == 'f');
    vi = ~all(vi(:)==1);
    if ~(Ws < Wp && Wp < Wp1 && Wp1 < Ws1)&&vi %输入参数错误
        h = warndlg('fH < fL < fL2 < fH2','警告','modal');
        return
    elseif ~(Ws > Wp)&&(~vi)
        h = warndlg('fH > fL ','警告','modal');
        return
        
    else
        switch filter_name
            case 'Butterworth-lowpass'
                [N,Wn] = buttord(Wp,Ws,Rp,Rs);
                [B,A] = butter(N,Wn,'low');
            case 'Butterworth-highpass'
                [N,Wn] = buttord(Wp,Ws,Rp,Rs);
                [B,A] = butter(N,Wn,'high');
            case 'Butterworth-bandpass'
                [N,Wn] = buttord(Wp2,Ws2,Rp,Rs);
                [B,A] = butter(N,Wn,'bandpass');
            case 'Butterworth-bandstop'
                [N,Wn] = buttord(Wp2,Ws2,Rp,Rs);
                [B,A] = butter(N,Wn,'stop');
            case 'Chebyshev-I-lowpass'
                [N,Wn] = cheb1ord(Wp,Ws,Rp,Rs);
                [B,A] = cheby1(step,N,Wn,'low');
            case 'Chebyshev-I-highpass'
                [N,Wn] = cheb1ord(Wp,Ws,Rp,Rs);
                [B,A] = cheby1(step,N,Wn,'high');
            case 'Chebyshev-I-bandpass'
                Wp2 = [Wp Wp1];
                Ws2 = [Ws Ws1];
                [N,Wn] = cheb1ord(Wp2,Ws2,Rp,Rs);
                [B,A] = cheby1(step,N,Wn,'bandpass');
            case 'Chebyshev-I-bandstop'
                Wp2 = [Wp Wp1];
                Ws2 = [Ws Ws1];
                [N,Wn] = cheb1ord(Wp2,Ws2,Rp,Rs);
                [B,A] = cheby1(step,N,Wn,'stop');
            case 'Chebyshev-II-lowpass'
                [N,Wn] = cheb2ord(Wp,Ws,Rp,Rs);
                [B,A] = cheby2(step,N,Wn,'low');
            case 'Chebyshev-II-highpass'
                [N,Wn] = cheb2ord(Wp,Ws,Rp,Rs);
                [B,A] = cheby2(step,N,Wn,'high');
            case 'Chebyshev-II-bandpass'
                Wp2 = [Wp Wp1];
                Ws2 = [Ws Ws1];
                [N,Wn] = cheb2ord(Wp2,Ws2,Rp,Rs);
                [B,A] = cheby2(step,N,Wn,'bandpass');
            case 'Chebyshev-II-bandstop'
                Wp2 = [Wp Wp1];
                Ws2 = [Ws Ws1];
                [N,Wn] = cheb2ord(Wp2,Ws2,Rp,Rs);
                [B,A] = cheby2(step,N,Wn,'stop');
        end
    end

    [H,w] = freqz(B,A);
%     disp(abs(H/max(H)))
    
    db = 20*log10(abs(H/max(H)));
%     if (any(isnan(db(:))) || step > 50) && get(handles.n_edit,'Visible') == 'on'
%         h = warndlg('滤波器阶次过大','警告','modal');
%     end

    plot(handles.filter_show,w/pi,db)
    xlabel(handles.filter_show,'归一化频率')
    title(handles.filter_show,'滤波器频响')
    handles.y_filter = filtfilt(B,A,y_copy);
%     disp('filter in filt')
%     disp(size(handles.y_filter))
%     handles.y = handles.y_filter;
%     y1 = handles.y;
    if handles.fs ~= 0
        player = audioplayer(handles.y_filter,handles.fs);
    end
    if get(handles.filt_sig,'Value') == 1
        t = 1:1:length(handles.y);
        t = t./handles.fs;
        fft_y = fft(handles.y_filter);
        fft_y = fft_y(:,1);
        N = length(t);
        dw = (0:N-1)*handles.fs/N-handles.fs/2;
        plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
        plot(handles.sig_show,t,handles.y_filter(:,1))
    end
    
else
    disp('FIR')
    if Ws < Wp
        h = warndlg('fL < fH ','警告','modal');
        return
    else
        switch filter_name
            case 'hamming-lowpass'
                b = fir1(step,Wp,'low');
                [H,w] = freqz(b,1);
            case 'hamming-highpass'
                b = fir1(step,Ws,'high');
                [H,w] = freqz(b,1);
            case 'hamming-bandpass'
                b = fir1(step,[Wp Ws],'bandpass');
                [H,w] = freqz(b,1);
            case 'hamming-bandstop'
                b = fir1(step,[Wp Ws],'stop');
                [H,w] = freqz(b,1);
            case 'kaiser-lowpass'
                b = fir1(step,Wp,'low',kaiser(step+1,0.5));
                [H,w] = freqz(b,1);
            case 'kaiser-highpass'
                b = fir1(step,Ws,'high',kaiser(step+1,0.5));
                [H,w] = freqz(b,1);
            case 'kaiser-bandpass'
                b = fir1(step,[Wp Ws],'bandpass',kaiser(step+1,0.5));
                [H,w] = freqz(b,1);
            case 'kaiser-bandstop'
                b = fir1(step,[Wp Ws],'stop',kaiser(step+1,0.5));
                [H,w] = freqz(b,1);
        end
    end
            db = 20*log10(abs(H/max(H)));
            plot(handles.filter_show,w/pi,db)
            
            if get(handles.filt_sig,'Value') == 1
                handles.y_filter = filtfilt(b,1,y_copy(:,1));
                t = 1:1:length(handles.y);
                t = t./handles.fs;
                fft_y = fft(handles.y_filter);
                fft_y = fft_y(:,1);
                N = length(t);
                dw = (0:N-1)*handles.fs/N-handles.fs/2;
                plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
                plot(handles.sig_show,t,handles.y_filter(:,1))
                if handles.fs ~= 0
                    player = audioplayer(handles.y_filter,handles.fs);
                end
            end

end
y1 = handles.y_filter(:,1);
guidata(hObject, handles);

% function edit9_Callback(hObject, eventdata, handles)
% % hObject    handle to edit9 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit9 as text
% %        str2double(get(hObject,'String')) returns contents of edit9 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% % function edit9_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit9 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% % if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
% %     set(hObject,'BackgroundColor','white');
% % end



% function edit10_Callback(hObject, eventdata, handles)
% % hObject    handle to edit10 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit10 as text
% %        str2double(get(hObject,'String')) returns contents of edit10 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit10_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit10 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



% function edit11_Callback(hObject, eventdata, handles)
% % hObject    handle to edit11 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit11 as text
% %        str2double(get(hObject,'String')) returns contents of edit11 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit11_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit11 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% 
% function edit12_Callback(hObject, eventdata, handles)
% % hObject    handle to edit12 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit12 as text
% %        str2double(get(hObject,'String')) returns contents of edit12 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit12_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit12 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% 
% function edit13_Callback(hObject, eventdata, handles)
% % hObject    handle to edit13 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit13 as text
% %        str2double(get(hObject,'String')) returns contents of edit13 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit13_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit13 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes when selected object is changed in uibuttongroup_channel.
function uibuttongroup_channel_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup_channel 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 选择声道
current_selection = get(handles.uibuttongroup_channel,'SelectedObject');
current_tag = get(current_selection,'Tag');
t = 1:1:length(handles.y);
t = t./handles.fs;
if ~isempty(handles.y)
    switch current_tag
        case 'left_btn'
            y_t = handles.y(:,1);
            y_t = y_t';
            plot(handles.sig_show,t,y_t)
            xlabel(handles.sig_show,'s')
            ylabel(handles.sig_show,'amplitude')
            fft_y = fft(handles.y);
            fft_y = fft_y(:,1);
            N = length(t);
            dw = (0:N-1)*handles.fs/N-handles.fs/2;
            plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
        case 'right_btn'
            y_t = handles.y(:,2);
            y_t = y_t';
            plot(handles.sig_show,t,y_t)
            xlabel(handles.sig_show,'s')
            ylabel(handles.sig_show,'amplitude')
            fft_y = fft(handles.y);
            fft_y = fft_y(:,2);
            N = length(t);
            dw = (0:N-1)*handles.fs/N-handles.fs/2;
            plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
        case 'stereo_btn'
            y_t = handles.y;
            y_t = y_t';
            plot(handles.sig_show,t,y_t,'r')
            hold on
            y_t2 = handles.y(:,2);
            y_t2 = y_t2';
            plot(handles.sig_show,t,y_t2,'b')
            xlabel(handles.sig_show,'s')
            ylabel(handles.sig_show,'amplitude')
            fft_y = fft(handles.y);
            N = length(t);
            dw = (0:N-1)*handles.fs/N-handles.fs/2;
            plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
    end
end

guidata(hObject, handles);

function timer_sub(hObject,eventdata,handles)
%用于实时显示波形
global player
global y1
y2 = y1;
% disp(size(y2));
Fs = player.SampleRate;
cur_second = fix(player.CurrentSample/Fs);
set(handles.play_slider,'Value',cur_second);
cur_minute = fix(cur_second/60);
cur_second_left = cur_second-cur_minute*60;
if(cur_minute < 10)
    tmp1 = strcat('0',num2str(cur_minute));
else
    tmp1 = num2str(cur_minute);
end
if(cur_second_left < 10)
    tmp2 = strcat('0',num2str(cur_second_left));
else
    tmp2 = num2str(cur_second_left);
end

total_minutes = fix(fix(player.TotalSamples/Fs)/60);
total_seconds_left = fix(player.TotalSamples/Fs)-60*total_minutes;
if(total_minutes < 10)
    tmp3 = strcat('0',num2str(total_minutes));
else
    tmp3 = num2str(total_minutes);
end
if(total_seconds_left < 10)
    tmp4 = strcat('0',num2str(total_seconds_left));
else
    tmp4 = num2str(total_seconds_left);
end
time_show = strcat(tmp1,':',tmp2,'/',tmp3,':',tmp4);
set(handles.time_text,'String',time_show);

if(cur_second >= fix(player.TotalSamples/Fs))
    zero_mat = zeros(1,(cur_second+1)*Fs-length(y2));
%     disp(size(y2))
%     disp(size(zero_mat))
    y2 = horzcat(y2(1,:),zero_mat);
    stop(handles.tmr);
%     delete(handles.tmr);
    handles.flag = 0;
    set(handles.sw_btn,'Value',0);
    set(handles.sw_btn,'string','播放');
    set(handles.filt_sig,'Enable','on');
    set(handles.origin_sig,'Enable','on');
    disp('end')
    return
end
t1 = cur_second+1/Fs:1/Fs:(cur_second+1);
% y2 = y2(:,1);
f1 = y2((cur_second)*Fs+1:(cur_second+1)*Fs);
max_y = abs(max(y1));
% f1 = y1(cur_second*Fs:(cur_second+1)*Fs,1);
plot(handles.sig_live,t1,f1)
% title(handles.sig_live,'实时显示');
axis(handles.sig_live,[-inf inf -max_y(1) max_y(1)])

f1_fft = fft(f1);
N = length(t1);
fm = (0:N-1)*Fs/N-Fs/2;
plot(handles.freq_live,fm*2*pi,fftshift(abs(f1_fft)))

% set(handles.time_text,num2str(cur_second));


% --- Executes when selected object is changed in uibuttongroup_filter.
function uibuttongroup_filter_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup_filter 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
current_selection = get(handles.uibuttongroup_filter,'SelectedObject');
current_tag = get(current_selection,'Tag');
switch current_tag
    case 'IIR_btn'
        set(handles.n_edit,'Visible','off');
        set(handles.text13,'Visible','off');
        set(handles.filter_choose,'Value',1);
        set(handles.text8,'Visible','on');
        set(handles.text9,'Visible','on');
        set(handles.Rp_edit,'Visible','on');
        set(handles.Rs_edit,'Visible','on');
        set(handles.filter_choose,'String',{
            'Butterworth-lowpass'...
            'Butterworth-highpass',...
            'Butterworth-bandpass',...
            'Butterworth-bandstop',...
            'Chebyshev-I-lowpass',...
            'Chebyshev-I-highpass',...
            'Chebyshev-I-bandpass',...
            'Chebyshev-I-bandstop',...
            'Chebyshev-II-lowpass',...
            'Chebyshev-II-highpass',...
            'Chebyshev-II-bandpass',...
            'Chebyshev-II-bandstop'});
    case 'FIR_btn'
        set(handles.fL2_edit,'Visible','off');
        set(handles.fH2_edit,'Visible','off');
        set(handles.text11,'Visible','off');
        set(handles.text12,'Visible','off');
        set(handles.text8,'Visible','off');
        set(handles.text9,'Visible','off');
        set(handles.Rp_edit,'Visible','off');
        set(handles.Rs_edit,'Visible','off');
        set(handles.n_edit,'Visible','on');
        set(handles.text13,'Visible','on');
        set(handles.filter_choose,'Value',1);
        set(handles.filter_choose,'String',{
            'hamming-lowpass',...
            'hamming-highpass',...
            'hamming-bandpass',...
            'hamming-bandstop',...
            'kaiser-lowpass',...
            'kaiser-highpass',...
            'kaiser-bandpass',...
            'kaiser-bandstop'});
        
end



function fL2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fL2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fL2_edit as text
%        str2double(get(hObject,'String')) returns contents of fL2_edit as a double


% --- Executes during object creation, after setting all properties.
function fL2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fL2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fH2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fH2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fH2_edit as text
%        str2double(get(hObject,'String')) returns contents of fH2_edit as a double


% --- Executes during object creation, after setting all properties.
function fH2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fH2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes during object creation, after setting all properties.
function filter_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate filter_show
xlabel(hObject,'归一化频率')
title(hObject,'滤波器频响')


% --- Executes when selected object is changed in uibuttongroup_ctrl.
function uibuttongroup_ctrl_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup_ctrl 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 控制输出原始或滤波波形
global y_copy
global y1
global A
global B
global player
% disp(A)

current_selection = get(handles.uibuttongroup_ctrl,'SelectedObject');
current_tag = get(current_selection,'Tag');
disp(current_tag)
t = 1:1:length(handles.y);
t = t./handles.fs;
if ~isempty(handles.y)
    switch current_tag
        case 'filt_sig'
            disp('filter')
            if isempty(A)
                h = warndlg('请选择滤波器','警告','modal');
                set(handles.origin_sig,'Value',1);
                set(handles.filt_sig,'Value',0);
                return
            end
            y1  = filtfilt(B,A,y1);
            handles.y = filtfilt(B,A,handles.y);
            player = audioplayer(y1,handles.fs);
            left_channel_en = get(handles.left_btn,'Value');
            right_channel_en = get(handles.right_btn,'Value');
            stereo_channel_en = get(handles.stereo_btn,'Value');

            right_flag = get(handles.right_btn,'Visible') == 'on';
            right_flag = all(right_flag(:)==1);
            if left_channel_en == 1
                y_t = handles.y(:,1);
                y_t = y_t';
                plot(handles.sig_show,t,y_t)
                xlabel(handles.sig_show,'s')
                ylabel(handles.sig_show,'amplitude')
                fft_y = fft(handles.y);
                fft_y = fft_y(:,1);
                N = length(t);
                dw = (0:N-1)*handles.fs/N-handles.fs/2;
                plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
            elseif right_channel_en == 1 && right_flag == 1
                y_t = handles.y(:,2);
                y_t = y_t';
                plot(handles.sig_show,t,y_t)
                xlabel(handles.sig_show,'r')
                ylabel(handles.sig_show,'amplitude')
                fft_y = fft(handles.y);
                fft_y = fft_y(:,2);
                N = length(t);
                dw = (0:N-1)*handles.fs/N-handles.fs/2;
                plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
            else
                y_t = handles.y(:,1);
                y_t = y_t';
                plot(handles.sig_show,t,y_t,'r')
                hold on
                y_t2 = handles.y(:,2);
                y_t2 = y_t2';
                plot(handles.sig_show,t,y_t2,'b')
                xlabel(handles.sig_show,'s')
                ylabel(handles.sig_show,'amplitude')
                fft_y = fft(handles.y);
                N = length(t);
                dw = (0:N-1)*handles.fs/N-handles.fs/2;
                plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
            end
        case 'origin_sig'
            disp('origin')
            y1 = y_copy;
            handles.y = y_copy;
            handles.flag1 = 1;
            player = audioplayer(y_copy,handles.fs);
            left_channel_en = get(handles.left_btn,'Value');
            right_channel_en = get(handles.right_btn,'Value');
            stereo_channel_en = get(handles.stereo_btn,'Value');

            right_flag = get(handles.right_btn,'Visible') == 'on';
            right_flag = all(right_flag(:)==1);
            if left_channel_en == 1
                y_t = handles.y(:,1);
                y_t = y_t';
                plot(handles.sig_show,t,y_t)
                xlabel(handles.sig_show,'s')
                ylabel(handles.sig_show,'amplitude')
                fft_y = fft(handles.y);
                fft_y = fft_y(:,1);
                N = length(t);
                dw = (0:N-1)*handles.fs/N-handles.fs/2;
                plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
            elseif right_channel_en == 1 && right_flag == 1
                y_t = handles.y(:,2);
                y_t = y_t';
                plot(handles.sig_show,t,y_t)
                xlabel(handles.sig_show,'r')
                ylabel(handles.sig_show,'amplitude')
                fft_y = fft(handles.y);
                fft_y = fft_y(:,2);
                N = length(t);
                dw = (0:N-1)*handles.fs/N-handles.fs/2;
                plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
            else
                y_t = handles.y(:,1);
                y_t = y_t';
                plot(handles.sig_show,t,y_t,'r')
                hold on
                y_t2 = handles.y(:,2);
                y_t2 = y_t2';
                plot(handles.sig_show,t,y_t2,'b')
                xlabel(handles.sig_show,'s')
                ylabel(handles.sig_show,'amplitude')
                fft_y = fft(handles.y);
                N = length(t);
                dw = (0:N-1)*handles.fs/N-handles.fs/2;
                plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
            end
%     disp(current_tag)
    end
end

guidata(hObject, handles);

% --- Executes on button press in mix_btn.
function mix_btn_Callback(hObject, eventdata, handles)
% hObject    handle to mix_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 混合噪音
global y_copy
SNR = str2double(get(handles.SNR_edit,'String'));
if SNR >0
    t = 1:1:length(handles.y);
    t = t'./handles.fs;
    handles.y = awgn(y_copy,SNR,'measured');
    y_copy = handles.y;
%     sound(handles.y,handles.fs)
    left_channel_en = get(handles.left_btn,'Value');
    right_channel_en = get(handles.right_btn,'Value');
    stereo_channel_en = get(handles.stereo_btn,'Value');

    right_flag = get(handles.right_btn,'Visible') == 'on';
    right_flag = all(right_flag(:)==1);
    if left_channel_en == 1
        y_t = handles.y(:,1);
        y_t = y_t';
        plot(handles.sig_show,t,y_t)
        xlabel(handles.sig_show,'s')
        ylabel(handles.sig_show,'amplitude')
        fft_y = fft(handles.y);
        fft_y = fft_y(:,1);
        N = length(t);
        dw = (0:N-1)*handles.fs/N-handles.fs/2;
        plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
    elseif right_channel_en == 1 && right_flag == 1
        y_t = handles.y(:,2);
        y_t = y_t';
        plot(handles.sig_show,t,y_t)
        xlabel(handles.sig_show,'r')
        ylabel(handles.sig_show,'amplitude')
        fft_y = fft(handles.y);
        fft_y = fft_y(:,2);
        N = length(t);
        dw = (0:N-1)*handles.fs/N-handles.fs/2;
        plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
    else
        y_t = handles.y(:,1);
        y_t = y_t';
        plot(handles.sig_show,t,y_t,'r')
        hold on
        y_t2 = handles.y(:,2);
        y_t2 = y_t2';
        plot(handles.sig_show,t,y_t2,'b')
        xlabel(handles.sig_show,'s')
        ylabel(handles.sig_show,'amplitude')
        fft_y = fft(handles.y);
        N = length(t);
        dw = (0:N-1)*handles.fs/N-handles.fs/2;
        plot(handles.freq_show,dw*2*pi,fftshift(abs(fft_y)))
    end
end


% --- Executes during object deletion, before destroying properties.
function uipanel1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('close all')
clear all
