% clc

latitude_gc = 60;
latitude_gd = atand(tand(latitude_gc)/(1 - const.gbl.E_EARTH_2));
longitude = -70;
h_ellp = 400;

r_ECEF = latlonh2ecef(latitude_gd, longitude, h_ellp, const);

JD = 52109 + 2400000.5;
[ymd, hms] = JD2ymd_hms(JD);
time = conv_time(ymd, hms, const);
rho = atmosphere_density(r_ECEF, time, const)


rho_ref = 2.44632918571114e-12;
abs(rho_ref - rho)/rho_ref