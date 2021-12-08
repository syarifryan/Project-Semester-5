%                               431-400 Year Long Project 
%                           LA1 - Medical Image Processing 2003
%  Supervisor     :  Dr Lachlan Andrew
%  Group Members  :  Alister Fong    78629   a.fong1@ugrad.unimelb.edu.au
%                    Lee Siew Teng   102519  s.lee1@ugrad.unimelb.edu.au
%                    Loh Jien Mei    103650  j.loh1@ugrad.unimelb.edu.au
%
%  File and function name : threshold
%  Version                : 1.0
%  Date of completion     : 5 May 2003   
%  Written by    :   Alister Fong    78629   a.fong1@ugrad.unimelb.edu.au
%
%  Description   :   This is the GUI for the program threshold to help 
%                    visualise the effects of thresholding between the 
%                    given values
%
%  Program files : threshold.m, threshold.fig, threshold_grayscale_image.m
%
%  To Run >> threshold

function varargout = threshold(varargin)
% THRESHOLD Application M-file for threshold.fig
%    FIG = THRESHOLD launch threshold GUI.
%    THRESHOLD('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 05-May-2003 21:43:40

%clear;
if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);

	if nargout > 0
		varargout{1} = fig;
	end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Additional Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global global_max_value;
global global_min_value;
global_max_value = 255;
global_min_value = 0;

slider_step(1) = 1/255;
slider_step(2) = 10/255;
set(handles.slider_Max,'sliderstep',slider_step,'max',255,'min',0,'Value',global_max_value);
set(handles.slider_Min,'sliderstep',slider_step,'max',255,'min',0,'Value',global_min_value);
set(handles.edit_Max,'string',global_max_value);
set(handles.edit_Min,'string',global_min_value);

set(handles.listbox_DisplayScale,'HandleVisibility','off','Visible','off');
set(handles.text3,'Visible','off');       
set(handles.axes1,'Visible','off');
set(handles.axes2,'Visible','off');

global loaded_image;
global image_filename;
global selected_scale;
global axes1_image;
global axes2_image;
global selected_scale;
loaded_image =[];
image_filename ='';
axes1_image = [];
axes2_image = [];
selected_scale = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
	catch
		disp(lasterr);
	end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.


% --------------------------------------------------------------------
function varargout = slider_Max_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.slider_Max.
global global_max_value;
global global_min_value;

set(handles.text_messages,'string','');
max_value = round(get(handles.slider_Max,'Value'));
if (max_value >= global_min_value)
    global_max_value = max_value;
    set(handles.edit_Max,'string',global_max_value);    
end
set(handles.slider_Max,'Value',global_max_value);
display_threshold(h, eventdata, handles, varargin);

% --------------------------------------------------------------------
function varargout = slider_Min_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.slider_Min.
global global_max_value;
global global_min_value;

set(handles.text_messages,'string','');
min_value = round(get(handles.slider_Min,'Value'));
if (min_value <= global_max_value)
    global_min_value = min_value;
    set(handles.edit_Min,'string',global_min_value);    
end
set(handles.slider_Min,'Value',global_min_value);
display_threshold(h, eventdata, handles, varargin);

% --------------------------------------------------------------------
function varargout = edit_Max_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_Max.
global global_max_value;
global global_min_value;

set(handles.text_messages,'string','');
max_value = str2double(get(handles.edit_Max,'string'));
if ((max_value <= 255) & (max_value >= global_min_value) & (max_value ~= NaN))
    global_max_value = round(max_value);
    set(handles.slider_Max,'Value',global_max_value);    
end
set(handles.edit_Max,'string',global_max_value);
display_threshold(h, eventdata, handles, varargin);

% --------------------------------------------------------------------
function varargout = edit_Min_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_Min.
global global_max_value;
global global_min_value;

set(handles.text_messages,'string','');
min_value = str2double(get(handles.edit_Min,'string'));
if ((min_value >= 0) & (min_value <= global_max_value) & (min_value ~= NaN))
    global_min_value = round(min_value);
    set(handles.slider_Min,'Value',global_min_value);    
end
set(handles.edit_Min,'string',global_min_value);
display_threshold(h, eventdata, handles, varargin);

% --------------------------------------------------------------------
function varargout = edit_Filename_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_Filename.


% --------------------------------------------------------------------
function varargout = pushbutton_LoadFile_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_LoadFile.
global loaded_image;
global image_filename;
global selected_scale;
global axes1_image;

set(handles.text_messages,'string','');
filename = get(handles.edit_Filename,'string');
if (strcmp(filename,image_filename) == 0)
    reply = questdlg('Sure that u want to load this file?','Loading File...','Yes','No','No');
    if (strcmp(reply,'Yes') == 1)
        try %Checks the properties of the file
            info = imfinfo(filename);
            switch info.ColorType
            case 'truecolor'    
                errormessage = '';
                set(handles.listbox_DisplayScale,'HandleVisibility','off','Visible','on');
                set(handles.text3,'Visible','on');                
                selected_scale = 1;
            case 'grayscale'    
                errormessage = 'This is a GRAYSCALE image. Program accepts TRUECOLOR only';
                set(handles.listbox_DisplayScale,'HandleVisibility','off','Visible','off');
                set(handles.text3,'Visible','off');                
                selected_scale = 5;
            case 'indexed'   
                errormessage = 'This is a INDEX image. Program accepts TRUECOLOR only';
            otherwise
                errormessage = 'Unknown image color system';
            end
        catch
            errormessage = 'This is NOT and IMAGE file';    
        end
        if isempty(errormessage)
            try
                loaded_image = imread(filename);
                axes(handles.axes1)
                set(handles.axes1,'HandleVisibility','on','Visible','on','Units','pixels');
                warning off;
                imshow(loaded_image);                
                warning on;
                set(handles.axes1,'HandleVisibility','off');
                axes1_image = loaded_image;
                image_filename = filename;
            catch
                errormessage = 'Error reading and displaying image file';
            end
        end
        
        if ~isempty(errormessage)
            set(handles.text_messages,'string',errormessage);
        end
    end
