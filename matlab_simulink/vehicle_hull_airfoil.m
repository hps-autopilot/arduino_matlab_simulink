%% Import Horizontal Hull (Beam) Profile - Airfoil E520
% Script for importing data from the following text file:
%
%    filename: e520.dat
%

% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["EPPLER", "VarName2", "Var3"];
opts.SelectedVariableNames = ["EPPLER", "VarName2"];
opts.VariableTypes = ["double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "Var3", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var3", "EmptyFieldRule", "auto");
opts = setvaropts(opts, "EPPLER", "TrimNonNumeric", true);
opts = setvaropts(opts, "EPPLER", "ThousandsSeparator", ",");

% Import the data
e520 = readtable("e520.dat", opts);

% Convert to output type
e520 = table2array(e520);

% Clear temporary variables
clear opts

%% Import Vertical Hull (Draft) Profile - Airfoil E838
% Script for importing data from the following text file:
%
%    filename: e838.dat
%

% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["EPPLER", "E838"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Import the data
e838 = readtable("e838.dat", opts);

% Convert to output type
e838 = table2array(e838);

% Clear temporary variables
clear opts

%% Plot Hull Profile

% Horizontal Hull (Beam) Profile - Airfoil E520
figure('NumberTitle', 'on', 'Name', 'Horizontal Hull (Beam) Profile - Airfoil E520');
e520_x = e520(:,1);
e520_y = e520(:,2);
plot(e520_x,e520_y,'color',[0 0.4470 0.7410]);
xlabel('x'); ylabel('y'); title('Horizontal Hull (Beam) Profile - Airfoil E520');
axis equal
grid on

% Vertical Hull (Draft) Profile - Airfoil E838
figure('NumberTitle', 'on', 'Name', 'Vertical Hull (Draft) Profile - Airfoil E838');
e838_x = e838(:,1);
e838_y = e838(:,2);
plot(e838_x,e838_y,'color',[0.8500 0.3250 0.0980]);
xlabel('x'); ylabel('y'); title('Vertical Hull (Draft) Profile - Airfoil E838');
axis equal
grid on

% Horizontal vs Vertical Hull Profile Comparison
figure('NumberTitle', 'on', 'Name', 'Horizontal vs Vertical Hull Profile Comparison');
hold on
plot(e520_x,e520_y,'color',[0 0.4470 0.7410]);
plot(e838_x,e838_y,'color',[0.8500 0.3250 0.0980]);
xlabel('x'); ylabel('y'); title('Horizontal vs Vertical Hull Profile Comparison');
legend('E520 (Beam)','E838 (Draft)','Location','Best');
axis equal
grid on
hold off