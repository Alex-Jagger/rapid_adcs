%% earth_rotation_angle
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    2/2/2022
% Reference: FAA, page 213
% ----------------------------------------------------------------------- %
% Inputs:
%   - JD_UT1: UT1 Julian date.
% Outputs:
%   - R: Rotation matrix from TIRS to CIRS.
% ----------------------------------------------------------------------- %
function R = earth_rotation_angle(time)

    JD_UT1 = time.JD_UT1;

    theta = 2*pi*(0.779057273264 + 1.00273781191135448*(JD_UT1 - 2451545));
    R = rot(-theta, 'z');
end