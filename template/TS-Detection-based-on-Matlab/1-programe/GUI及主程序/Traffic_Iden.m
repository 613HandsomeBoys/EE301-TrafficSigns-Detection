function varargout = Traffic_Iden(varargin)
% TRAFFIC_IDEN MATLAB code for Traffic_Iden.fig
%      TRAFFIC_IDEN, by itself, creates a new TRAFFIC_IDEN or raises the existing
%      singleton*.
%
%      H = TRAFFIC_IDEN returns the handle to a new TRAFFIC_IDEN or the handle to
%      the existing singleton*.
%
%      TRAFFIC_IDEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAFFIC_IDEN.M with the given input arguments.
%
%      TRAFFIC_IDEN('Property','Value',...) creates a new TRAFFIC_IDEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Traffic_Iden_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Traffic_Iden_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Traffic_Iden

% Last Modified by GUIDE v2.5 17-Jun-2014 11:02:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Traffic_Iden_OpeningFcn, ...
                   'gui_OutputFcn',  @Traffic_Iden_OutputFcn, ...
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


% --- Executes just before Traffic_Iden is made visible.
function Traffic_Iden_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Traffic_Iden (see VARARGIN)

% Choose default command line output for Traffic_Iden
handles.output = hObject;
handles.cd0 = cd;
handles.Color = 0;
handles.I = [];

axes(handles.axes1);
set(gca,'Xtick',[]);
set(gca,'Ytick',[]);
box on;

axes(handles.axes2);
set(gca,'Xtick',[]);
set(gca,'Ytick',[]);
box on;

axes(handles.axes3);
set(gca,'Xtick',[]);
set(gca,'Ytick',[]);
box on;

axes(handles.axes4);
set(gca,'Xtick',[]);
set(gca,'Ytick',[]);
box on;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Traffic_Iden wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Traffic_Iden_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%  读图
[filename, cd1] = uigetfile( ...
    {'*.tif;*.TIF;*.JPG;*.jpg;*.bmp;*.BMP;*.jpeg;*.JPEG;','Image file';...
    '*.*', 'All file (*.*)'},'Pick an Image');
axes(handles.axes1);
cla;
axes(handles.axes2);
cla;
axes(handles.axes3);
cla;
axes(handles.axes4);
cla;
if filename

    cd(cd1);
    d = imread(filename);
    cd(handles.cd0);
    handles.I = d;
    axes(handles.axes1);
    imshow(d);
    handles.filename = filename; 

    box on;
    
end

handles.Color = 0;
cd(handles.cd0);
set(handles.text2,'string','');
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 提取标志
% 按照颜色来分
Color = 0; % 颜色标记  1是红 2 是蓝 3是黄色

if get(handles.radiobutton3,'Value')
    
    Color = 1;
    
elseif get(handles.radiobutton4,'Value')
    
    Color = 2;
    
elseif get(handles.radiobutton5,'Value')
    
    Color = 3;

end

handles.Color = Color;

Image = handles.I;

switch Color
    
    case 1
        
        DI = Image(:,:,1);
        GI = (Image(:,:,1)>110 & Image(:,:,2)<150 & Image(:,:,3)<150 ...
            & abs(double(Image(:,:,2))-double(Image(:,:,3)))<50 & abs(double(Image(:,:,1))-double(Image(:,:,2)))>30);
        
    case 2
        
        DI = Image(:,:,3);
        GI = (Image(:,:,1)<100 & Image(:,:,2)<150 & Image(:,:,3)>120 ...
             & abs(double(Image(:,:,2))-double(Image(:,:,3)))>30);
        
    case 3
        
        DI = rgb2gray(Image);
        GI = (Image(:,:,1)>160 & Image(:,:,2)>90 & Image(:,:,3)<90 ...
            & abs(double(Image(:,:,1))-double(Image(:,:,2)))<100 & abs(double(Image(:,:,1))-double(Image(:,:,3)))>90);
        
end

axes(handles.axes2);

imshow(DI);

axes(handles.axes3);

imshow(GI);

handles.GI = GI;

guidata(hObject, handles);
        

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 分割标志
d = handles.GI;

se = ones(3);  % 腐蚀膨胀模版

d = imdilate(d,se);% 再做膨胀运算 
d = imerode(d,se); % 先做腐蚀运算
% 先膨胀后腐蚀的过程称为开运算。用来填充物体内细小空洞、连接邻近物体、平滑其边界的同时并不明显改变其面积。
d = bwareaopen(d,100); % 移除小对象 小区域肯定是噪声

L = bwlabel(d,8); %标记连通

Num = max(max(L)); % 有几个区域

S = zeros(1,Num);

for i = 1:Num
    
    S(i) = sum(sum(L == i));
    
end

[S,id] = sort(S,'descend');

Ran = zeros(Num,4); % 范围

Fig = zeros(1,Num); % 长宽比

for i = 1:Num
    
    [ix,iy] = find(L == id(i));
    
    Ran(i,:) = [min(ix),max(ix),min(iy),max(iy)]; % 每一个区域的范围
    
end


for i = 1:Num
    
    Fig(i) = max(Ran(i,2)-Ran(i,1),Ran(i,4)-Ran(i,3))/min(Ran(i,2)-Ran(i,1),Ran(i,4)-Ran(i,3));
    
end

in = 0;

for i = 1:Num
    
    if Fig(i) < 1.5 % 长宽比是接近1的 所以不会太离谱
        
        in = i;
        
        break;
        
    end
    
end

if in == 0
    
    in = 1; % 如果都不满足就认定面积最大的一个了 这时候肯定是有干扰的
    
end

axes(handles.axes3);

imshow(L == id(in));

if handles.Color ~= 3
    
    xmin = Ran(in,1);
    xmax = Ran(in,2);
    ymin = Ran(in,3);
    ymax = Ran(in,4);
    
    II = handles.I(xmin:xmax,ymin:ymax,:);
    
elseif handles.Color == 3 % 黄色的多切一点 有黑色边框
   
    xmin = Ran(in,1)-round((Ran(in,2)-Ran(in,1))*0.15);
    xmax = Ran(in,2)+round((Ran(in,2)-Ran(in,1))*0.15);
    ymin = Ran(in,3)-round((Ran(in,4)-Ran(in,3))*0.15);
    ymax = Ran(in,4)+round((Ran(in,4)-Ran(in,3))*0.15);
    
    II = handles.I(xmin:xmax,ymin:ymax,:);
    
end

axes(handles.axes4);
imshow(II);
% imwrite(II,'5.png','png') 
handles.Divice = II;
guidata(hObject, handles);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 这个按钮关闭软件
close all;
clear;
clc;


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 识别按钮

I = handles.Divice;
load Name Name;
load Trained_BP Trained_BP;
load Data Data;

if size(I,3) ~= 1
    I = rgb2gray(I);
end
I = imadjust(I); % 调整对比度    
I = imresize(I,[40,40]); % 都变成40*40的图像

I = im2bw(I); % 二值化

% axes(handles.axes4);
% imshow(I);

I = I(:);

distance = zeros(1,size(Data,2));

for i = 1:size(Data,2)
    distance(i) = norm(I-Data(:,i),2);
end
% 识别部分 str是最后的标志名称 两种方法识别

% 1 神经网络识别 
T = sim(Trained_BP,distance');
id = find(abs(T-1) == min(abs(T-1)));
str = Name{id(1)};


% 2 模板匹配:距离最小的就可以被认为是那个模版 

id = find(distance == min(distance));
str = Name{id(1)};

set(handles.text2,'string',str);
