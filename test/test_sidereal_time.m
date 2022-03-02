%clc

ymd = struct('y', 1992, 'm', 8, 'd', 20);
UT1 = struct('h', 12, 'm', 14, 's', 0);
JD_UT1 = julian_date(ymd, UT1);
T_UT1 = JD2T(JD_UT1);

time.T_UT1 = T_UT1;

longitude = -104;

[theta_LST, theta_GMST] = sidereal_time(time, longitude, const);

theta_LST_ref = 48.578787810;
theta_GMST_ref = 152.578787810;

if(norm(theta_LST_ref - theta_LST)/norm(theta_LST_ref) < 0.1e-7)
    disp("pass")
else
    disp("fail")
end

if(norm(theta_GMST_ref - theta_GMST)/norm(theta_GMST_ref) < 0.005)
    disp("pass")
else
    disp("fail")
end