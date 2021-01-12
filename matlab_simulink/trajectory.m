%% 3D Trajectory
% animated real-time 3D trajectory plotter

close all;
clear all;
clc;

% Sample trajectory
t = 0:0.1:10;
x = 7*cos(t);
y = 7*sin(t);
z = sin(t)+cos(t)+t;
plot3(x,y,z,'*r');

% plots the animated real-time trajectory in 3D
for i=1:length(x)

  plot3(x(i),y(i),z(i),'*r');
  hold on;
  pause(0.01);
  
end