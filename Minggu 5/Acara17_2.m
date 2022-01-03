function varargout = Acara17_2(varargin)
% ACARA17_2 MATLAB code for Acara17_2.fig
%      ACARA17_2, by itself, creates a new ACARA17_2 or raises the existing
%      singleton*.
%
%      H = ACARA17_2 returns the handle to a new ACARA17_2 or the handle to
%      the existing singleton*.
%
%      ACARA17_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACARA17_2.M with the given input arguments.
%
%      ACARA17_2('Property','Value',...) creates a new ACARA17_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Acara17_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Acara17_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Acara17_2

% Last Modified by GUIDE v2.5 06-Oct-2021 14:41:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Acara17_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Acara17_2_OutputFcn, ...
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


% --- Executes just before Acara17_2 is made visible.
function Acara17_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Acara17_2 (see VARARGIN)

% Choose default command line output for Acara17_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Acara17_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Acara17_2_OutputFcn(hObject, eventdata, handles) 
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
[name_file1,name_path1] = uigetfile( ...
{'*.bmp;*.jpg;*.tif','Files of type (*.bmp,*.jpg,*.tif)';
'*.bmp','File Bitmap (*.bmp)';...
'*.jpg','File jpeg (*.jpg)';
'*.tif','File Tif (*.tif)';
'*.*','All Files (*.*)'},...
'Open Image');
if ~isequal(name_file1,0)
handles.data1 = imread(fullfile(name_path1,name_file1));
guidata(hObject,handles);
axes(handles.axes1);
imshow(handles.data1);
else
return;
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image1 = handles.data1;
gray = rgb2gray(image1);
axes(handles.axes2);
imshow(gray);
handles.data2 = gray;
guidata(hObject,handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gray = handles.data2;
value = graythresh(gray);
thresh = im2bw(gray,value);
thresh = imcomplement(thresh);
axes(handles.axes2);
imshow(thresh);
handles.data3 = thresh;
guidata(hObject,handles);
set(handles.edit1,'String',value)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
thresh = handles.data3;
[name_file_save,path_save] = uiputfile( ...
{'*.bmp','File Bitmap (*.bmp)';...
'*.jpg','File jpeg (*.jpg)';
'*.tif','File Tif (*.tif)';
'*.*','All Files (*.*)'},...
'Save Image');
if ~isequal(name_file_save,0)
imwrite(thresh,fullfile(path_save,name_file_save));
else
return
end
