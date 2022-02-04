clc

ymd = struct('y', 2004, 'm', 4, 'd', 6);
UTC = struct('h', 7, 'm', 51, 's', 28.386009);
time = conv_time(ymd, UTC, const);

r_ITRF = [-1033.479383 7901.295275 6380.3565958]';
 
W = polar_motion(time, const);

r_TIRS = W*r_ITRF;

r_TIRS_ref = [-1033.475031 7901.3055856 6380.3445327]';

if norm(r_TIRS_ref - r_TIRS)/norm(r_TIRS_ref) < 1e-7
    disp("pass");
else
    disp("fail");
end