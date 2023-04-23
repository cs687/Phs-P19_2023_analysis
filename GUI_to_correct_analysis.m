function varargout = GUI_to_correct_analysis(varargin)
% GUI_TO_CORRECT_ANALYSIS MATLAB code for GUI_to_correct_analysis.fig
%      GUI_TO_CORRECT_ANALYSIS, by itself, creates a new GUI_TO_CORRECT_ANALYSIS or raises the existing
%      singleton*.
%
%      H = GUI_TO_CORRECT_ANALYSIS returns the handle to a new GUI_TO_CORRECT_ANALYSIS or the handle to
%      the existing singleton*.
%
%      GUI_TO_CORRECT_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TO_CORRECT_ANALYSIS.M with the given input arguments.
%
%      GUI_TO_CORRECT_ANALYSIS('Property','Value',...) creates a new GUI_TO_CORRECT_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_to_correct_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_to_correct_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_to_correct_analysis

% Last Modified by GUIDE v2.5 17-Apr-2023 17:32:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_to_correct_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_to_correct_analysis_OutputFcn, ...
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


% --- Executes just before GUI_to_correct_analysis is made visible.
function GUI_to_correct_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_to_correct_analysis (see VARARGIN)

% Choose default command line output for GUI_to_correct_analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_to_correct_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_to_correct_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_forward.
function push_forward_Callback(hObject, eventdata, handles)
% hObject    handle to push_forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%saving what was done
if isfield(handles,'all_good_channels');
    handles.all_good_channels=[handles.all_good_channels,handles.good_channels_now{end}];
end
handles=rmfield(handles,{'good_channels_now','channels_loc_now'});

if isfield(handles,'all_good_channels');
    to_save=handles.all_good_channels;
    save([handles.data_path,'\subAuto\Data\checked_pos.mat'],'to_save');
end

%Getting Input
handles.pos_now=handles.pos_now+1;

%getting pos names
D=dir([handles.data_path,'\subAuto\2022-03-23\B*']);
handles.pos_names={D.name};
loading_image(hObject,handles)




% --- Executes on button press in push_back.
function push_back_Callback(hObject, eventdata, handles)
% hObject    handle to push_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%saving what was done
if isfield(handles,'all_good_channels');
    handles.all_good_channels=[handles.all_good_channels,handles.good_channels_now{end}];
end
handles=rmfield(handles,{'good_channels_now','channels_loc_now'});

if isfield(handles,'all_good_channels');
    to_save=handles.all_good_channels;
    save([handles.data_path,'\subAuto\Data\checked_pos.mat'],'to_save');
end

%Getting Input
handles.pos_now=handles.pos_now-1;

%getting pos names
D=dir([handles.data_path,'\subAuto\2022-03-23\B*']);
handles.pos_names={D.name};
loading_image(hObject,handles)




function txt_delchannels_Callback(hObject, eventdata, handles)
% hObject    handle to txt_delchannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_delchannels as text
%        str2double(get(hObject,'String')) returns contents of txt_delchannels as a double


% --- Executes during object creation, after setting all properties.
function txt_delchannels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_delchannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_delete.
function push_delete_Callback(hObject, eventdata, handles)
% hObject    handle to push_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
to_del=str2num(handles.txt_delchannels.String);

%Copying last list
handles.good_channels_now{length(handles.good_channels_now)+1}=handles.good_channels_now{length(handles.good_channels_now)};
handles.good_channels_now{length(handles.good_channels_now)}(to_del,:)=[];

handles.channels_loc_now{length(handles.channels_loc_now)+1}=handles.channels_loc_now{length(handles.channels_loc_now)};
handles.channels_loc_now{length(handles.channels_loc_now)}(to_del)=[];

figure(handles.figure1);
imshow(handles.Lc_now);

if ~isempty(handles.channels_loc_now{end})
    xline(handles.channels_loc_now{end},'r','Linewidth',3);
    for i=1:length(handles.channels_loc_now{length(handles.channels_loc_now)})
        text(handles.channels_loc_now{length(handles.channels_loc_now)}(i),50,num2str(i),'FontSize',20,'Color','r');
    end
    
    text(50,size(handles.Lc_now,1)-100,['Bacillus-',str3(handles.pos_now),'seg',str3(handles.pos_now)],'FontSize',20,'Color','r','BackgroundColor','w');
end



guidata(hObject, handles);



% --- Executes on button press in push_undo.
function push_undo_Callback(hObject, eventdata, handles)
% hObject    handle to push_undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Copying last list
if length(handles.good_channels_now)>1
    handles.good_channels_now(end)=[];
    handles.channels_loc_now(end)=[];
    
    figure(handles.figure1);
    imshow(handles.Lc_now);
    
    if ~isempty(handles.channels_loc_now{end})
        xline(handles.channels_loc_now{end},'r','Linewidth',3);
        for i=1:length(handles.channels_loc_now{length(handles.channels_loc_now)})
            text(handles.channels_loc_now{length(handles.channels_loc_now)}(i),50,num2str(i),'FontSize',20,'Color','r');
        end
        
        text(50,size(handles.Lc_now,1)-100,['Bacillus-',str3(handles.pos_now),'seg',str3(handles.pos_now)],'FontSize',20,'Color','r','BackgroundColor','w');
    end
end



guidata(hObject, handles);




% --- Executes on button press in push_start.
function push_start_Callback(hObject, eventdata, handles)

