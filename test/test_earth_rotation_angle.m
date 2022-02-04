clc

ymd = struct('y', 2004, 'm', 4, 'd', 6);
UTC = struct('h', 7, 'm', 51, 's', 28.386009);
time = conv_time(ymd, UTC, const);

r_TIRS = [-1033.475031 7901.3055856 6380.3445327]';

r_CIRS = earth_rotation_angle(time) *r_TIRS;

r_CIRS_ref = [5100.0184047 6122.7863648 6380.3445327]';

if norm(r_CIRS_ref - r_CIRS)/norm(r_CIRS_ref) < 1e-7
    disp("pass");
else
    disp("fail");
end