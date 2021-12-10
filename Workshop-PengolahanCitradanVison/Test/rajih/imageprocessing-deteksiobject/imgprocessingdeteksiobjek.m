function varargout = imgprocessingdeteksiobjek(varargin)
% IMGPROCESSINGDETEKSIOBJEK MATLAB code for imgprocessingdeteksiobjek.fig
%      IMGPROCESSINGDETEKSIOBJEK, by itself, creates a new IMGPROCESSINGDETEKSIOBJEK or raises the existing
%      singleton*.
%
%      H = IMGPROCESSINGDETEKSIOBJEK returns the handle to a new IMGPROCESSINGDETEKSIOBJEK or the handle to
%      the existing singleton*.
%
%      IMGPROCESSINGDETEKSIOBJEK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMGPROCESSINGDETEKSIOBJEK.M with the given input arguments.
%
%      IMGPROCESSINGDETEKSIOBJEK('Property','Value',...) creates a new IMGPROCESSINGDETEKSIOBJEK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imgprocessingdeteksiobjek_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imgprocessingdeteksiobjek_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imgprocessingdeteksiobjek

% Last Modified by GUIDE v2.5 08-Dec-2021 17:58:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imgprocessingdeteksiobjek_OpeningFcn, ...
                   'gui_OutputFcn',  @imgprocessingdeteksiobjek_OutputFcn, ...
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


% --- Executes just before imgprocessingdeteksiobjek is made visible.
function imgprocessingdeteksiobjek_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imgprocessingdeteksiobjek (see VARARGIN)

% Choose default command line output for imgprocessingdeteksiobjek
handles.output = hObject;

clc

axes(handles.axes1);
axis off
im=imread('z.jpg');
imshow(im);

axes(handles.axes2);
axis off


% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');

% UIWAIT makes imgprocessingdeteksiobjek wait for user response (see UIRESUME)
% uiwait(handles.figure1);

 
% --- Outputs from this function are returned to the command line.
function varargout = imgprocessingdeteksiobjek_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);

handles.vid=videoinput('winvideo',1);

vidRes = get(handles.vid,'VideoResolution');
nBands = get(handles.vid, 'NumberOfBands');

hImage = image(zeros(vidRes(2),vidRes(1), nBands), 'Parent',...
handles.axes1);

preview(handles.vid,hImage);

guidata(hObject, handles);

Video = handles.Video;
axes(handles.axes1);
Gambar1 = gets

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mi_imagen=getsnapshot(handles.vid);

axes(handles.axes2);
imshow(mi_imagen);

imwrite(mi_imagen,'image\mifoto.jpg');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
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
    axes(handles.axes2);
    imshow(handles.data1);
else
    return;
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    delete(handles.VidObj)
catch
end

axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.edit1,'String',1)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();



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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image1 = handles.data1;
gray = rgb2gray(image1);
axes(handles.axes2);
imshow(gray);
handles.data2 = gray;
guidata(hObject,handles);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%<<<<<< HEAD:Workshop-PengolahanCitradanVison/Test/daro/imageprocessing-deteksiobject/imgprocessingdeteksiobjek.asv
%cKonvolusi dengan operator Sobel
image1 = handles.data1;
gray = rgb2gray(image1);
sobel = edge(gray, 'sobel');
axes(handles.axes6);
handles.data3 = sobel;
imshow(sobel);
guidata(hObject,handles);
=======

>>>>>>> 5b7e274c56cdd9fa3e5699041aecf2a32f0f42db:Workshop-PengolahanCitradanVison/Test/rajih/imageprocessing-deteksiobject/imgprocessingdeteksiobjek.m

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
<<<<<<< HEAD:Workshop-PengolahanCitradanVison/Test/daro/imageprocessing-deteksiobject/imgprocessingdeteksiobjek.asv
image1 = handles.data1;
imgIBW = im2bw(rgb2gray(Img1));
bboxes = regionprops(ImgIBW);
axes(handles.axes6);
handles.data3 = imgIBW;
imshow(imgIBW);
guidata(hObject,handles);
=======



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
>>>>>>> 5b7e274c56cdd9fa3e5699041aecf2a32f0f42db:Workshop-PengolahanCitradanVison/Test/rajih/imageprocessing-deteksiobject/imgprocessingdeteksiobjek.m
