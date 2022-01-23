% Defines the constant values

constants = struct;

% Conversion multiplicative factors
convert = struct;
convert.M2KM    = 1.0e-3;          % convert meters to kilometers
convert.KM2M    = 1.0e3;           % convert kilometers to meters
convert.DEG2RAD = pi / 180;         % convert degrees to radians
convert.RAD2DEG = 180 / pi;         % convert radians to degrees
convert.DAY2SEC = 86400;            % convert days to seconds
convert.SEC2DAY = 1.0 / 86400;      % convert seconds to days
convert.HR2SEC  = 3600.0;           % convert sec to hour
convert.SEC2HR  = 1/3600.0;         % convert hour to sec
convert.MIN2SEC = 60.0;             % convert sec to min
convert.SEC2MIN = 1/60.0;           % convert min to sec
% add to constants struct
constants.convert = convert;

% Global Constants
gbl = struct;
gbl.MU_EARTH_KM3_S2  = 398600.4415;                  % gravitational parameter
gbl.R_EARTH_KM      = 6378.1363;                     % radius (spherical approx)
% add to constants struct
constants.gbl = gbl;
