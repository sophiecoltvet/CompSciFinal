function [] = guiPlot()

global gui;

%Setting up plot
    gui.fig = figure('numbertitle','off','name','Plot');
    gui.graph = plot(0,0);
    set(gca,'units','normalized','position',[.075 .075 .475 .8]);

%All edit boxes
    gui.editPlotTitle = uicontrol('style','edit','units','normalized','position',[.8 .9 .175 .075]);
    gui.editXVals = uicontrol('style','edit','units','normalized','position',[.8 .825 .175 .075],'string','');
    gui.editYVals = uicontrol('style','edit','units','normalized','position',[.8 .75 .175 .075],'string','');
    gui.editXAxis = uicontrol('style','edit','units','normalized','position',[.8 .675 .175 .075]);
    gui.editYAxis = uicontrol('style','edit','units','normalized','position',[.8 .6 .175 .075]);
    gui.editXLim1 = uicontrol('style','edit','units','normalized','position',[.8 .525 .085 .075]);
    gui.editXLim2 = uicontrol('style','edit','units','normalized','position',[.89 .525 .085 .075]);
    gui.editYLim1 = uicontrol('style','edit','units','normalized','position',[.8 .45 .085 .075]);
    gui.editYLim2 = uicontrol('style','edit','units','normalized','position',[.89 .45 .085 .075]);

%All text boxes
    gui.textPlotTitle = uicontrol('style','text','units','normalized','position',[.6 .9 .2 .075],...
    'string','Plot Title:','fontsize',13);
    gui.textXVals = uicontrol('style','text','units','normalized','position',[.6 .825 .2 .075],...
        'string','X Values:','fontsize',13);
    gui.textYVals = uicontrol('style','text','units','normalized','position',[.6 .75 .2 .075],...
        'string','Y Values:','fontsize',13);
    gui.textXAxis = uicontrol('style','text','units','normalized','position',[.6 .675 .2 .075],...
        'string','X Axis Label:','fontsize',13);
    gui.textYAxis = uicontrol('style','text','units','normalized','position',[.6 .6 .2 .075],...
        'string','Y Axis Label:','fontsize',13);
    gui.textXLim = uicontrol('style','text','units','normalized','position',[.6 .525 .2 .075],...
        'string','X Limits:','fontsize',13);
    gui.textYLim = uicontrol('style','text','units','normalized','position',[.6 .45 .2 .075],...
        'string','Y Limits:','fontsize',13);
    gui.textColor = uicontrol('style','text','units','normalized','position',[.6 .23 .2 .075],...
        'string','Color:','fontsize',13);
    gui.textLineStyle = uicontrol('style','text','units','normalized','position',[.8 .23 .2 .075],...
        'string','Line Style:','fontsize',13);

%Two push buttons
    gui.plotButton = uicontrol('style','pushbutton','units','normalized','position',[.6 .325 .2 .1],...
        'string','Plot!','fontsize',13,'callback',{@graph}); %button to plot
    gui.resetButton = uicontrol('style','pushbutton','units','normalized','position',[.8 .325 .2 .1],...
        'string','Reset','fontsize',13,'callback',{@reset}); %button to reset

%Color options
    gui.colorButtonGroup = uibuttongroup('units','normalized','position',[.6 .05 .2 .2]);
    gui.radio1 = uicontrol(gui.colorButtonGroup,'style','radiobutton','string','Blue',...
        'units','normalized','position',[.1 .75 .8 .15],'callback',{@color,1});
    gui.radio2 = uicontrol(gui.colorButtonGroup,'style','radiobutton','string','Red',...
        'units','normalized','position',[.1 .55 .8 .15],'callback',{@color,2});
    gui.radio3 = uicontrol(gui.colorButtonGroup,'style','radiobutton','string','Green',...
        'units','normalized','position',[.1 .35 .8 .15],'callback',{@color,3});
    gui.radio2 = uicontrol(gui.colorButtonGroup,'style','radiobutton','string','Magenta',...
        'units','normalized','position',[.1 .15 .8 .15],'callback',{@color,4});
    
