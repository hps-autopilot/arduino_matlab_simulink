%% Force Graph

close all;
clear all;
clc;

%

accelerationX = (signed int)(((signed int)rawData_X) * 3.9);
accelerationY = (signed int)(((signed int)rawData_Y) * 3.9);
accelerationZ = (signed int)(((signed int)rawData_Z) * 3.9);
roll = 180 * atan (accelerationY/sqrt(accelerationX*accelerationX + accelerationZ*accelerationZ))/pi;
pitch = 180 * atan (accelerationX/sqrt(accelerationY*accelerationY + accelerationZ*accelerationZ))/pi;
yaw = 180 * atan (accelerationZ/sqrt(accelerationX*accelerationX + accelerationZ*accelerationZ))/pi;

figure('NumberTitle', 'off', 'Name', 'Figure 1');
hold on
xlabel('Time [s]'); ylabel('Rotation [deg]'); title('Rotation vs Time');
plot(roll,time,'g.');    % plots roll vs time
plot(pitch,time,'b.');   % plots pitch vs time
plot(yaw,time,'r.'); % plots yaw vs time
legend('roll','pitch','yaw','SW');
hold off
