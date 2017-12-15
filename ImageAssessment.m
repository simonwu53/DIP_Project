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

% Last Modified by GUIDE v2.5 15-Dec-2017 14:35:27

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

% Choose default command line output for ImageAssessment
handles.output = hObject;
% add global arguments
handles.counter = 1;
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
[assessfile, assesspath] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.bmp','All Image Files'});
if (assessfile==0 & assesspath==0)
    msgbox('您没有选择文件，请重新选择!','打开文件出错','error');
else
    assessimg=imread([assesspath, assessfile]);
    axes(handles.axes1)
    imshow(assessimg)
    set(handles.pushbutton4,'Enable','on')

end


% --- Executes on button press in 'Original Image'.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originimg
global originfile
global originpath
[originfile, originpath] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.bmp','All Image Files'});
if (originfile==0 & originpath==0)
    msgbox('您没有选择文件，请重新选择!','打开文件出错 COME ON MAN USE ENGLISH!!!! :D','error');
else
    originimg=imread([originpath, originfile]);
    axes(handles.axes2)
    imshow(originimg)
    set(handles.axes2,'Visible','on')
    set(handles.axes2,'XTick','')
    set(handles.axes2,'YTick','')
    set(handles.text3,'Visible','off')
end


% --- Executes on button press in 'Show Image'.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if rem(handles.counter,2) == 1
    % show the panel & change button text
    set(handles.uipanel2,'Visible','on')
    set(handles.pushbutton3,'String','Hide Image')
    handles.counter = handles.counter + 1;
elseif rem(handles.counter,2) == 0
    % hid the panel & change button text
    set(handles.uipanel2,'Visible','off')
    set(handles.pushbutton3,'String','Show Image')
    handles.counter = handles.counter + 1;
end
guidata(hObject, handles);


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
    
    tdata = {}; % table data for all assessment results
    % do calculation
    % Compression ratio
    %[originfile, originpath]
    CR = compression_ratio([originpath,originfile], [assesspath, assessfile]);
    tdata{1,1} = 'Compression Ratio';
    tdata{1,2} = CR;
    % Relative data redundancy  1-1/Cr
    RDR = relative_data_redundancy([originpath,originfile], [assesspath, assessfile]);
    tdata{2,1} = 'Relative Data Redundancy';
    tdata{2,2} = RDR;
    % Mean Square Error(MSE)
    MSE = MeanSquareError(g_originimg, g_assessimg);
    tdata{3,1} = 'Mean Square Error';
    tdata{3,2} = MSE;
    % Root Mean Square Error (RMSE)
    RMSE = MSE^0.5;
    tdata{4,1} = 'Root Mean Square Error';
    tdata{4,2} = RMSE;
    % Signal to Noise Ratio (SNR)
    SNR = signal_to_noise_ratio(g_originimg, g_assessimg);
    tdata{5,1} = 'Signal to noise ratio';
    tdata{5,2} = SNR;
    % Peak Signal to Noise Ratio (PSNR)
    PSNR = PeakSignaltoNoiseRatio(g_originimg, g_assessimg);
    tdata{6,1} = 'Peak Signal to Noise Ratio';
    tdata{6,2} = PSNR;
    % Mean-Square Signal to Noise Ratio (MS-SNR)
    MS_SNR = ms_snr(g_originimg, g_assessimg);
    tdata{7,1} = 'Mean Square Signal to Noise Ratio';
    tdata{7,2} = MS_SNR;
    % Entropy
    
    % Normalized Cross-Correlation
    NCC = NormalizedCrossCorrelation(g_originimg, g_assessimg);
    tdata{9,1} = 'Normalized Cross-Correlation';
    tdata{9,2} = NCC;
    % Average Difference
    AD = AverageDifference(g_originimg, g_assessimg);
    tdata{10,1} = 'Average Difference';
    tdata{10,2} = AD;
    % Structural Content
    SC = StructuralContent(g_originimg, g_assessimg);
    tdata{11,1} = 'Structural Content';
    tdata{11,2} = SC;
    % Maximum Difference
    MD = MaximumDifference(g_originimg, g_assessimg);
    tdata{12,1} = 'Maximum Difference';
    tdata{12,2} = MD;
    % Normalized Absolute Error
    NAE = NormalizedAbsoluteError(g_originimg, g_assessimg);
    tdata{13,1} = 'Normalized Absolute Error';
    tdata{13,2} = NAE;
    %Laplacian Mean Square Error
    LMSE = LaplacianMeanSquareError(g_originimg, g_assessimg);
    tdata{14,1} = 'Laplacian Mean Square Error';
    tdata{14,2} = LMSE;
    % Structural Similarity Index (SSIM)
    [ssimval, ssimmap] = ssim(g_assessimg,g_originimg);
    tdata{15,1} = 'Structural Similarity Index';
    tdata{15,2} = ssimval;
    % Show result
    set(handles.uitable1,'Data',tdata);
    set(handles.uitable1,'Visible','on');
else
    % show blank table
    tdata{1,1} = 'No original image input';
    set(handles.uitable1,'Data',tdata);
    set(handles.uitable1,'Visible','on');
end
% do non referenced assessment


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originfile
global originpath
global assessfile
global assesspath

%command = strcat({'python func/detect_face.py'},{' '},{originpath,originfile})
%system(command)

%axes(handles.axes1)
%imshow(assessimg)

%axes(handles.axes1)
%imshow(assessimg)

