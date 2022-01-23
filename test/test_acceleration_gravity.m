clc

r = [constants.gbl.R_EARTH_KM*constants.convert.KM2M; 0; 0];

a_g = acceleration_gravity(r, constants);

g = 9.81;

if(abs(g - norm(a_g))/g < 0.005)
    disp("passed")
else
    disp("failed")
end