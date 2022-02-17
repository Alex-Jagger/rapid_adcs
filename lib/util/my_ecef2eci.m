%% my_ecef2eci
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    2/5/2022
% Reference: FAA, page 211.
%
% my_ecef2eci transfers position, veclocity, and acceleration vectors in the
% Earth Centered Earth Fixed frame into the Earth Centered Intertial frame.
%
% ECEF and ECI are conventional names used to refer two frequentyly used
% coordinate frames in astrodynamics problems. However, the coordinate
% frames used in this algorithm are the International Terrestrial Reference
% System (for ECEI) and Geocentric Celestial Reference System (for ECI).
% 
% The reduction algorithm used here is IAU-2010 conventions, CIO-based,
% which is a summerise and update of the IAU-2006/2000 Resolutions. Other
% reduction algorithms are available, like the IAU-76/FK5, but IAU-2010
% convections is the latest and most accurate one.
% ----------------------------------------------------------------------- %
% Inputs:
%   - time:
%   - r_ECEF: The position vector in the Earth Centered Earth Fixed frame.
%   - v_ECEF: The vecocity vector in the ECEF.
%   - a_ECEF: The acceleration vector in the ECEF.
%   - const:
%       - EOP: The earth orientation parameters data.
%       - LOD: The length of the day data.
%
% Parameters:
%   - *_TIRS: The vector in the Terrestrial Intermediate Reference System.
%
% Outputs:
%   - r_ECI: The position vector in the Earth Centered Intertial frame.
%   - v_ECI: The vecocity vector in the ECI.
%   - a_ECI: The acceleration vector in the ECI.
%
% ----------------------------------------------------------------------- %
function [r_ECI, v_ECI, a_ECI] = my_ecef2eci(time, r_ECEF, v_ECEF, a_ECEF, const)

    W = polar_motion(time, const);
    R = earth_rotation_angle(time);
    PN = precession_nutation(time, const);
    
    EOP = const.param.EOP;
    LOD = EOP(EOP(:, 1) == time.MJD, 5);
    omega_earth = [0 0 7.292115146706979e-5*(1 - LOD/86400)]';
    
    r_TIRS = W*r_ECEF;
    v_TIRS = W*v_ECEF;
    a_TIRS = W*a_ECEF;

    r_ECI = PN*R*r_TIRS;
    v_ECI = PN*R*(v_TIRS + cross(omega_earth, r_TIRS));
    a_ECI = PN*R*(a_TIRS + cross(omega_earth, cross(omega_earth, r_TIRS)) + 2*cross(omega_earth, v_TIRS));
end