function [lat_gd, lon, h_ellp] = ecef2latlonh(r_ECEF, const)

    E_EARTH_2 = const.gbl.E_EARTH_2;
    R_EARTH = const.gbl.R_EARTH_KM;
    RAD2DEG = const.conv.RAD2DEG;

    r_I = r_ECEF(1);
    r_J = r_ECEF(2);
    r_K = r_ECEF(3);

    r_delta = norm(r_ECEF(1:2));
    lon = atan2(r_J, r_I);

    delta = asin(r_ECEF(3)/norm(r_ECEF));

    lat_gd = delta;
    lat_gd_old = 100;
    while abs(lat_gd - lat_gd_old) > 1e-7
        C_earth = R_EARTH/sqrt(1 - E_EARTH_2*(sin(lat_gd))^2);
        lat_gd_old = lat_gd;
        lat_gd = atan((r_K + C_earth*E_EARTH_2*sin(lat_gd))/r_delta);
    end
    
    if abs(lat_gd) < pi/2 - 0.05 
        h_ellp = r_delta/cos(lat_gd) - C_earth;
    else
        S_earth = R_EARTH*(1 - E_EARTH_2)/sqrt(1 - E_EARTH_2*(sin(lat_dg))^2);
        h_ellp = r_k/sin(lat_gd) - S_earth;
    end

    lon = lon*RAD2DEG;
    lat_gd = lat_gd*RAD2DEG;
end