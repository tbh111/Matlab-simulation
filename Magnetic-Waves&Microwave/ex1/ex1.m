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

% Last Modified by GUIDE v2.5 17-Mar-2021 13:08:48

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


% --- Executes on button press in playbutton.
function playbutton_Callback(hObject, eventdata, handles)
% hObject    handle to playbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(timerfind)
    stop(timerfind);
    delete(timerfind);
end
global t
t = 0;

handles.tmr = timer;
set(handles.tmr,'ExecutionMode','fixedRate');   
set(handles.tmr,'Period',0.1);
set(handles.tmr,'BusyMode','queue');
set(handles.tmr,'TimerFcn',{@timer_sub,handles});  
start(handles.tmr);
guidata(hObject, handles);

function timer_sub(hObject,eventdata,handles)
global t
t = t+1;

if(get(handles.dy_radiobutton,'Value')==1)
   t1 = t; 
else
    t1 = 0;
end

% disp(t)
x = 0:0.001:10*get(handles.slider,'Value');
zero = 0*ones(size(x));
one = ones(size(x));
set(handles.text13,'String',strcat("scale:",num2str(get(handles.slider,'Value'))));

E0 = str2double(get(handles.E0,'String'));
w = str2double(get(handles.w,'String'))*pi*10^8;
k = str2double(get(handles.k,'String'))*pi;
theta0 = str2double(get(handles.theta0,'String'))*pi;
dtheta = str2double(get(handles.dtheta,'String'))*pi;

if(get(handles.ideal_radiobutton,'Value') == 1)
    set(handles.nc,'Enable','Off');
    set(handles.alpha,'Enable','Off');
    set(handles.nc,'String',0);
    set(handles.alpha,'String',0);
    n = 1/120;
    if(get(handles.dir_x_p,'Value') == 1)
        e=E0*one.*cos(w*t1*10^-10-k*x+theta0);
        h=E0*n*one.*cos(w*t1*10^-10-k*x+theta0-dtheta);
    else
        e=E0*one.*cos(w*-t1*10^-10-k*x+theta0);
        h=E0*n*one.*cos(w*-t1*10^-10-k*x+theta0-dtheta);
    end
else
    set(handles.nc,'Enable','On');
    set(handles.alpha,'Enable','On');
    n = str2double(get(handles.nc,'String'));
    alpha = str2double(get(handles.alpha,'String'));
    if(get(handles.dir_x_p,'Value') == 1)
        e=E0*exp(-alpha*x).*cos(w*t1*10^-10-k*x+theta0);
        h=E0/n*exp(-alpha*x).*cos(w*t1*10^-10-k*x+theta0-dtheta);
    else
        e=E0*exp(alpha*x).*cos(w*-t1*10^-10-k*x+theta0);
        h=E0/n*exp(alpha*x).*cos(w*-t1*10^-10-k*x+theta0-dtheta);
    end
end

drawnow
quiver3(handles.axes1,x,zero,zero,zero,zero,e,'R');
hold on
quiver3(handles.axes1,x,zero,zero,zero,h,zero,'B');
ti=title(' 电磁波在理想介质中传播','color','k');
set(ti,'fontsize',16);
xlabel(' 电磁波传播方向','fontSize',12);
ylabel(' 磁场变化方向','fontSize',12);
zlabel(' 电场变化方向','fontSize',12);
axis([0,10*get(handles.slider,'Value'),-0.1,0.1,-0.1,0.1]);
hold off


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(timerfind);


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function E0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function theta0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function dtheta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dtheta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function nc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stoppushbutton.
function stoppushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stoppushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(timerfind)
    stop(timerfind);
    delete(timerfind);
end
axes(handles.axes1);
cla reset
guidata(hObject, handles);