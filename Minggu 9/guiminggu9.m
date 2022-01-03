function varargout = guiminggu9(varargin)
%GUIMINGGU9 MATLAB code file for guiminggu9.fig
%      GUIMINGGU9, by itself, creates a new GUIMINGGU9 or raises the existing
%      singleton*.
%
%      H = GUIMINGGU9 returns the handle to a new GUIMINGGU9 or the handle to
%      the existing singleton*.
%
%      GUIMINGGU9('Property','Value',...) creates a new GUIMINGGU9 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to guiminggu9_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUIMINGGU9('CALLBACK') and GUIMINGGU9('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUIMINGGU9.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiminggu9

% Last Modified by GUIDE v2.5 02-Nov-2021 21:15:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiminggu9_OpeningFcn, ...
                   'gui_OutputFcn',  @guiminggu9_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before guiminggu9 is made visible.
function guiminggu9_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for guiminggu9
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiminggu9 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiminggu9_OutputFcn(hObject, eventdata, handles)
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
% Memilih file yang ingin diproses
[filename,pathname] = uigetfile({'*.*'});
if ~isequal(filename,0)
    Info = imfinfo(fullfile(pathname,filename));
    Img_Gray = "";
    
    % Memastikan format citra adalah RGB atau grayscale
    if Info.BitDepth == 1
        msgbox('Citra masukan harus citra RGB atau Grayscale');
        return
    % Masukkan citra ke Img_gray jika citra sudah grayscale
    % Grayscale terdiri dari 0-255, jumlah 256
    % Total 8 bit adalah 256
    % BitDepth == 8
    elseif Info.BitDepth == 8
        Img_Gray = imread(fullfile(pathname,filename));
    
    else
        % Ubah RGB Ke grayscale dulu.
        Img_Gray = rgb2gray(imread(fullfile(pathname,filename)));
    end
    
    % Tampilkan gambar
    axes(handles.axes1)
    cla('reset')
    imshow(Img_Gray)
    % title('Citra Asli')
    
else
     return
end

% Memasukkan variable pada handles variable dapat diakses oleh callblack
% yang lainnya
handles.Img_Gray = Img_Gray;
handles.Img_Gray2 = Img_Gray;
guidata(hObject,handles); 
% Tombol proses sekarang bisa ditekan
set(handles.pushbutton2,'Enable','on')

% --- Executes on button press in Process.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Mengambil nilai yang di handle
Img_Gray = handles.Img_Gray;

% Mengambil nilai radio button operasi
val1 = get(handles.radiobutton1,'Value');
val2 = get(handles.radiobutton2,'Value');
val3 = get(handles.radiobutton3,'Value');
val4 = get(handles.radiobutton4,'Value');

if val1 == 1
    % Deteksi tepi Sobel
    img_edge_detec = edge(Img_Gray, 'sobel');
elseif val2 == 1
    % Deteksi tepi Prewit
    img_edge_detec = edge(Img_Gray, 'prewitt');
elseif val3 == 1
    % Deteksi tepi Canny
    img_edge_detec = edge(Img_Gray, 'canny');
elseif val4 == 1
    % Deteksi tepi Robert   
    img_edge_detec = edge(Img_Gray, 'roberts');
else 
    img_edge_detec = Img_Gray;
end

% Tampilkan gambar
axes(handles.axes2)
cla('reset')
imshow(img_edge_detec)
% title('Citra Hasil Deteksi Tepi')


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton1,'Value',1) %untuk sobel
set(handles.radiobutton2,'Value',0) %untuk prewit
set(handles.radiobutton3,'Value',0) %untuk canny
set(handles.radiobutton4,'Value',0) %untuk robert


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton1,'Value',0) %untuk sobel
set(handles.radiobutton2,'Value',1) %untuk prewit
set(handles.radiobutton3,'Value',0) %untuk canny
set(handles.radiobutton4,'Value',0) %untuk robert


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
set(handles.radiobutton1,'Value',0) %untuk sobel
set(handles.radiobutton2,'Value',0) %untuk prewit
set(handles.radiobutton3,'Value',1) %untuk canny
set(handles.radiobutton4,'Value',0) %untuk robert


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.radiobutton1,'Value',0) %untuk sobel
set(handles.radiobutton2,'Value',0) %untuk prewit
set(handles.radiobutton3,'Value',0) %untuk canny
set(handles.radiobutton4,'Value',1) %untuk robert


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
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
set(handles.pushbutton2,'Enable','off')
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)