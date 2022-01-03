function varargout = cabai(varargin)
% CABAI MATLAB code for cabai.fig
%      CABAI, by itself, creates a new CABAI or raises the existing
%      singleton*.
%
%      H = CABAI returns the handle to a new CABAI or the handle to
%      the existing singleton*.
%
%      CABAI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CABAI.M with the given input arguments.
%
%      CABAI('Property','Value',...) creates a new CABAI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cabai_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cabai_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cabai

% Last Modified by GUIDE v2.5 30-Dec-2021 12:56:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cabai_OpeningFcn, ...
                   'gui_OutputFcn',  @cabai_OutputFcn, ...
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


% --- Executes just before cabai is made visible.
function cabai_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cabai (see VARARGIN)

% Choose default command line output for cabai
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cabai wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cabai_OutputFcn(hObject, eventdata, handles) 
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

% memanggil menu "browse file"
[nama_file, nama_folder] = uigetfile('*.jpg');

% jika ada nama file yang dipilih maka akan mengeksekusi perintah dibawah
if ~isequal(nama_file,0)
    % membaca file citra warna rgb
    Img = imread(fullfile(nama_folder,nama_file));
    axes(handles.axes1)
    imshow(Img)
    title('Citra RGB')
    set(handles.edit1,'String',nama_file)
    
    % Menyimpan Variabel IMG ke lokasi handles agar dapat dipanggil
    % puchbutton yang lain
    handles.Img = Img;
    guidata(hObject, handles)
else
    % jika tidak ada file yang dipilih akan kembali
    return
end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% memanggil variabel Img yg ada di lokasi handles
Img = handles.Img;
Img_gray = rgb2gray(Img); % konversi citra grayscale
% menampilkan ke dalam axes 2
axes(handles.axes2)
imshow(Img_gray)
title('Citra Grayscale')

bw = imbinarize(Img_gray); % konversi citra grayscale ke citra biner  
bw = imcomplement(bw); % operasi komplemen untuk membalik nilai pixel, objek menjadi putih / 1, agar bisa diolah
bw = imfill(bw,'holes'); % operasi morfologi filling holes, untuk menutupi lubang pada objek agar putih semua / lebih sempurna
% menampilkan ke dalam axes 3
axes(handles.axes3)
imshow(bw)
title('Citra Biner')

% Menyimpan Variabel BW ke lokasi handles agar dapat dipanggil
% puchbutton yang lain
handles.bw = bw;
guidata(hObject, handles)



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
clc;
Img = handles.Img;
Img_gray = rgb2gray(Img); % konversi citra grayscale
% figure,imshow(Img_gray);

bw = imbinarize(Img_gray); % konversi citra grayscale ke citra biner
bw = imcomplement(bw); % operasi komplemen untuk membalik nilai pixel, objek menjadi putih / 1, agar bisa diolah
bw = imfill(bw,'holes'); % operasi morfologi filling holes, untuk menutupi lubang pada objek agar putih semua / lebih sempurna

% ekstraksi ciri
% konversi citra rgb ke citra hsv
HSV = rgb2hsv(Img);
axes(handles.axes4)
imshow(HSV)
title('Citra HSV')
% mengekstrak komponen HSV pada citra hsv;
H = HSV(:,:,1); % Hue
S = HSV(:,:,2); % Saturation
V = HSV(:,:,3); % Value

% mengubah nilai piksel background menjadi nol dengan ~bw (negasi bw)
H(~bw) = 0;
S(~bw) = 0;
V(~bw) = 0;
% figure, imshow(H)
% title('H(~bw) biner')

% menghitung nilai rata-rata h,s, dan v
Hue = sum(sum(H)/sum(sum(bw)));
Saturation = sum(sum(S)/sum(sum(bw)));
Value = sum(sum(V)/sum(sum(bw)));
set(handles.edit4,'String',{Hue})
set(handles.edit5,'String',{Saturation})
set(handles.edit6,'String',{Value})

%menyusun variabel ciri_uji
ciri_uji = [Hue,Saturation,Value];
% Menyimpan Variabel ciri_uji ke lokasi handles agar dapat dipanggil
% puchbutton yang lain
handles.ciri_uji = ciri_uji;
guidata(hObject, handles)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  %memanggil model knn hasil pelatihan
  ciri_uji = handles.ciri_uji;
    load Mdl
  % membaca kelas keluaran hasil pengujian
hasil_uji = predict(Mdl,ciri_uji);
set(handles.edit2,'String',hasil_uji{1})

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
set(handles.edit1,'String',[])
set(handles.edit2,'String',[])

axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes3)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes4)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.edit4,'String',[])
set(handles.edit5,'String',[])
set(handles.edit6,'String',[])



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
