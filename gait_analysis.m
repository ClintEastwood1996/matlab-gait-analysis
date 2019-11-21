function varargout = gait_analysis(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gait_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @gait_analysis_OutputFcn, ...
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

function gait_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

axes(handles.axes11);
imshow('1angle.png');
axes(handles.axes12);
imshow('2angle.png');
axes(handles.axes13);
imshow('3angle.png');


function varargout = gait_analysis_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function figure1_CloseRequestFcn(hObject, eventdata, handles)

delete(hObject);


function pushbutton_get_file1_Callback(hObject, eventdata, handles)
file_name=uigetfile({'*.mp4;*.AVI;'},'Choose file');

if file_name ~= 0
    set(handles.pushbutton_get_file1, 'Enable', 'Off');
    video = VideoReader(file_name);
    frameNo = 1;
    [angle1, user_cent] = main_f(handles,video,frameNo);
    assignin('base','angle1',angle1);
    assignin('base','user_cent',user_cent);
    step_loop(handles,angle1,1,user_cent); 
end


function pushbutton_get_file2_Callback(hObject, eventdata, handles)
file_name=uigetfile({'*.mp4;*.AVI;'},'Choose file');

if file_name ~= 0
    set(handles.pushbutton_get_file2, 'Enable', 'Off');
    video = VideoReader(file_name);
    frameNo = 1;
    [angle2 user_cent] = main_f(handles,video,frameNo);
    assignin('base','angle2',angle2);
    assignin('base','user_cent',user_cent);
    step_loop(handles,angle2,2,user_cent);   
end
        

