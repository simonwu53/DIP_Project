function varargout = ImageAssessment(varargin)
% IMAGEASSESSMENT MATLAB code for ImageAssessment.fig
%      IMAGEASSESSMENT, by itself, creates a new IMAGEASSESSMENT or raises the existing
%      singleton*.
%
%      H = IMAGEASSESSMENT returns the handle to a new IMAGEASSESSMENT or the handle to
%      the existing singleton*.
%
%      IMAGEASSESSMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEASSESSMENT.M with the given input arguments.
%
%      IMAGEASSESSMENT('Property','Value',...) creates a new IMAGEASSESSMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageAssessment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageAssessment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageAssessment

% Last Modified by GUIDE v2.5 20-Dec-2017 14:22:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageAssessment_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageAssessment_OutputFcn, ...
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


% --- Executes just before ImageAssessment is made visible.
function ImageAssessment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageAssessment (see VARARGIN)

% set path for Shan
addpath('/Users/simonwu/Documents/MATLAB/DIP_Project/func');
path1 = getenv('PATH');
path1 = [path1 ':/Library/Frameworks/Python.framework/Versions/3.6/bin'];
setenv('PATH', path1);
% Choose default command line output for ImageAssessment
handles.output = hObject;
% add global arguments
handles.counter = 1;
handles.tdata = {};
set(handles.pushbutton4,'Enable','off')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageAssessment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageAssessment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in 'Assessed Image'.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global assessimg
global assessfile
global assesspath
[assessfile, assesspath] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.bmp;*.jpeg','All Image Files'});
if (assessfile==0 & assesspath==0)
    msgbox('You didn''t choose any file!','Opening File Error','error');
else
    assessimg=imread([assesspath, assessfile]);
    axes(handles.axes1)
    imshow(assessimg)
    set(handles.text9,'Visible','on')
    set(handles.text8,'Visible','off')
    set(handles.axes1,'Visible','on')
    set(handles.axes1,'XTick','')
    set(handles.axes1,'YTick','')
end


% --- Executes on button press in 'Original Image'.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originimg
global originfile
global originpath
[originfile, originpath] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.bmp;*.jpeg','All Image Files'});
if (originfile==0 & originpath==0)
    %msgbox('您没有选择文件，请�?新选择!','打开文件出错 COME ON MAN USE ENGLISH!!!! :D','error');
    msgbox('You didn''t choose any file!','Opening File Error','error');
else
    originimg=imread([originpath, originfile]);
    axes(handles.axes2)
    imshow(originimg)
    set(handles.text10,'Visible','on')
    set(handles.axes2,'Visible','on')
    set(handles.axes2,'XTick','')
    set(handles.axes2,'YTick','')
    set(handles.text3,'Visible','off')
    set(handles.pushbutton4,'Enable','on')
end


% --- Executes on button press in 'Show Image'.
% function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if rem(handles.counter,2) == 1
%     % show the panel & change button text
%     set(handles.uipanel2,'Visible','on')
%     set(handles.pushbutton3,'String','Hide Image')
%     handles.counter = handles.counter + 1;
% elseif rem(handles.counter,2) == 0
%     % hid the panel & change button text
%     set(handles.uipanel2,'Visible','off')
%     set(handles.pushbutton3,'String','Show Image')
%     handles.counter = handles.counter + 1;
% end
% guidata(hObject, handles);


