%% polar_motion
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    2/2/2022
% Reference: FAA, page 212
% ----------------------------------------------------------------------- %
% Inputs:
%   - xp: (seconds) Polar displacement, measured positive south along the 0 deg
%   longitude meridian.
%   - yp: (seconds) Polar displacement, 90 deg W meridian.
%   - T_TT: Terrestrial julian century.
% Outputs:
%   - W: Rotation matrix from ITRF to TIRS
% ----------------------------------------------------------------------- %
function W = polar_motion(time, const)
    EOP = const.param.EOP;
    T_TT = time.T_TT;
    MJD = time.MJD;

    xp = EOP(EOP(:, 1) == MJD, 2);
    yp = EOP(EOP(:, 1) == MJD, 3);

    s_prime = -0.000047*T_TT*const.conv.SEC2RAD; % TIO locator
    xp = xp*const.conv.SEC2RAD;
    yp = yp*const.conv.SEC2RAD;

    cxp = cos(xp);
    sxp = sin(xp);
    cyp = cos(yp);
    syp = sin(yp);
    csp = cos(s_prime);
    ssp = sin(s_prime);

    W = [cxp*csp    -cyp*ssp + syp*sxp*csp      -syp*ssp - cyp*sxp*csp
        cxp*ssp     cyp*csp + syp*sxp*ssp       syp*csp - cyp*sxp*ssp
        sxp         -syp*cxp                    cyp*cxp];
end