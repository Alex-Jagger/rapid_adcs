%% julian_date
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    1/29/2022
% Reference: FAA, page 189
% ----------------------------------------------------------------------- %
% Inputs:
%   - yr: Year.
%   - mo: Month.
%   - d: Date.
%   - h: Hour.
%   - min: Minute.
%   - s: Second.
% Outputs:
%   - JD: Julian date
%
% Note: Leap seconds are ingnored here.
% ----------------------------------------------------------------------- %
function JD = julian_date(yr, mo, d, h, min, s)
    JD = 367*yr - fix(7*(yr + fix((mo + 9)/12))/4) + fix(275*mo/9) + d +...
        1721013.5 + (((s/60) + min)/60 + h)/24;
end