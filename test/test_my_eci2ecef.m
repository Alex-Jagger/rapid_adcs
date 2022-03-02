%clc

ymd = struct('y', 2004, 'm', 4, 'd', 6);
UTC = struct('h', 7, 'm', 51, 's', 28.386009);
time = conv_time(ymd, UTC, const);

r_ECI = [5102.508959 6123.011403 6378.136925]';
v_ECI = [-4.74322016 0.79053650 5.53375573]';

[r_ECEF, v_ECEF, ~] = my_eci2ecef(time, r_ECI, v_ECI, zeros(3, 1), const);

r_ECEF_ref = [-1033.479383 7901.295275 6380.3565958]';
v_ECEF_ref = [-3.22563652 -2.87245145 5.531924446]';

if (norm(r_ECEF_ref - r_ECEF)/norm(r_ECEF_ref) < 1e-7 &&...
        norm(v_ECEF_ref - v_ECEF)/norm(v_ECEF_ref) < 1e-7)
    disp("pass")
else
    disp("fail")
end
