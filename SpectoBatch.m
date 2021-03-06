function varargout = SpectoBatch(varargin)
% SPECTOBATCH MATLAB code for SpectoBatch.fig
%      SPECTOBATCH, by itself, creates a new SPECTOBATCH or raises the existing
%      singleton*.
%
%      H = SPECTOBATCH returns the handle to a new SPECTOBATCH or the handle to
%      the existing singleton*.
%
%      SPECTOBATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECTOBATCH.M with the given input arguments.
%
%      SPECTOBATCH('Property','Value',...) creates a new SPECTOBATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SpectoBatch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SpectoBatch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SpectoBatch

% Last Modified by GUIDE v2.5 03-Aug-2020 13:02:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SpectoBatch_OpeningFcn, ...
    'gui_OutputFcn',  @SpectoBatch_OutputFcn, ...
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





% d = uigetdir(pwd, 'Select a folder');
% files = dir(fullfile(d, '*.wav'));
%

% --- Executes just before SpectoBatch is made visible.
function SpectoBatch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SpectoBatch (see VARARGIN)

% Choose default command line output for SpectoBatch

handles.sD = NaN;

handles.Tutor = NaN;

handles.index = NaN;

handles.output = hObject;

handles.valid1 = false;

handles.valid2 = false;

handles.hasTutor = false;

handles.dataIndex = 1;

handles.data = struct('name', 'tutor', 'sim', 'acc');

% spectrogram(data, hamming(1024), 1000, 1024,fs,'yaxis');
% saveas(gcf, 'saiaio.png')
% plot(saiaio)

wfiles = [];


% axes(handles.axes1);
% plot(sin(0:.01:10));
%
%
% saiaio = imread('saiaio.png');
% axes(handles.axes2)
% image(saiaio)
% axis off
% axis image

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SpectoBatch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SpectoBatch_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2

% image(saiaio);



% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound;



[x, ~] = size(handles.files);

x = x - handles.index;

if x > 0
    handles.valid1 = true;
    axes(handles.axes1);
    [data, fs] = audioread(handles.files(1 + handles.index).name);
    spectrogram(data(:,1), hamming(1024), 1000, 1024,fs,'yaxis');
    ylim([0,10]);
    title(handles.files(1 + handles.index).name);
    %     handles.dateL.String = handles.files(1 + handles.index).date;
    set(handles.dateL, 'String', handles.files(1+handles.index).date);
    
    
else
    handles.valid1 = false;
    axes(handles.axes1);
    plot(0:.1:10);
    title('No Spectrogram');
    handles.dateL.String = 'No Date';
end
if x > 1
    handles.valid2 = true;
    axes(handles.axes2);
    [data, fs] = audioread(handles.files(2 + handles.index).name);
    spectrogram(data(:,1), hamming(1024), 1000, 1024,fs,'yaxis');
    ylim([0,10]);
    title(handles.files(2 + handles.index).name);
    handles.dateR.String = handles.files(2 + handles.index).date;
else
    handles.valid2 = false;
    axes(handles.axes2);
    plot(0:.1:10);
    title('No Spectrogram');
    handles.dateR.String = 'No Date';
end
handles.index = handles.index + 2;


guidata(hObject, handles);