% --- Executes on button press in 'Assess it!'.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if has origin image do both referenced & non referenced assessment
global originimg
global assessimg
global originfile
global originpath
global assessfile
global assesspath
if isempty(originimg) == 0
    %If the input image is rgb, convert it to gray image
    noOfDim = ndims(assessimg);
    if(noOfDim == 3)
        g_assessimg = rgb2gray(assessimg);
    end
    noOfDim = ndims(originimg);
    if(noOfDim == 3)
        g_originimg = rgb2gray(originimg);
    end

    %Size Validation
    origSiz = size(originimg);
    distSiz = size(assessimg);
    sizErr = isequal(origSiz, distSiz);
    if(sizErr == 0)
        disp('Error: Original Image & Distorted Image should be of same dimensions');
        msgbox('Original Image & Distorted Image should be of same dimensions','Size Error','error');
        return;
    end
    
    % do calculation
    % Compression ratio
    CR = compression_ratio([originpath,originfile], [assesspath, assessfile]);
    handles.tdata{1,1} = 'Compression Ratio';
    handles.tdata{1,2} = CR;
    % Relative data redundancy  1-1/Cr
    RDR = relative_data_redundancy([originpath,originfile], [assesspath, assessfile]);
    handles.tdata{2,1} = 'Relative Data Redundancy';
    handles.tdata{2,2} = RDR;
    % Mean Square Error(MSE)
    MSE = MeanSquareError(g_originimg, g_assessimg);
    handles.tdata{3,1} = 'Mean Square Error';
    handles.tdata{3,2} = MSE;
    % Root Mean Square Error (RMSE)
    RMSE = MSE^0.5;
    handles.tdata{4,1} = 'Root Mean Square Error';
    handles.tdata{4,2} = RMSE;
    % Signal to Noise Ratio (SNR)
    SNR = signal_to_noise_ratio(g_originimg, g_assessimg);
    handles.tdata{5,1} = 'Signal to noise ratio';
    handles.tdata{5,2} = SNR;
    % Peak Signal to Noise Ratio (PSNR)
    PSNR = PeakSignaltoNoiseRatio(g_originimg, g_assessimg);
    handles.tdata{6,1} = 'Peak Signal to Noise Ratio';
    handles.tdata{6,2} = PSNR;
    % Mean-Square Signal to Noise Ratio (MS-SNR)
    MS_SNR = ms_snr(g_originimg, g_assessimg);
    handles.tdata{7,1} = 'Mean Square Signal to Noise Ratio';
    handles.tdata{7,2} = MS_SNR;
    % Entropy
    en = entropy(g_assessimg);
    handles.tdata{8,1} = 'Entropy';
    handles.tdata{8,2} = en;
    % Normalized Cross-Correlation
    NCC = NormalizedCrossCorrelation(g_originimg, g_assessimg);
    handles.tdata{9,1} = 'Normalized Cross-Correlation';
    handles.tdata{9,2} = NCC;
    % Average Difference
    AD = AverageDifference(g_originimg, g_assessimg);
    handles.tdata{10,1} = 'Average Difference';
    handles.tdata{10,2} = AD;
    % Structural Content
    SC = StructuralContent(g_originimg, g_assessimg);
    handles.tdata{11,1} = 'Structural Content';
    handles.tdata{11,2} = SC;
    % Maximum Difference
    MD = MaximumDifference(g_originimg, g_assessimg);
    handles.tdata{12,1} = 'Maximum Difference';
    handles.tdata{12,2} = MD;
    % Normalized Absolute Error
    NAE = NormalizedAbsoluteError(g_originimg, g_assessimg);
    handles.tdata{13,1} = 'Normalized Absolute Error';
    handles.tdata{13,2} = NAE;
    %Laplacian Mean Square Error
    LMSE = LaplacianMeanSquareError(g_originimg, g_assessimg);
    handles.tdata{14,1} = 'Laplacian Mean Square Error';
    handles.tdata{14,2} = LMSE;
    % Structural Similarity Index (SSIM)
    [ssimval, ssimmap] = ssim(g_assessimg,g_originimg);
    handles.tdata{15,1} = 'Structural Similarity Index';
    handles.tdata{15,2} = ssimval;
    % Luminance
    lum = luminance(assessimg);
    handles.tdata{16,1} = 'Luminance';
    handles.tdata{16,2} = lum;
    % Variance
    var = variance(g_assessimg);
    handles.tdata{17,1} = 'Contrast';
    handles.tdata{17,2} = var;
    % Sharpness Index
    si = sharpness_index(g_assessimg,3);
    handles.tdata{18,1} = 'Sharpness Index';
    handles.tdata{18,2} = si;
    % NIQE
    nq = niqe(g_assessimg);
    handles.tdata{19,1} = 'NIQE';
    handles.tdata{19,2} = nq;
    % BRISQUE
    brq = brisque(g_assessimg);
    handles.tdata{20,1} = 'BRISQUE';
    handles.tdata{20,2} = brq;
    % Show result
    set(handles.uitable1,'Data',handles.tdata);
    set(handles.uitable1,'Visible','on');
else
    % show blank table
    msgbox('You didn''t choose reference file!','Error Occurred','error');
    return
end
% do comments
% overall quality
if nq < 3   
    comments = 'Your picture has very high quality! ';
elseif nq >=3 && nq <5
    comments = 'Your picture has normal quality! ';
elseif nq >=5 && nq <8
    comments = 'Your picture has some defect. ';
elseif nq >=8
    comments = 'Your picture has bad quality. ';
end
% sharpness
if si < 300
    comments = strcat(comments, ' It''s a blur, ');
elseif si >=300 && si < 1000
    comments = strcat(comments, ' It''s a not very sharp, ');
