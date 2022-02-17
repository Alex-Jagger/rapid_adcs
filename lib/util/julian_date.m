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
% ----------------------------------------------------------------------- %
function JD = julian_date(ymd, hms)
    JD = 367*ymd.y - fix(7*(ymd.y + fix((ymd.m + 9)/12))/4) + fix(275*ymd.m/9) + ymd.d +...
    1721013.5 + (((hms.s/60) + hms.m)/60 + hms.h)/24;
end