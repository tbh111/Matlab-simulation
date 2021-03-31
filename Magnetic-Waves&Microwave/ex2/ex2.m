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

% Last Modified by GUIDE v2.5 31-Mar-2021 10:50:03

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


% --- Executes on button press in play_pushbutton.
function play_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to play_pushbutton (see GCBO)
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


% --- Executes on button press in stop_pushbutton.
function stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(timerfind)
    stop(timerfind);
    delete(timerfind);
end
axes(handles.axes1);
cla reset
guidata(hObject, handles);

function timer_sub(hObject, eventdata, handles)
global t
t = t+1;

u0 = 4*pi*10.^(-7);
e0 = 1/(36*pi)*10^(-9);
omiga = str2double(get(handles.w,'String'))*pi;
Ei0 = 1;
n=2;
t1 = t*0.5/omiga;

if(get(handles.con_radiobutton,'Value') == 1)
    set(handles.e1,'Visible','Off');
    set(handles.e2,'Visible','Off');
    set(handles.text5,'Visible','Off');
    set(handles.text7,'Visible','Off');
    u1 = u0;
    e1 = e0;
    k1 = omiga *sqrt(u1*e1);
    eta1 = sqrt(u1/e1);
    lambda1 = 2*pi/k1;
    z = -n*lambda1:lambda1/1000:0;
    zero = 0*ones(size(z));
    E = 2*Ei0*sin(k1*z).*sin(omiga*t1);
    H = 2*Ei0/eta1*cos(k1*z).*cos(omiga*t1);
    axes(handles.axes2);
    plot(handles.axes2,z,E);
    axis([-n*lambda1,0,-2*Ei0,2*Ei0])
    title('电场在导体外侧的波形,多次')

    axes(handles.axes3);
    plot(handles.axes3,z,H);
    axis([-n*lambda1,0,-2*Ei0/eta1,2*Ei0/eta1])
    title('磁场在导体外侧的波形,多次')
    
else
    set(handles.e1,'Visible','On');
    set(handles.e2,'Visible','On');
    set(handles.text5,'Visible','On');
    set(handles.text7,'Visible','On');
    u1 = u0;
    u2 = u0;
    e1 = e0*str2double(get(handles.e1,'String'));
    e2 = e0*str2double(get(handles.e2,'String'));
    k1 = omiga*sqrt(u1*e1);
    k2 = omiga*sqrt(u2*e2);
    eta1 = sqrt(u1/e1);
    eta2 = sqrt(u2/e2);
    R=(eta2-eta1)/(eta2+eta1);
    T=(2*eta2)/(eta2+eta1);
    lambda1 = 2*pi/k1;
    z0 = -n*lambda1:lambda1/1000:0;
    z1 = lambda1/1000:lambda1/1000:n*lambda1+lambda1/1000;
    z = [z0 z1];
    zero = 0*ones(size(z));
    t1 = t1*ones(size(z0));
    v_E1 = exp(-1i*k1*z0)+R*exp(1i*k1*z0);
    E1 = Ei0*abs(v_E1).*cos(omiga*t1+angle(v_E1));
    v_E2 = Ei0*exp(-1i*k2*z1);
    E2 = T*abs(v_E2).*cos(omiga*t1+angle(v_E2));
    v_H1 = (exp(-1i*k1*z0)-R*exp(1i*k1*z0));
    H1 = Ei0/eta1*abs(v_H1).*cos(omiga*t1+angle(v_H1));
    v_H2 = exp(-1i*k2*z1);
    H2 = T*Ei0/eta2*abs(v_H2).*cos(omiga*t1+angle(v_H2));
    E = [E1 E2];
    H = [H1 H2];
    
    axes(handles.axes2);
    plot(handles.axes2,z,E);
    axis([-n*lambda1,n*lambda1,-2*Ei0,2*Ei0])
    title('电场在导体外侧的波形,多次')

    axes(handles.axes3);
    plot(handles.axes3,z,H);
    axis([-n*lambda1,n*lambda1,-2*Ei0/eta1,2*Ei0/eta1])
    title('磁场在导体外侧的波形,多次')
end
drawnow
%电场
axes(handles.axes1)
q1 = quiver3(handles.axes1,z,zero,zero,zero,zero,E,'-R');
set(q1,'ShowArrowHead','off');
hold on;
%磁场
q2 = quiver3(handles.axes1,z,zero,zero,zero,H,zero,'-B');
set(q2,'ShowArrowHead','off');
xlabel(' 电磁波传播方向','fontSize',12);
ylabel(' 磁场变化方向','fontSize',12);
zlabel(' 电场变化方向','fontSize',12);
hold off;

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(timerfind)
    stop(timerfind);
    delete(timerfind);
end
