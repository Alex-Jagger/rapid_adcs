%clc

ymd = struct('y', 2006, 'm', 4, 'd', 2);
UTC = struct('h', 0, 'm', 0, 's', 0);
time = conv_time(ymd, UTC, const);

[r_sun, right_ascension_sun, declination_sun] = sun(time);

r_sun_ref = [146259922; 28595947; 12387430];
right_ascension_sun_ref = 11.13925*const.conv.DEG2RAD;
declination_sun_ref = 4.788417*const.conv.DEG2RAD;

if(norm(r_sun_ref - r_sun)/norm(r_sun_ref) < 0.005)
    disp("pass")
else
    disp("fail")
end

if(abs(right_ascension_sun_ref - right_ascension_sun)/abs(right_ascension_sun_ref) < 1e-7)
    disp("pass")
else
    disp("fail")
end

if(abs(declination_sun_ref - declination_sun)/abs(declination_sun_ref) < 0.005)
    disp("pass")
else
    disp("fail")
end