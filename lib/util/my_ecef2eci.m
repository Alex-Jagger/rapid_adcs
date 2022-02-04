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