function r_ecef = latlonh2ecef(latitude_gd, longitude, h_ellp, const)
    E_EARTH_2 = const.gbl.E_EARTH_2;
    R_EARTH = const.gbl.R_EARTH_KM;
    den = sqrt(1 - E_EARTH_2*(sind(latitude_gd))^2);
    
    C_earth = R_EARTH/den;
    S_earth = R_EARTH*(1 - E_EARTH_2)/den;

    r_ecef = [(C_earth + h_ellp)*cosd(latitude_gd)*cosd(longitude);
        (C_earth + h_ellp)*cosd(latitude_gd)*sind(longitude);
        (S_earth + h_ellp)*sind(latitude_gd)];
end