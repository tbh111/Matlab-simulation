function varargout = ex3(varargin)
% EX3 MATLAB code for ex3.fig
%      EX3, by itself, creates a new EX3 or raises the existing
%      singleton*.
%
%      H = EX3 returns the handle to a new EX3 or the handle to
%      the existing singleton*.
%
%      EX3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EX3.M with the given input arguments.
%
%      EX3('Property','Value',...) creates a new EX3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ex3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ex3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ex3

% Last Modified by GUIDE v2.5 08-Apr-2021 11:08:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ex3_OpeningFcn, ...
                   'gui_OutputFcn',  @ex3_OutputFcn, ...
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


% --- Executes just before ex3 is made visible.
function ex3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ex3 (see VARARGIN)

% Choose default command line output for ex3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ex3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ex3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in play_button.
function play_button_Callback(hObject, eventdata, handles)
% hObject    handle to play_button (see GCBO)
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

% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
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
%% 三维
a = 22.86/1000;
b = 10.16/1000;
vc = 299792458;
d = 15;
H0 = 1;
f = 9.375*10^9;
omega = 2*pi*f;
u = 4*pi*10^(-7);
t1 = t/(10*f);
lambda_c = 2*a;       %TE10截止波长
lambda_0 = vc/f;      %工作波长
c = lambda_0/sqrt(1-(lambda_0/lambda_c)^2);
beta = 2*pi/c;
x = 0:a/d:a;
y = 0:b/d:b;
z = 0:c/d:c;
[x1,y1,z1]= meshgrid(x,y,z);
ex = zeros(size(x1));
ez = ex;
ey = omega.*u.*a.*H0.*sin(pi./a.*x1).*cos(omega*t1-beta.*z1-pi/2)./pi;
drawnow
axes(handles.axes1)
q1 = quiver3(handles.axes1,z1,x1,y1,ez,ex,ey,'r');

hx = beta.*a.*H0.*sin(pi.*x1./a).*cos(omega*t1-beta.*z1+pi/2)./pi;
hy = ex;
hz = H0*cos(pi.*x1./a).*cos(omega*t1-beta.*z1);
hold on
q2 = quiver3(handles.axes1,z1,x1,y1,hz,hx,hy,'b');
title('连续时刻下波导管内电磁场分布图')
xlabel('传输方向');ylabel('波导宽边a');zlabel('波导窄边b');
axis([-c/d c+c/d -a/d a+a/d -b/d b+b/d])
hold off
axes(handles.axes6)
q1_E = quiver3(handles.axes6,z1,x1,y1,ez,ex,ey,'r');
title('连续时刻下波导管内电场分布图')
xlabel('传输方向');ylabel('波导宽边a');zlabel('波导窄边b');
axis([-c/d c+c/d -a/d a+a/d -b/d b+b/d])
axes(handles.axes5)
q2_H = quiver3(handles.axes5,z1,x1,y1,hz,hx,hy,'b');
title('连续时刻下波导管内磁场分布图')
xlabel('传输方向');ylabel('波导宽边a');zlabel('波导窄边b');
axis([-c/d c+c/d -a/d a+a/d -b/d b+b/d])
%% 二维
[x2,y2]= meshgrid(x,y);
z2 = 0;
ey2 = omega.*u.*a.*H0.*sin(pi./a.*x2).*cos(omega*t-beta.*z2-pi/2)./pi;
ex2 = zeros(size(x2));
ez2 = ex2;
hx2 = beta.*a.*H0.*sin(pi.*x2./a).*cos(omega*t-beta.*z2+pi/2)./pi;
hy2 = ex2;
axes(handles.axes2)
q1 = quiver(x2,y2,ex2,ey2,'r');
hold on
q2 = quiver(x2,y2,hx2,hy2,'b');
hold off
title('z=0处的电场、磁场分布')
xlabel('波导宽边a');ylabel('波导窄边b');
axes(handles.axes3)
for zz = 0:c/d:c
    ey1 = omega.*u.*a.*H0.*sin(pi./a.*x).*cos(omega*t-beta.*zz-pi/2)./pi;
    hold on
    plot(x,ey1)
end
hold off
title('z=0处不同x上Ey大小')
xlabel('x');ylabel('Ey');
axes(handles.axes4)
[y2,z2]= meshgrid(y,z);
ey2 = omega.*u.*a.*H0.*sin(pi./a.*x).*cos(omega*t-beta.*z2-pi/2)./pi;
surf(y2,z2,ey2);
title('y-z平面上Ey大小')
xlabel('y');ylabel('z');