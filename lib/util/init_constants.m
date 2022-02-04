% Defines the constant values
% Conversion multiplicative factors
conv.M2KM    = 1.0e-3;          % convert meters to kilometers
conv.KM2M    = 1.0e3;           % convert kilometers to meters
conv.DEG2RAD = pi / 180;         % convert degrees to radians
conv.RAD2DEG = 180 / pi;         % convert radians to degrees
conv.DAY2SEC = 86400;            % convert days to seconds
conv.SEC2DAY = 1.0 / 86400;      % convert seconds to days
conv.HR2SEC  = 3600.0;           % convert sec to hour
conv.SEC2HR  = 1/3600.0;         % convert hour to sec
conv.MIN2SEC = 60.0;             % convert sec to min
conv.SEC2MIN = 1/60.0;           % convert min to sec
conv.SEC2RAD = 1/3600*pi/180;    % convert sec to rad
conv.MICRO = 1e-6;              % convert to micro-
% add to constants struct
const.conv = conv;

% Global Constants
gbl.MU_EARTH_KM3_S2  = 398600.4415;                  % gravitational parameter
gbl.R_EARTH_KM      = 6378.1363;                     % radius (spherical approx)
% add to constants struct
const.gbl = gbl;

% Load Parameters
% param = struct;
% param.Delta_AT = load("include\iau2000_reduction_parameters.mat", 'Delta_AT');
% param.EOP = load("include\iau2000_reduction_parameters.mat", 'EOP');
% param.X_CIP = load("include\iau2000_reduction_parameters.mat", 'X_CIP');
% param.Y_CIP = load("include\iau2000_reduction_parameters.mat", 'Y_CIP');
param = load("include\iau2000_reduction_parameters.mat");
const.param = param;