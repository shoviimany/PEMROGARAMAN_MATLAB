function varargout = Acara19(varargin)
% ACARA19 MATLAB code for Acara19.fig
%      ACARA19, by itself, creates a new ACARA19 or raises the existing
%      singleton*.
%
%      H = ACARA19 returns the handle to a new ACARA19 or the handle to
%      the existing singleton*.
%
%      ACARA19('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACARA19.M with the given input arguments.
%
%      ACARA19('Property','Value',...) creates a new ACARA19 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Acara19_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Acara19_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Acara19

% Last Modified by GUIDE v2.5 06-Oct-2021 18:50:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Acara19_OpeningFcn, ...
                   'gui_OutputFcn',  @Acara19_OutputFcn, ...
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


% --- Executes just before Acara19 is made visible.
function Acara19_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Acara19 (see VARARGIN)

% Choose default command line output for Acara19
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');
clc;clear;

% UIWAIT makes Acara19 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Acara19_OutputFcn(hObject, eventdata, handles) 
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
[filename,pathname] = uigetfile({'*.*'});
 
if ~isequal(filename,0)
    Info = imfinfo(fullfile(pathname,filename));
    if Info.BitDepth == 1
        msgbox('Citra masukan harus citra RGB atau Grayscale');
        return
    elseif Info.BitDepth == 8
        Img_Gray = imread(fullfile(pathname,filename));
        axes(handles.axes1)
        cla('reset')
        imshow(Img_Gray)
        title('Grayscale Image')
        value = graythresh(Img_Gray);
        Img_bw = im2bw(Img_Gray,value);
        Img_bw = imcomplement(Img_bw);
        %Img_bw = im2bw(Img_Gray,graythresh(Img_Gray));
        axes(handles.axes2)
        cla('reset')
        imshow(Img_bw)
        title('Binary Image')
    else
        Img_Gray = rgb2gray(imread(fullfile(pathname,filename)));
        axes(handles.axes1)
        cla('reset')
        imshow(Img_Gray)
        title('Grayscale Image')
        value = graythresh(Img_Gray);
        Img_bw = im2bw(Img_Gray,value);
        Img_bw = imcomplement(Img_bw);
        %Img_bw = im2bw(Img_Gray,graythresh(Img_Gray));
        axes(handles.axes2)
        cla('reset')
        imshow(Img_bw)
        title('Binary Image')
    end
else
    return
end
 
handles.Img_Gray = Img_Gray;
handles.Img_Gray2 = Img_Gray;
handles.Img_bw = Img_bw;
handles.Img_bw2 = Img_bw;
guidata(hObject,handles);
 
set(handles.pushbutton2,'Enable','on')

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img_Gray = handles.Img_Gray;
Img_bw = handles.Img_bw;
 
% Operations
val1 = get(handles.radiobutton1,'Value');
val2 = get(handles.radiobutton2,'Value');
val3 = get(handles.radiobutton3,'Value');
val4 = get(handles.radiobutton4,'Value');
 
% Structure Element
val5 = get(handles.radiobutton5,'Value');
val6 = get(handles.radiobutton6,'Value');
val7 = get(handles.radiobutton7,'Value');
val8 = get(handles.radiobutton8,'Value');
 
% R
R = str2double(get(handles.edit1,'String'));
 
%
if val5 == 1
    se = strel('disk',R);
elseif val6 == 1
    se = strel('diamond',R);
elseif val7 == 1
    se = strel('square',R);
elseif val8 == 1
    se = strel('line',R,45);
end
 
 
if val1 == 1
    Morph_Gray = imerode(Img_Gray,se);
    Morph_bw = imerode(Img_bw,se);
elseif val2 == 1
    Morph_Gray = imdilate(Img_Gray,se);
    Morph_bw = imdilate(Img_bw,se);
elseif val3 == 1
    Morph_Gray = imopen(Img_Gray,se);
    Morph_bw = imopen(Img_bw,se);
elseif val4 == 1
    Morph_Gray = imclose(Img_Gray,se);
    Morph_bw = imclose(Img_bw,se);
end
 
axes(handles.axes1)
cla('reset')
imshow(Img_Gray)
title('Grayscale Image')
axes(handles.axes2)
cla('reset')
imshow(Img_bw)
title('Binary Image')
axes(handles.axes3)
cla('reset')
imshow(Morph_Gray)
title('Morphological Operation')
axes(handles.axes4)
cla('reset')
imshow(Morph_bw)
title('Morphological Operation')

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
 
axes(handles.axes2)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
 
axes(handles.axes3)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
 
axes(handles.axes4)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
 
set(handles.pushbutton2,'Enable','off')
set(handles.edit1,'String',1)
set(handles.radiobutton1,'Value',1)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',1)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(handles.edit1,'String'))-1;
if val < 1
    val = 1;
end
set(handles.edit1,'String',val)


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(handles.edit1,'String'))+1;
if val > 10
    val = 10;
end
set(handles.edit1,'String',val)

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
set(handles.radiobutton5,'Value',1)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',1)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)

% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',1)
set(handles.radiobutton8,'Value',0)

% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',1)

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton1,'Value',1)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',1)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton3
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',1)
set(handles.radiobutton4,'Value',0)

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',1)