%Line style options
    gui.lineStyleButtonGroup = uibuttongroup('units','normalized','position',[.8 .05 .2 .2]);
    gui.radio1 = uicontrol(gui.lineStyleButtonGroup,'style','radiobutton','string','Line',...
        'units','normalized','position',[.1 .75 .8 .15],'callback',{@marker,1});
    gui.radio2 = uicontrol(gui.lineStyleButtonGroup,'style','radiobutton','string','Dashed',...
        'units','normalized','position',[.1 .55 .8 .15],'callback',{@marker,2});
    gui.radio3 = uicontrol(gui.lineStyleButtonGroup,'style','radiobutton','string','Dotted',...
        'units','normalized','position',[.1 .35 .8 .15],'callback',{@marker,3});
    gui.radio2 = uicontrol(gui.lineStyleButtonGroup,'style','radiobutton','string','None',...
        'units','normalized','position',[.1 .15 .8 .15],'callback',{@marker,4});
end

function [] = graph(~,~)

global gui;

%Retrieving all info from edit boxes
    gui.xVals = str2num(get(gui.editXVals,'string'));
    gui.yVals = str2num(get(gui.editYVals,'string'));
    gui.plotTitle = get(gui.editPlotTitle,'string');
    gui.xLabel = get(gui.editXAxis,'string');
    gui.yLabel = get(gui.editYAxis,'string');
    gui.xLim1 = str2num(get(gui.editXLim1,'string'));
    gui.xLim2 = str2num(get(gui.editXLim2,'string'));
    gui.yLim1 = str2num(get(gui.editYLim1,'string'));
    gui.yLim2 = str2num(get(gui.editYLim2,'string'));

%Make sure x values and y values are numbers
if isempty(gui.xVals) == 1 || isempty(gui.yVals) == 1
    msgbox('Please enter numerical values for x and y.','Error!','modal');
    return;
end

%Make sure lengths of x and y arrays are equal
if length(gui.xVals) ~= length(gui.yVals)
    msgbox('Please enter same amount of values for x and y.','Error!','modal');
    return;
end

%Plot values
    gui.graph = plot(gui.xVals,gui.yVals,'o');
    title(gui.plotTitle,'fontsize',25);
    xlabel(gui.xLabel);
    ylabel(gui.yLabel);

%Check if any limit boxes are filled
if ~isempty(gui.xLim1) == 1 || ~isempty(gui.xLim2) == 1 || ~isempty(gui.yLim1) == 1 || ~isempty(gui.yLim2) == 1

%Check if only one of two limit boxes are used
    if xor(isempty(gui.xLim1) == 1, isempty(gui.xLim2) == 1) || xor(isempty(gui.yLim1) == 1, isempty(gui.yLim2) == 1)
        msgbox('Please enter numerical values for both of the limits.','Error!','modal');
        return;
    end
    
%Check if first limit is larger than second
    if gui.xLim1 >= gui.xLim2 || gui.yLim1 >= gui.yLim2
        msgbox('Please enter a larger number for the second limit.','Error!','modal');
        return;
    end
    
%Set x and y lims
    xlim([gui.xLim1 gui.xLim2]);
    ylim([gui.yLim1 gui.yLim2]);

end
end

function [] = reset(~,~)

global gui;

hold off;
gui.graph = plot(0,0);
gui.editPlotTitle.String = '';
gui.editXVals.String = '';
gui.editYVals.String = '';
gui.editXAxis.String = '';
gui.editYAxis.String = '';
gui.editXLim1.String = '';
gui.editXLim2.String = '';
gui.editYLim1.String = '';
gui.editYLim2.String = '';

end

function [] = color(~,~,color)

global gui;

if color == 1       %blue
    gui.graph.Color = 'b';
elseif color == 2       %red
    gui.graph.Color = 'r';
elseif color == 3       %green
    gui.graph.Color = 'g';
elseif color == 4       %magenta
    gui.graph.Color = 'm';
end
end

function [] = marker(~,~,marker)

global gui;

if marker == 1       %line
    gui.graph.LineStyle = '-';
elseif marker == 2       %dashed
    gui.graph.LineStyle = '--';
elseif marker == 3       %circles
    gui.graph.LineStyle = ':';
elseif marker == 4       %stars
    gui.graph.LineStyle = 'none';
end
end