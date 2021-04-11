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

% Last Modified by GUIDE v2.5 11-Apr-2021 14:53:43

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
global flag;
flag = 0;
set(handles.axes1,'XTick',[]);
set(handles.axes1,'YTick',[]);
set(handles.axes2,'XTick',[]);
set(handles.axes2,'YTick',[]);
set(handles.axes3,'XTick',[]);
set(handles.axes3,'YTick',[]);
set(handles.axes4,'XTick',[]);
set(handles.axes4,'YTick',[]);
set(handles.axes5,'XTick',[]);
set(handles.axes5,'YTick',[]);
set(handles.axes6,'XTick',[]);
set(handles.axes6,'YTick',[]);
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


% --- Executes on button press in select_src_pushbutton.
function select_src_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_src_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h w d
[handles.src_file,handles.src_path] = uigetfile({'*.bmp'},'Select a bmp file:','MultiSelect','off');
if length(handles.src_file) == 1 || length(handles.src_path) == 1
    warndlg('请选择文件','警告','modal');
    return;
end
handles.srcimg = imread(fullfile(handles.src_path,handles.src_file));
[h,w,d]=size(handles.srcimg);
set(handles.src_text,'String',strcat('size: ',int2str(w),'*',int2str(h),'*',int2str(d)));
axes(handles.axes1)
imshow(handles.srcimg);
guidata(hObject, handles);


% --- Executes on button press in select_info_pushbutton.
function select_info_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_info_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h1 w1 d1
[handles.info_file,handles.info_path] = uigetfile({'*.bmp'},'Select a info bmp file:','MultiSelect','off');
if length(handles.info_file) == 1 || length(handles.info_path) == 1
    warndlg('请选择文件','警告','modal');
    return;
end
handles.infoimg = imread(fullfile(handles.info_path,handles.info_file));
[h1,w1,d1]=size(handles.infoimg);
set(handles.info_text,'String',strcat('size: ',int2str(w1),'*',int2str(h1),'*',int2str(d1)));
axes(handles.axes2)
imshow(handles.infoimg);
guidata(hObject, handles);


% --- Executes on button press in select_dec_pushbutton.
function select_dec_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_dec_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d2
[handles.dec_file,handles.dec_path] = uigetfile({'*.bmp'},'Select a bmp file:','MultiSelect','off');
if length(handles.dec_file) == 1 || length(handles.dec_path) == 1
    warndlg('请选择文件','警告','modal');
    return;
end
handles.decimg = imread(fullfile(handles.dec_path,handles.dec_file));

[w2,h2,d2] = size(handles.decimg);
set(handles.dec_text,'String',strcat('size: ',int2str(w2),'*',int2str(h2),'*',int2str(d2)));
axes(handles.axes4)
imshow(handles.decimg);
guidata(hObject, handles);


% --- Executes on button press in select_pwd_pushbutton.
function select_pwd_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_pwd_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag
[handles.pwd_file,handles.pwd_path] = uigetfile({'*.mat'},'Select a mat file:','MultiSelect','off');
if length(handles.pwd_file) == 1 || length(handles.pwd_path) == 1
    warndlg('请选择文件','警告','modal');
    return;
end
handles.pwd = fullfile(handles.pwd_path,handles.pwd_file);
flag = 1;
guidata(hObject, handles);


% --- Executes on button press in decode_pushbutton.
function decode_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to decode_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d2 flag

if d2 == 3
    im1 = LSB_decode(handles.decimg(:,:,1));
    axes(handles.axes5)
    imshow(im1);
    if flag == 1
        set(handles.axes6,'Visible','On')
        set(handles.decode_txt,'Visible','On')
        load(handles.pwd,'DES_key');
        im2 = DES_dec(im1,DES_key);
    else
        set(handles.axes6,'Visible','Off')
        set(handles.decode_txt,'Visible','Off')
        set(handles.axes6,'Visible','Off')
        im2 = im1;
    end
else
    im1 = LSB_decode(handles.decimg);
    axes(handles.axes5)
    imshow(im1);
    if flag == 1
        set(handles.axes6,'Visible','On')
        set(handles.decode_txt,'Visible','On')
        load(handles.pwd,'DES_key');
        im2 = DES_dec(im1,DES_key);
    else
        set(handles.axes6,'Visible','Off')
        set(handles.decode_txt,'Visible','Off')
        im2 = im1;
    end
end
axes(handles.axes6)
imshow(im2);
flag = 0;
disp('success')
guidata(hObject, handles);


% --- Executes on button press in select_enc_pushbutton.
function select_enc_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_enc_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.enc_path = uigetdir('','Select the new image dir');
guidata(hObject, handles);



% --- Executes on button press in encode_pushbutton.
function encode_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to encode_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d1 d
if d1 == 3
    temp = rgb2gray(handles.infoimg);
end
guidata(hObject, handles);
if get(handles.radiobutton_none,'Value') == 1
    if d == 3
        [LSB_result,~] = LSB_encode(handles.srcimg(:,:,1),temp,0);
        LSB_result = cat(3,LSB_result,handles.srcimg(:,:,2),handles.srcimg(:,:,3));
    else
        [LSB_result,~] = LSB_encode(handles.srcimg,temp,0);
    end
else
    if d == 3
        [LSB_result,~] = LSB_encode(handles.srcimg(:,:,1),temp,1);
        LSB_result = cat(3,LSB_result,handles.srcimg(:,:,2),handles.srcimg(:,:,3));
    else
        [LSB_result,~] = LSB_encode(handles.srcimg,temp,1);
    end
end
axes(handles.axes3)
imshow(LSB_result);
imwrite(LSB_result,strcat(handles.enc_path,'./LSB_result.bmp'));
guidata(hObject, handles);