end


% --------------------------------------------------------------------
function varargout = listbox_DisplayScale_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.listbox_DisplayScale.
global loaded_image;
global selected_scale;
global axes1_image;

set(handles.text_messages,'string','');
val = get(handles.listbox_DisplayScale,'Value');
axes(handles.axes1);
set(handles.axes1,'HandleVisibility','on','Visible','on','Units','pixels');
errormessage = '';
try
    switch val
    case 1 %Full colour
        axes1_image = loaded_image;
        selected_scale = 1;
        set(handles.text4,'string','Full colour');
    case 2 %Red scale
        axes1_image = loaded_image(:,:,1);                
        selected_scale = 2;
        set(handles.text4,'string','Red scale');
    case 3 %Green scale
        axes1_image = loaded_image(:,:,2);                
        selected_scale = 3;
        set(handles.text4,'string','Green scale');
    case 4 %Blue scale
        axes1_image = loaded_image(:,:,3);                
        selected_scale = 4;
        set(handles.text4,'string','Blue scale');
    otherwise
        errormessage = 'Invalid selection';    
    end
    if isempty(errormessage)        
        set(handles.text_messages,'string','Displaying Axes1 image');
        warning off;
        imshow(axes1_image);
        warning on;
        set(handles.text_messages,'string','');
    end
catch
    errormessage = 'Error viewing selected scale';
end
set(handles.axes1,'HandleVisibility','off');
if ~isempty(errormessage)
    set(handles.text_messages,'string',errormessage);
end


% --------------------------------------------------------------------
%function varargout = pushbutton_threshold_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_threshold.
function display_threshold(h, eventdata, handles, varargin)
global global_max_value;
global global_min_value;
global axes1_image;
global axes2_image;
global selected_scale;

set(handles.text_messages,'string','');
axes(handles.axes2);
set(handles.axes2,'HandleVisibility','on','Visible','on','Units','pixels');
if (selected_scale ~= 1)
    set(handles.text_messages,'string','Finding thresholding regions');
    axes2_image = threshold_grayscale_image(axes1_image,global_min_value,global_max_value);
    message = strcat('Thresholded image between  ',num2str(global_min_value),' and  ',...
                     num2str(global_max_value)); 
    set(handles.text5,'string',message);
    try
        set(handles.text_messages,'string','Displaying Axes2 image');
        warning off;
        imshow(axes2_image);
        warning on;
        set(handles.text_messages,'string','');
    catch
        set(handles.text_messages,'string','Error displaying Axes2');
    end
end
set(handles.axes2,'HandleVisibility','off');


% --------------------------------------------------------------------
function varargout = pushbutton_Overlap_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_Overlap.
global axes1_image;
global axes2_image;
global selected_scale;

set(handles.text_messages,'string','');
%if (~isempty(axes1_image) & ~isempty(axes2_image) & (selected_scale ~= 1)) 
if (~isempty(axes1_image) & ~isempty(axes2_image)) 
    figure;
    clf;
    set(handles.text_messages,'string','Displaying images');
    if (selected_scale == 1)
        overlap_image(:,:,1) = uint8(double(axes1_image(:,:,1)) .* double(axes2_image));      
        overlap_image(:,:,2) = uint8(double(axes1_image(:,:,2)) .* double(axes2_image));      
        overlap_image(:,:,3) = uint8(double(axes1_image(:,:,3)) .* double(axes2_image));      
    else
        overlap_image = uint8(double(axes2_image) .* double(axes1_image));
    end
    
    try
        warning off;
        imshow(overlap_image);
        warning on;
        set(handles.text_messages,'string','');
    catch
        set(handles.text_messages,'string','Error displaying Overlaping images');
    end
end


% --------------------------------------------------------------------
function varargout = pushbutton_save_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_save.
global axes2_image;
if ~isempty(axes2_image)
%    save_as_file = strcat(get(handles.edit_Save_As,'string'),'.tif');
    save_as_file = get(handles.edit_Save_As,'string');
    message = strcat('Are You Sure That You Want To Save As : ',save_as_file);
    reply = questdlg(message,'Saving File...','Yes','No','No');
    if (strcmp(reply,'Yes') == 1)
        set(handles.text_messages,'string','Starting to save thresholded image');
        try
            imwrite(axes2_image,save_as_file);
            set(handles.text_messages,'string','');
            msgbox('Save Completed','','none');
        catch
            set(handles.text_messages,'string',strcat('Error saving into ',save_as_file));
        end
    end
end



% --------------------------------------------------------------------
function varargout = edit_Save_As_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_Save_As.
