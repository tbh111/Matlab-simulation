function varargout = LSB_match(varargin)
% LSB_MATCH MATLAB code for LSB_match.fig
%      LSB_MATCH, by itself, creates a new LSB_MATCH or raises the existing
%      singleton*.
%
%      H = LSB_MATCH returns the handle to a new LSB_MATCH or the handle to
%      the existing singleton*.
%
%      LSB_MATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LSB_MATCH.M with the given input arguments.
%
%      LSB_MATCH('Property','Value',...) creates a new LSB_MATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LSB_match_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LSB_match_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LSB_match

% Last Modified by GUIDE v2.5 08-Apr-2021 22:30:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LSB_match_OpeningFcn, ...
                   'gui_OutputFcn',  @LSB_match_OutputFcn, ...
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


% --- Executes just before LSB_match is made visible.
function LSB_match_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LSB_match (see VARARGIN)

% Choose default command line output for LSB_match
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LSB_match wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LSB_match_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
