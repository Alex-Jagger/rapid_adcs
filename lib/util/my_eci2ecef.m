%% my_eci2ecef
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    2/5/2022
% Reference: FAA, page 211.
%
% my_eci2ecef is an inverse function of my_eci2ecef. It transfers position,
% velocity, and acceleration vectors in the Earth Centered Intertial frame
% to Earth Centered Earth Fixed frame.
% ----------------------------------------------------------------------- %
% Inputs:
%   - time:
%   - r_ECI: The position vector in the Earth Centered Intertial frame.
%   - v_ECI: The vecocity vector in the ECI.
%   - a_ECI: The acceleration vector in the ECI.
%   - const:
%       - EOP: The earth orientation parameters data.
%       - LOD: The length of the day data.
%
% Parameters:
%   - *_TIRS: The vector in the Terrestrial Intermediate Reference System.
%
% Outputs:
%   - r_ECEF: The position vector in the Earth Centered Earth Fixed frame.
%   - v_ECEF: The vecocity vector in the ECEF.
%   - a_ECEF: The acceleration vector in the ECEF.% ----------------------------------------------------------------------- %
function [r_ECEF, v_ECEF, a_ECEF] = my_eci2ecef(time, r_ECI, v_ECI, a_ECI, const)

    W = polar_motion(time, const);
    R = earth_rotation_angle(time);
    PN = precession_nutation(time, const);
    
    EOP = const.param.EOP;
    LOD = EOP(EOP(:, 1) == time.MJD, 5);
    omega_earth = [0 0 7.292115146706979e-5*(1 - LOD/86400)]';
    
    r_TIRS = R'*PN'*r_ECI;
    v_TIRS = R'*PN'*v_ECI - cross(omega_earth, r_TIRS);
    a_TIRS = R'*PN'*a_ECI - cross(omega_earth, cross(omega_earth, r_TIRS)) - 2*cross(omega_earth, v_TIRS);

    r_ECEF = W'*r_TIRS;
    v_ECEF = W'*v_TIRS;
    a_ECEF = W'*a_TIRS;
end