if isfield(handles,'data_path')
    handles=rmfield(handles,{'data_path','pos_now','pos_names','good_channels','good_channels_now','channels_loc_now','Lc_now','pos_now','frame_now'});
end

if isfield(handles,'all_good_channels')
    handles=rmfield(handles,'all_good_channels');
end


% hObject    handle to push_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% data_main_path='\\slcu.cam.ac.uk\data\Microscopy\TeamJL\Chris\movies\paulsson_JLB259\';
% handles.data_path={[data_main_path,'2023-03-08'],...
%            [data_main_path,'2023-03-30'],...
%            [data_main_path,'2023-04-05']};
% 
% handles.conditions_names={'JLB259_0uM',...
%                   'JLB259_2uM',...
%                   'JLB259_3uM',...
%                   'JLB259_4uM',...
%                   'JLB259_5uM',...
%                   'JLB259_6uM',...
%                   'JLB259_7uM',...
%                   'JLB259_8uM',...
%                   'JLB259_9uM',...
%                   'JLB259_10uM',...
%                   'JLB259_11uM',...
%                   'JLB259_12uM',...
%                   };


%Getting Input
handles.data_path=handles.txt_path.String;
handles.pos_now=str2num(handles.txt_firstpos.String);

%getting frame now
D=dir([handles.data_path,'\subAuto\2022-03-23\Bacillus-',str3(handles.pos_now),'\segmentation\*.mat']);
if str2num(handles.txt_lastframe.String)==0
    handles.frame_now=length(D);
else
    handles.frame_now=str2num(handles.txt_lastframe.String);
end

%getting pos names
D=dir([handles.data_path,'\subAuto\2022-03-23\B*']);
handles.pos_names={D.name};
loading_image(hObject,handles);



function txt_firstpos_Callback(hObject, eventdata, handles)
% hObject    handle to txt_firstpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_firstpos as text
%        str2double(get(hObject,'String')) returns contents of txt_firstpos as a double


% --- Executes during object creation, after setting all properties.
function txt_firstpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_firstpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_path_Callback(hObject, eventdata, handles)
% hObject    handle to txt_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_path as text
%        str2double(get(hObject,'String')) returns contents of txt_path as a double


% --- Executes during object creation, after setting all properties.
function txt_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_delall.
function push_delall_Callback(hObject, eventdata, handles)
% hObject    handle to push_delall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of push_delall


%Copying last list
handles.good_channels_now{length(handles.good_channels_now)+1}=handles.good_channels_now{length(handles.good_channels_now)};
handles.good_channels_now{end}=[];

handles.channels_loc_now{length(handles.channels_loc_now)+1}=handles.channels_loc_now{length(handles.channels_loc_now)};
handles.channels_loc_now{end}=[];

figure(handles.figure1);
imshow(handles.Lc_now);

if ~isempty(handles.channels_loc_now{end})
    xline(handles.channels_loc_now{end},'r','Linewidth',3);
    for i=1:length(handles.channels_loc_now{length(handles.channels_loc_now)})
        text(handles.channels_loc_now{length(handles.channels_loc_now)}(i),50,num2str(i),'FontSize',20,'Color','r');
    end
    
    text(50,size(handles.Lc_now,1)-100,['Bacillus-',str3(handles.pos_now),'seg',str3(handles.pos_now)],'FontSize',20,'Color','r','BackgroundColor','w');
end

guidata(hObject, handles);




function txt_lastframe_Callback(hObject, eventdata, handles)
% hObject    handle to txt_lastframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_lastframe as text
%        str2double(get(hObject,'String')) returns contents of txt_lastframe as a double


% --- Executes during object creation, after setting all properties.
function txt_lastframe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_lastframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function loading_image(hObject,handles)
%function to load image

%loading first pos to get channel pos
load([handles.data_path,'\subAuto\2022-03-23\Bacillus-',str3(handles.pos_now),'\segmentation\Bacillus-',str3(handles.pos_now),'seg001.mat'],'Lc')
[~,loc]=findpeaks(sum(Lc),'MinPeakDistance',200);

%preparing image
figure(handles.figure1);

if exist([handles.data_path,'\subAuto\2022-03-23\Bacillus-',str3(handles.pos_now),'\segmentation\Bacillus-',str3(handles.pos_now),'seg',str3(handles.frame_now),'.mat'])
    load([handles.data_path,'\subAuto\2022-03-23\Bacillus-',str3(handles.pos_now),'\segmentation\Bacillus-',str3(handles.pos_now),'seg',str3(handles.frame_now),'.mat'],'Lc');
else
    Lc=zeros(683,2348);
end
imshow(Lc);
xline(loc,'r','Linewidth',3);
% vline(loc,'color','r','Linewidth',3);
for i=1:length(loc)
    text(loc(i),50,num2str(i),'FontSize',20,'Color','r');
end

text(50,size(Lc,1)-100,['Bacillus-',str3(handles.pos_now),'seg',str3(handles.frame_now)],'FontSize',20,'Color','r','BackgroundColor','w');

handles.good_channels=[];
handles.good_channels_now{1}=zeros(length(loc),2);
handles.channels_loc_now{1}=loc;
for i=1:length(loc)
    handles.good_channels_now{1}(i,1)=handles.pos_now;
    handles.good_channels_now{1}(i,2)=i;
end
handles.Lc_now=Lc;
guidata(hObject, handles);
