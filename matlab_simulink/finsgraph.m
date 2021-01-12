%% Fins Graph

close all;
clear all;
clc;

% Method 1

% Fin 1 (Yaw)
roll1 = 1;
pitch1 = 2;
yaw1 = 3;

% Fin 2 (Roll)
roll2 = 4;
pitch2 = -5;
yaw2 = 6;

% Fin 3 (Yaw)
roll3 = 2;
pitch3 = -2;
yaw3 = 4;

% Fin 4 (Roll)
roll4 = 0;
pitch4 = 1;
yaw4 = 3;

% graph
x = categorical(["Fin 1 (Yaw)" "Fin 2 (Roll)" "Fin 3 (Yaw)" "Fin 4 (Roll)"]);
x = reordercats(x,{'Fin 1 (Yaw)' 'Fin 2 (Roll)' 'Fin 3 (Yaw)' 'Fin 4 (Roll)'});
y = [roll1 pitch1 yaw1;
     roll2 pitch2 yaw2;
     roll3 pitch3 yaw3;
     roll4 pitch4 yaw4];

figure('NumberTitle', 'off', 'Name', 'Figure 1: Fin Rotation Force Data');
hold on
xlabel('Fin'); ylabel('Rotation Force [units]'); title('Fin Rotation Force Data');
fg = bar(x,y)
fg(1).FaceColor = 'g';
fg(2).FaceColor = 'b';
fg(3).FaceColor = 'r';
legend('roll','pitch','yaw');
hold off

%%

% yaw fins
fin1 = [5];
fin3 = [-1];
% pitch fins
fin2 = [5];
fin4 = [-1];
% plot
fins = [fin1 fin2 fin3 fin4];
barh(fins)