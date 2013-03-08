function varargout = GUITEST(varargin)
% GUITEST M-file for GUITEST  .fig
%      GUITEST  , by itself, creates a new GUITEST   or raises the existing
%      singleton*.
%
%      H = GUITEST   returns the handle to a new GUITEST   or the handle to
%      the existing singleton*.
%
%      GUITEST  ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEST  .M with the given input arguments.
%
%      GUITEST  ('Property','Value',...) creates a new GUITEST   or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUITEST  _OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUITEST  _OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUITEST  

% Last Modified by GUIDE v2.5 10-Sep-2012 14:09:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUITEST  _OpeningFcn, ...
                   'gui_OutputFcn',  @GUITEST  _OutputFcn, ...
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


% --- Executes just before GUITEST   is made visible.
function GUITEST  _OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUITEST   (see VARARGIN)

% Choose default command line output for GUITEST  
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUITEST   wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUITEST  _OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Block_Callback(hObject, eventdata, handles)
% hObject    handle to Block (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Block as text
%        str2double(get(hObject,'String')) returns contents of Block as a double
Block = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function Block_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Block (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fold_IN_Callback(hObject, eventdata, handles)
% hObject    handle to Fold_IN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fold_IN as text
%        str2double(get(hObject,'String')) returns contents of Fold_IN as a double
Fold_IN = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function Fold_IN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fold_IN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channel_Callback(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel as text
%        str2double(get(hObject,'String')) returns contents of channel as a double
channel = num2str(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PSTH_TEST_GUI.



function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
% Fun=popup_sel_index;



function STIM_Callback(hObject, eventdata, handles)
% hObject    handle to STIM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of STIM as text
%        str2double(get(hObject,'String')) returns contents of STIM as a double
STIM = num2str(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function STIM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to STIM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function PRE_TIME_Callback(hObject, eventdata, handles)
% hObject    handle to PRE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PRE as text
%        str2double(get(hObject,'String')) returns contents of PRE as a double
PRE_TIME = str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function PRE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PRE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function POST_TIME_Callback(hObject, eventdata, handles)
% hObject    handle to POST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of POST as text
%        str2double(get(hObject,'String')) returns contents of POST as a double
POST_TIME = str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function POST_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bin_Callback(hObject, eventdata, handles)
% hObject    handle to BIN_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BIN_S as text
%        str2double(get(hObject,'String')) returns contents of BIN_S as a double
bin = str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function BIN_S_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BIN_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T1_Callback(hObject, eventdata, handles)
% hObject    handle to T1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1 as text
%        str2double(get(hObject,'String')) returns contents of T1 as a double
T1 = str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function T1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2_Callback(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2 as text
%        str2double(get(hObject,'String')) returns contents of T2 as a double
T2 = str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function T2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu1_Callback(hObject, eventdata, handles)


function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'PSTH', 'Size Tunning', 'Position Tunning', 'Azimuth Tunning', 'Inplane Tunning','Single PSTH/Raster'});



function OBJ_Callback(hObject, eventdata, handles)
% hObject    handle to POS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of POS as text
%        str2double(get(hObject,'String')) returns contents of POS as a double
OBJ = num2str(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function OBJ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function POS_Callback(hObject, eventdata, handles)
% hObject    handle to OBJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OBJ as text
%        str2double(get(hObject,'String')) returns contents of OBJ as a double
POS = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function POS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OBJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SIZ_Callback(hObject, eventdata, handles)
% hObject    handle to SIZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SIZ as text
%        str2double(get(hObject,'String')) returns contents of SIZ as a double
SIZ = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function SIZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SIZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end







function PSTH_TEST_GUI_Callback(hObject, eventdata, handles)
% hObject    handle to PSTH_TEST_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fold_IN=get(handles.Fold_IN,'String');
NE=str2num(get(handles.channel,'String'));
Block=get(handles.Block,'String');
OB=str2num(get(handles.STIM,'String'));
Fun = get(handles.popupmenu1, 'Value');

%OBJ = get(handles.OBJ, 'Value');
%POS = get(handles.POS, 'Value');
%SIZ = get(handles.SIZ, 'Value');
%AZM = get(handles.AZM, 'Value');
%INP = get(handles.INP, 'Value');

OBJ = str2num(get(handles.OBJ, 'String'));
POS = str2num(get(handles.POS, 'String'));
SIZ = str2num(get(handles.SIZ, 'String'));
AZM = str2num(get(handles.AZM, 'String'));
INP = str2num(get(handles.INP, 'String'));
BIN = str2num(get(handles.BIN, 'String'));
T1 = str2num(get(handles.edit24, 'String'));
T2 = str2num(get(handles.edit25, 'String'));
Objects_Demo_inv_rec



function POS_Callback(hObject, eventdata, handles)
% hObject    handle to POS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of POS as text
%        str2double(get(hObject,'String')) returns contents of POS as a double


% --- Executes during object creation, after setting all properties.
function POS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function OBJ_Callback(hObject, eventdata, handles)
% hObject    handle to OBJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OBJ as text
%        str2double(get(hObject,'String')) returns contents of OBJ as a double


% --- Executes during object creation, after setting all properties.
function OBJ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OBJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SIZ_Callback(hObject, eventdata, handles)
% hObject    handle to SIZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SIZ as text
%        str2double(get(hObject,'String')) returns contents of SIZ as a double


% --- Executes during object creation, after setting all properties.
function SIZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SIZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AZM_Callback(hObject, eventdata, handles)
% hObject    handle to AZM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AZM as text
%        str2double(get(hObject,'String')) returns contents of AZM as a double


% --- Executes during object creation, after setting all properties.
function AZM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AZM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function INP_Callback(hObject, eventdata, handles)
% hObject    handle to INP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of INP as text
%        str2double(get(hObject,'String')) returns contents of INP as a double


% --- Executes during object creation, after setting all properties.
function INP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to INP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AZM.
function AZM_Callback(hObject, eventdata, handles)
% hObject    handle to AZM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AZM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AZM


% --- Executes during object creation, after setting all properties.
function AZM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AZM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in INP.
function INP_Callback(hObject, eventdata, handles)
% hObject    handle to INP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns INP contents as cell array
%        contents{get(hObject,'Value')} returns selected item from INP


% --- Executes during object creation, after setting all properties.
function INP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to INP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BIN_Callback(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1 as text
%        str2double(get(hObject,'String')) returns contents of t1 as a double


% --- Executes during object creation, after setting all properties.
function BIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to INP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of INP as text
%        str2double(get(hObject,'String')) returns contents of INP as a double


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to INP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SIZ_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double

% --- Executes during object creation, after setting all properties.
function SIZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fold_IN=get(handles.Fold_IN,'String');
Block=get(handles.Block,'String');

cd([Fold_IN,'/',num2str(Block)])

[filename1 foldername1]=uiputfile
load([Fold_IN,'/',num2str(Block),'/TMP/tun.mat'])
save([foldername1 filename1,'.mat'],'TUN','TUN_Bl','size_set','Fano')