% --- Executes during object creation, after setting all properties.
function next_CreateFcn(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

d = uigetdir(pwd, 'Select a folder');

if d ~= 0
    
    
    handles.files = dir(fullfile(d, '*.wav'));
    handles.dir.String = d;
    handles.index = 0;
    
    cd(d);
    
    
    [x, ~] = size(handles.files);
    
    if x > 0
        handles.valid1 = true;
        axes(handles.axes1);
        [data, fs] = audioread(handles.files(1).name);
        spectrogram(data(:,1), hamming(1024), 1000, 1024,fs,'yaxis');
        ylim([0,10]);
        colormap jet;
        title(handles.files(1).name);
        handles.dateL.String = handles.files(1).date;
        
        %     handles.player = audioplayer(data, fs);
        
    else
        handles.valid1 = false;
        axes(handles.axes1);
        plot(0:.1:10);
        title('No Spectrogram');
        handles.dateL.String = 'No Date';
    end
    if x > 1
        handles.valid2 = true;
        axes(handles.axes2);
        [data, fs] = audioread(handles.files(2).name);
        spectrogram(data(:,1), hamming(1024), 1000, 1024,fs,'yaxis');
        ylim([0,10]);
        title(handles.files(2).name);
        handles.dateR.String = handles.files(2).date;
    else
        handles.valid2 = false;
        axes(handles.axes2);
        plot(0:.1:10);
        title('No Spectrogram');
        handles.dateR.String = 'No Date';
    end
    
    handles.index = 2;
    
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in prev.
function prev_Callback(hObject, eventdata, handles)
% hObject    handle to prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound;

[x, ~] = size(handles.files);

handles.index = handles.index - 4;

x = x - handles.index;

if x > 0
    handles.valid1 = true;
    axes(handles.axes1);
    [data, fs] = audioread(handles.files(1 + handles.index).name);
    spectrogram(data(:,1), hamming(1024), 1000, 1024,fs,'yaxis');
    ylim([0,10]);
    title(handles.files(1 + handles.index).name);
    handles.dateL.String = handles.files(1 + handles.index).date;
else
    handles.valid1 = false;
    axes(handles.axes1);
    plot(0:.1:10);
    title('No Spectrogram');
    handles.dateL.String = 'No Date';
end
if x > 1
    handles.valid2 = true;
    axes(handles.axes2);
    [data, fs] = audioread(handles.files(2 + handles.index).name);
    spectrogram(data(:,1), hamming(1024), 1000, 1024,fs,'yaxis');
    ylim([0,10]);
    title(handles.files(2 + handles.index).name);
    handles.dateR.String = handles.files(2 + handles.index).date;
else
    handles.valid2 = false;
    axes(handles.axes2);
    plot(0:.1:10);
    title('No Spectrogram');
    handles.dateR.String = 'No Date';
end
handles.index = handles.index + 2;
guidata(hObject, handles);


% --- Executes on button press in playL.
function playL_Callback(hObject, eventdata, handles)
% hObject    handle to playL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% stop(handles.player);
clear sound;
[data, fs] = audioread(handles.files(handles.index-1).name);
sound(data, fs);







% --- Executes on button press in playR.
function playR_Callback(hObject, eventdata, handles)
% hObject    handle to playR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% stop(handles.player);
% [data, fs] = audioread(handles.files(handles.index).name);
% player = audioplayer(data, fs);
% play(player);
% handles.player = player;


clear sound;
[data, fs] = audioread(handles.files(handles.index).name);
sound(data, fs);


% --- Executes on button press in stahp.
function stahp_Callback(hObject, eventdata, handles)
% hObject    handle to stahp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;


% --- Executes on button press in saveL.
function saveL_Callback(hObject, eventdata, handles)
% hObject    handle to saveL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isnan(handles.sD)
    sDir_Callback(hObject, eventdata, handles);
    
end



[sdata, sfs] = audioread(handles.files(handles.index - 1).name);

cd(handles.sD);

audiowrite(handles.files(handles.index - 1).name, sdata, sfs); 

cd(handles.dir.String);

guidata(hObject, handles);





% --- Executes on button press in saveR.
function saveR_Callback(hObject, eventdata, handles)
% hObject    handle to saveR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if isnan(handles.sD)
%     sDir_Callback(hObject, eventdata, handles);
%     
% end

if isnan(handles.sD)
    sDir_Callback(hObject, eventdata, handles);    
end


[sdata, sfs] = audioread(handles.files(handles.index).name);

cd(handles.sD);

audiowrite(handles.files(handles.index).name, sdata, sfs); 

cd(handles.dir.String);

guidata(hObject, handles);



% --- Executes on button press in saveAsL.
function saveAsL_Callback(hObject, eventdata, handles)
% hObject    handle to saveAsL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% s = uigetdir(pwd, 'Select a folder');
% 
% 
% guidata(hObject, handles);

[filename, path] = uiputfile(handles.files(handles.index-1).name);

if path ~= 0
    
    [data, fs] = audioread(handles.files(handles.index - 1).name);
    cd(path);
    audiowrite(filename, data, fs);
    
end


cd(handles.dir.String);

guidata(hObject, handles);




% --- Executes on button press in saveAsR.
function saveAsR_Callback(hObject, eventdata, handles)
% hObject    handle to saveAsR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, path] = uiputfile(handles.files(handles.index).name);

if path ~= 0
    
    [data, fs] = audioread(handles.files(handles.index).name);
    cd(path);
    audiowrite(filename, data, fs);
    
end


cd(handles.dir.String);

guidata(hObject, handles);


% --- Executes on button press in sDir.
function sDir_Callback(hObject, eventdata, handles)
% hObject    handle to sDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = uigetdir(pwd, 'Select a folder');

if s ~= 0
    handles.sD = s;
    handles.sDirT.String = handles.sD;
end


guidata(hObject, handles);


% --- Executes on button press in tSong.
function tSong_Callback(hObject, eventdata, handles)
% hObject    handle to tSong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[tut, path] = uigetfile('samba.wav');
if tut ~= 0
    handles.hasTutor = true;
    handles.Tutor = SAT_sound([path tut]);
    handles.tutS.String = tut;
end



guidata(hObject, handles);





% --- Executes on button press in simL.
function simL_Callback(hObject, eventdata, handles)
% hObject    handle to simL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% x = SAT_sound(handles.files


if ~handles.hasTutor
    errordlg('Select Tutor Song First');
elseif ~handles.valid1
    errordlg('Left File Not Selected');
else 
    
    clear SAT_score;
    
    sound1 = SAT_sound([handles.dir.String '\' handles.files(handles.index - 1).name]);
    SAT_similarity(sound1, handles.Tutor);
    
    handles.data(handles.dataIndex).name = handles.files(handles.index - 1).name;
    handles.data(handles.dataIndex).tutor = handles.tutS.String;
    
    pause(1000);
     while (~exist('SAT_score', 'var'))
     end
    
    handles.data(handles.dataIndex).sim = SAT_score.similarity;
    handles.data(handles.dataIndex).acc = SAT_score.accuracy;
    
    clear SAT_score;
    
    handles.dataIndex = handles.dataIndex + 1;
end





guidata(hObject, handles);



% --- Executes on button press in simR.
function simR_Callback(hObject, eventdata, handles)
% hObject    handle to simR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveAll.
function saveAll_Callback(hObject, eventdata, handles)
% hObject    handle to saveAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, path] = uiputfile('output.mat');

if path ~= 0
    cd(path);
    save(filename, handles.data);
end


cd(handles.dir.String);

guidata(hObject, handles);




