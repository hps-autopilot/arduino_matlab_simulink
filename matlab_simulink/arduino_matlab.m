close all;
clear all;
clc;

%% General Parameters

% gravity [m/s^2] or [N]
    g = 9.81; % [m/s^2]
    
% material density
%     Hull - hand-laid woven carbon fiber and foam
%     Window - formed thermoplastic
%     Propellor - chopped carbon fiber blades, delrin hub
%     Fins - cast polyurethane resin
    mrho_cpr = 1000;    % cast polyurethane resin [kg/m^3]

% fluid density [kg/m^3] or [g/cc]
    frho_water = 1000;        % water [kg/m^3]
    frho_river = 1000;        % river [kg/m^3]
    frho_ocean = 1027;        % ocean [kg/m^3]
    frho_freshwater = 1000;   % freshwater [kg/m^3]
    frho_seawater = 1026;     % seawater [kg/m^3]
    frho_chlorine = 992.72;   % chlorine [kg/m^3]
    frho_saltwater = 996.06;  % saltwater [kg/m^3]
    % Units Example: Water has a density of 1000 kg/m^3 = 1000 g/L = 1 kg/dm^3 = 1 kg/L = 1 g/cm^3 (or g/cc) = 1 g/mL.
    
%% UW HPS Parameters

m_lb = 400;             % mass of vehicle [lb]
m_kg = m_lb*0.45359237; % mass of vehicle [kg]
W = m_lb*4.448220;      % weight of vehicle [N]
% rho = ; % density of vehicle [kg/m^3]

% added mass

%     hull (slender body theory) - new
    % variables
    frho_freshwater = 1000;   % freshwater [kg/m^3]
    rho = frho_freshwater;
    syms x
    
    hull_r1 = 2/2; % [m]
    hull_r2 = 0.74258/2; %[m]
    hull_r3 = 0.50294/2; % [m]
    hull_V = (4/3)*pi*hull_r1*hull_r2*hull_r3; % volume of hull [m^3]

    hull_L = 2; % length of hull [m]
    
    % non-dimensional values
    k1 = 0.05384;   % one of Lambs k-factors
    hull_r = hull_r2/hull_r1;
    
    % matrix
    hull_m11 = k1*(4/3)/pi*rho*hull_r1*hull_r2^2;
    hull_m22 = int(pi*rho*hull_r, x, 0, hull_L);
    hull_m33 = hull_m22;
    hull_m44= 0;
    hull_m55 = int(pi*x^2*rho*hull_r, x, 0, hull_L);
    hull_m66 = hull_m55;
    
    hull_m26 = int(pi*rho*x*hull_r^2, x, 0, hull_L);
    hull_m62 = hull_m26;
    
    hull_m35 = -int(pi*rho*x*hull_r^2, x, 0, hull_L);
    hull_m53 = hull_m35;
    
    hull_diag = [hull_m11 hull_m22 hull_m33 hull_m44 hull_m55 hull_m66];
    am_hull = diag(hull_diag);
    am_hull(2,6) = hull_m26;
    am_hull(6,2) = hull_m62;
    am_hull(3,5) = hull_m35;
    am_hull(5,3) = hull_m53;
    
    
%     hull (assume ellipsoid) - old
    hull_a = 2/2; % [m]
    hull_b = 0.74258/2; %[m]
    hull_c = 0.50294/2; % [m]
    hull_V = (4/3)*pi*hull_a*hull_b*hull_c; % volume of hull [m^3]
    
    % non-dimensional values
    k11 = 0.05384;
    k22 = 0.85384;
    k55 = 0.89538;
    
    % matrix
    hull_a11 = k11*(4/3)/pi*hull_a*hull_b^2;
    hull_a22 = k22*(4/3)/pi*hull_a*hull_b^2;
    hull_a33 = hull_a22;
    hull_a44= 0;
    hull_a55 = k55*(4*pi/15)*hull_a*hull_b^2*(hull_a^2+hull_b^2);
    hull_a66 = hull_a55;
    hull_diag = [hull_a11 hull_a22 hull_a33 hull_a44 hull_a55 hull_a66]
    am_hull = diag(hull_diag);
    
    
    
