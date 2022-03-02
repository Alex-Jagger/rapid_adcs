% clc

r_ECEF = [6524.834; 6862.875; 6448.296];

[lat_gd, lon, h_ellp] = ecef2latlonh(r_ECEF, const);

lon_ref = 46.4464;
lat_gd_ref= 34.352496;
h_ellp_ref = 5085.22;

if(abs(lon_ref - lon)/lon_ref < 1e-5)
    disp("pass")
else
    disp("fail")
end

if(abs(lat_gd_ref - lat_gd)/abs(lat_gd_ref) < 1e-5)
    disp("pass")
else
    disp("fail")
end

if(abs(h_ellp_ref - h_ellp)/h_ellp_ref < 1e-5)
    disp("pass")
else
    disp("fail")
end