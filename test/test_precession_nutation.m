clc

ymd = struct('y', 2004, 'm', 4, 'd', 6);
UTC = struct('h', 7, 'm', 51, 's', 28.386009);
time = conv_time(ymd, UTC, const);

r_CIRS = [5100.0184047 6122.7863648 6380.3445327]';

PN = precession_nutation(time, const);

r_GCRF = PN*r_CIRS;

r_GCRF_ref = [5102.508959 6123.011403 6378.136925]';

if norm(r_GCRF_ref - r_GCRF)/norm(r_GCRF_ref) < 1e-7
    disp("pass");
else
    disp("fail");
end