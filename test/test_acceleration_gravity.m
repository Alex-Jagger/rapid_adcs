%clc

r = [const.gbl.R_EARTH_KM*const.conv.KM2M; 0; 0];

a_g = acceleration_gravity(r, const);

g = 9.81;

if(abs(g - norm(a_g))/g < 0.005)
    disp("pass")
else
    disp("fail")
end