% Defines the constant values
% Conversion multiplicative factors

const.conv.DEG2RAD = pi / 180;         % convert degrees to radians
const.conv.DAY2SEC = 86400;            % convert days to seconds
const.conv.HR2SEC  = 3600.0;           % convert sec to hour
const.conv.KM2M    = 1.0e3;            % convert kilometers to meters
const.conv.M2KM    = 1.0e-3;           % convert meters to kilometers
const.conv.MICRO = 1e-6;               % convert to micro-
const.conv.MIN2SEC = 60.0;             % convert sec to min
const.conv.RAD2DEG = 180 / pi;         % convert radians to degrees
const.conv.SEC2DAY = 1.0 / 86400;      % convert seconds to days
const.conv.SEC2HR  = 1/3600.0;         % convert sec to hr
const.conv.SEC2MIN = 1/60.0;           % convert sec to min
const.conv.SEC2RAD = 1/3600*pi/180;     % convert sec to rad



% Global Constants
const.gbl.MU_EARTH_KM3_S2   = 398600.4415;                  % gravitational parameter
const.gbl.R_EARTH_KM        = 6378.137;                    % radius (spherical approx)
const.gbl.E_EARTH           = 0.081819221456;               % eccentricity
const.gbl.E_EARTH_2         = 0.006694385;               % eccentricity
% Load Parameters
% param = struct;

load("include\iau2000_reduction_parameters.mat");

const.param.Delta_AT = Delta_AT;
const.param.EOP = EOP;
const.param.X_CIP = X_CIP;
const.param.Y_CIP = Y_CIP;

load("include\russian_gost_parameters.mat");

const.param.F_107 = F_107_daily;
const.param.F_81 = F_81;
const.param.russian_gost_param = russian_gost_param;
const.param.Ad = Ad;

%%
clearvars -except const