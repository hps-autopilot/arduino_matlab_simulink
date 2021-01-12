% Make sure you have the 'Simulink Support Package for Arduino Hardware' Add-On before you get started:
%     Add-Ons > Get Add-Ons > Simulink Support Package for Arduino Hardware

close all;
clear all;
clc;

%% Arduino to MATLAB

arduino = serial('COM5','BaudRate',9600);
fopen(arduino); % open the arduino as if it were a file

x = linspace(1,100);    % plot axis
for i = 1:length(x)
	y ( i ) = fscanf ( arduino , '% d' );   % '% d' = receive decimal values
end

fclose(arduino);    % close arduino connection

% test - make plot
disp('making plot..')
plot(x,y);
    % should make a positively linearly increasing plot

%% MATLAB to Arduino

answer = 1; % this is where we'll store the user's answer
arduino = serial('COM5','BaudRate',9600); % create serial communication object on port COM5

fopen(arduino); % initiate arduino communication
while answer
    fprintf(arduino,'%s',char(answer)); % send answer variable content to arduino
    answer=input('Enter led value 1 or 2 (1=ON, 2=OFF, 0=EXIT PROGRAM): '); % ask user to enter value for variable answer
end
fclose(arduino); % end communication with arduino

%%
close all;
clear all;
clc;

a = arduino('COM5')

% a.pinMode(13,'output');
a.configureDigitalPin(13,'output')
pinMode(a,13,'output');
% a.digitalWrite(13,1);
a.writeDigitalPin(22,1)
digitalWrite(a,13,1);
a.analogRead(0)
analogRead(a,0)

%%
close all;
clear all;
clc;
% delete(instrfind(('Port'),('com13')));
% a=arduino('com13','uno');
a = arduino()
ai_pin=0; tic;i=0; count=0; s=0;
while toc<100 i=i+1;
    time(i)=toc;
    v(i)=a.analogRead(ai_pin);
    v2(i)=5; plot(time,v,'color','r');
    hold on;
    pause(0.30);
    if v(i)>5 s=1;
    else if s==1 s=0;
            count=count+1;
        end
    end
end
disp('no. of pulses=')
disp(count)

%%

a = arduino()
plotTitle = 'Arduino Data Log';  % plot title
xLabel = 'Elapsed Time (s)';     % x-axis label
yLabel = 'Temperature (C)';      % y-axis label
legend1 = 'Temperature Sensor 1'
legend2 = 'Temperature Sensor 2'
legend3 = 'Temperature Sensor 3'
yMax  = 40                       % y Maximum Value
yMin  = 0                        % y minimum Value
plotGrid = 'on';                 % 'off' to turn off grid
min = 0;                         % set y-min
max = 40;                        % set y-max
delay = .01;                     % make sure sample faster than resolution 
%Define Function Variables
time = 0;
data = 0;
data1 = 0;
data2 = 0;
count = 0;
%Set up Plot
plotGraph = plot(time,data,'-r' )  % every AnalogRead needs to be on its own Plotgraph
hold on                            % hold on makes sure all of the channels are plotted
plotGraph1 = plot(time,data1,'-b')
plotGraph2 = plot(time, data2,'-g' )
title(plotTitle,'FontSize',15);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
legend(legend1,legend2,legend3)
axis([yMin yMax min max]);
grid(plotGrid);
tic
while ishandle(plotGraph) %loop when plot is active and will run until plot is closed
         dat = a.analogRead(0)* 0.48875855327; % data from the arduino
         dat1 = a.analogRead(2)* 0.48875855327; 
         dat2 = a.analogRead(4)* 0.48875855327;       
         count = count + 1;    
         time(count) = toc;    
         data(count) = dat(1);         
         data1(count) = dat1(1)
         data2(count) = dat2(1)

         set(plotGraph,'XData',time,'YData',data);
         set(plotGraph1,'XData',time,'YData',data1);
         set(plotGraph2,'XData',time,'YData',data2);
          axis([0 time(count) min max]);
          % updates the graph
          pause(delay);
  end
delete(a);
disp('Plot Closed and arduino object has been deleted');