%     rudder (hydrofoil NACA-0008) x4
    frho_freshwater = 1000;   % freshwater [kg/m^3]
    rho = frho_freshwater;
    
    % initial condition
    rudder_CB_x = -0.02; % center of buoyancy of rudder in x-direction [m]
    rudder_CB_y = 0; % center of buoyancy of rudder in y-direction [m]
    rudder_c = 0.247; % chord of the control surface [m]
    rudder_b = 0.5; % span of the control surface [m]
    rudder_t = 0.019765; % thickness of the control surface [m]
    rudder_S = 0.1; % surface area of the plate [m^2]
    rudder_AR = rudder_b^2/rudder_S; % aspect ratio [-]
    k_trans = 1/sqrt(1+1/rudder_AR); % added inertia in translation [-]
    k_rot = 1/rudder_AR; % added inertia in rotation [-]
    
    % added mass coefficients of the rudder
    rudder_m11 = k_trans*((pi*rho*rudder_t^2*rudder_b^3)/4);
    rudder_m22 = k_trans*((pi*rho*rudder_t^2*rudder_c^3)/4);
    rudder_m33 = k_trans*((pi*rho*rudder_b^3*rudder_c^2)/4);
    rudder_m44 = k_rot*((pi*rho*rudder_b^2*rudder_c^3)/48) + rudder_CB_y*rudder_m33;
    rudder_m55 = k_rot*((pi*rho*rudder_b^2*rudder_c^3)/48) + rudder_CB_x*rudder_m33;
    rudder_m66 = 0;
    
    rudder_diag = [rudder_m11 rudder_m22 rudder_m33 rudder_m44 rudder_m55 rudder_m66];
    am_rudder = diag(rudder_diag);
    

%     propeller

%     total added mass
%     ma = ma_hull+ma_fin+ma_prop;

%% Hull
% airfoil

seligdatfile = readtable("D:\Dropbox\uw\msthesis_hps\hps_autopilot_code_matlab\seligdatfile.txt", opts);
%%
seligdatfile = load('seligdatfile')

x = seligdatfile(:,1)
y = seligdatfile(:,2)
test = readtable(seligdatfile)
% plot(x,y)
plot (x:, 1})


%% Arduino set-up
a = arduino('com7','Nano33IoT');    % Nano 33 IoT
IMU = device(a, 'I2CAddress', 0x6A);
readRegister(IMU, 0x0F, 1)

% Note: IMU sensor LSM6DS3 slave address is 110101xb

%% (One-time) Arduino sensor data to MATLAB

data_acc = (2/32768)*readRegister(IMU, 0x28, 3, 'int16')   % accelerometer data
aX = data_acc(:,1);
aY = data_acc(:,2);
aZ = data_acc(:,2);

data_gyro = (250/32768)*readRegister(IMU, 0x22, 3, 'int16')   % gyrometer data
gX = data_gyro(:,1);
gY = data_gyro(:,2);
gZ = data_gyro(:,3);


%% Simulink

% environment parameters
    frho = frho_freshwater; % fluid density [kg/m^3]

% vehicle parameters
    m = m_kg; % mass of vehicle [kg]

% PID Controller
    Kp = 1;
    Ki = 1;
    Kd = 4;


%% Arduino BLECK
%%
voltage = readVoltage(a,'A0');  % reads board voltage
tempC = (voltage-0.5)*100; % board temperature

%% Plot Live Acceleration
figure
ax = axes;
ax.YGrid = 'on';
ax.YLim = [-12 12];
cmap = ax.ColorOrder;
h1 = animatedline('Color',cmap(1,:));
h2 = animatedline('Color',cmap(2,:));
h3 = animatedline('Color',cmap(3,:));
legend({'acc_x','acc_y','acc_z'})

% collect accelerometer data for 30 sec and update plot live
tic
while toc < 20
    % get new data to plot
    acc = readAcceleration(sensor);
    t = datetime('now');
    
    % add points to animation
    addpoints(1,datenum(t),acc(1))
    addpoints(2,datenum(t),acc(2))
    addpoints(3,datenum(t),acc(3))
    
    % update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimites')
    drawnow
end

%% Position Estimation
imuFs = 100;    % IMU (accelerometer and gyroscope) sample rate [Hz]
gpsFs = 10;     % GPS sample rate [Hz]

% Define where on the Earth this simulation takes place using latitude,
% longitude, and altitude (LLA) coordinates.
localOrigin = [42.2825 -71.343 53.0352];

%% Close the model
% bdclose('arduino_matlab')
% displayEndOfrhoemoMessage(mfilename)