elseif si >=1000 && si < 5000
    comments = strcat(comments, ' It''s a sharp, ');
elseif si >=5000
    comments = strcat(comments, ' It''s a very sharp, ');
end
% luminance
if lum < 80
    comments = strcat(comments, ' dark, ');
elseif lum >= 80 && lum < 130
    comments = strcat(comments, ' dim, ');
elseif lum >= 130 && lum < 170
    comments = strcat(comments, ' normal brightness, ');
elseif lum >= 170
    comments = strcat(comments, ' bright, ');
end
% contrast
if var < 50
    comments = strcat(comments, ' low contrast image. ');
elseif var >=50 && var < 200
    comments = strcat(comments, ' normal contrast image. ');
elseif var >= 200
    comments = strcat(comments, ' high contrast image. ');
end
% PSNR
if PSNR < 25
    comments = strcat(comments, ' I can see obvious differences to reference image. ');
elseif PSNR >= 25 && PSNR < 37
    comments = strcat(comments, ' I can see slight differences to reference image. ');
elseif PSNR >= 37
    comments = strcat(comments, ' I can hardly see differences to reference image. ');
end
set(handles.text6,'String',comments);
set(handles.text6,'Visible','on');
% make tdata global
guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originfile
global originpath
global assessfile
global assesspath

%run python face detection code
command = strcat('python3 func/detect_face.py',{' '},originpath,originfile);
[foo number_of_faces_origin] = system(command{1});
if number_of_faces_origin ~= '0'
    %display image with face detection
    axes(handles.axes2)
    image_fd = imread('src/image_fd.jpg');
    imshow(image_fd)
end
%run python face detection code
command = strcat('python3 func/detect_face.py',{' '},assesspath,assessfile);
[foo number_of_faces_assess] = system(command{1});
if number_of_faces_assess ~= '0'
    %display image with face detection
    axes(handles.axes1)
    image_fd = imread('src/image_fd.jpg');
    imshow(image_fd)
end
% get table data
handles.tdata{21,1} = 'Number of Faces';
handles.tdata{21,2} = str2double(number_of_faces_assess);
set(handles.uitable1,'Data',handles.tdata);
guidata(hObject, handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global assessimg
if rem(handles.counter,2) == 1
    % calculate hist
    Red = assessimg(:,:,1);
    [yRed, x] = imhist(Red);
    Green = assessimg(:,:,2);
    [yGreen, y] = imhist(Green);
    Blue = assessimg(:,:,3);
    [yBlue, z] = imhist(Blue);
    % plot hist
    axes(handles.axes3)
    cla(handles.axes3)
    set(handles.uipanel3,'Visible','on')
    set(handles.uipanel2,'Visible','off')
    set(handles.pushbutton6, 'String', 'Hide hist')
    plot(x,yRed,'r')
    hold on
    plot(y,yGreen,'g')
    plot(z,yBlue,'b')
    legend('Red', 'Green', 'Blue')
    set(handles.axes3,'XTick',ceil(linspace(0,255,20)))
    set(handles.axes3,'XTickLabelRotation',45)
    handles.counter = handles.counter + 1;
elseif rem(handles.counter,2) == 0
    set(handles.uipanel3,'Visible','off')
    set(handles.uipanel2,'Visible','on')
    set(handles.pushbutton6, 'String', 'Assessed Histogram')
    handles.counter = handles.counter + 1;
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originimg
if rem(handles.counter,2) == 1
    % calculate hist
    Red = originimg(:,:,1);
    [yRed, x] = imhist(Red);
    Green = originimg(:,:,2);
    [yGreen, y] = imhist(Green);
    Blue = originimg(:,:,3);
    [yBlue, z] = imhist(Blue);
    % plot hist
    axes(handles.axes3)
    cla(handles.axes3)
    set(handles.uipanel3,'Visible','on')
    set(handles.uipanel2,'Visible','off')
    set(handles.pushbutton7, 'String', 'Hide hist')
    plot(x,yRed,'r')
    hold on
    plot(y,yGreen,'g')
    plot(z,yBlue,'b')
    legend('Red', 'Green', 'Blue')
    set(handles.axes3,'XTick',ceil(linspace(0,255,20)))
    set(handles.axes3,'XTickLabelRotation',45)
    handles.counter = handles.counter + 1;
elseif rem(handles.counter,2) == 0
    set(handles.uipanel3,'Visible','off')
    set(handles.uipanel2,'Visible','on')
    set(handles.pushbutton7, 'String', 'Original Histogram')
    handles.counter = handles.counter + 1;
end
guidata(hObject, handles);
