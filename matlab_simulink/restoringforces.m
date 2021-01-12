%% Restoring Forces
% computes the 6x1 vector of restoring forces about an arbitrarily point CO for a submerged body
% Note: Need MSS toolbox (Marine Systems Simulator Toolbox) commands.

close all;
clear all;
clc;

% vehicle
m = 1000;       % mass
g = 9.81;       % acceleration of gravity
W = m*g;        % weight
B = W;          % buoyancy; satisfied by neutrally buoyant vehicles

r_CG = [0, 0, 0];       % location of CG with respect to CO
r_CB = [0, 0, -10];     % location of CB with respect to CO
    % CO = center of origin

% pitch and roll angles
phi = 30*(pi/180);      % roll
theta = 10*(180/pi);    % pitch

% g-vector
g = gvect(W,B,theta,phi,r_CG,r_CB)

% calculations
     sphi = sin(phi);   cphi = cos(phi);
     sth  = sin(theta); cth  = cos(theta);
 
     g = [...
        (W-B)*sth
       -(W-B)*cth*sphi
       -(W-B)*cth*cphi
       -(r_CG(2)*W-r_CB(2)*B)*cth*cphi + (r_CG(3)*W-r_CB(3)*B)*cth*sphi
        (r_CG(3)*W-r_CB(3)*B)*sth      + (r_CG(1)*W-r_CB(1)*B)*cth*cphi
       -(r_CG(1)*W-r_CB(1)*B)*cth*sphi + (r_CG(2)*W-r_CB(2)*B)*sth      ];