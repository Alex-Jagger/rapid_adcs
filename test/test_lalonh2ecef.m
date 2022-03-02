% clc

latitude_gd = -7.9066357;
longitude = 345.5975;
h_ellp = 56*const.conv.M2KM;

 r_ecef = latlonh2ecef(latitude_gd, longitude, h_ellp, const)

 r_ecef_ref = [6119.40027666; -1571.47955734; -871.56112598]

 if ((r_ecef_ref - r_ecef)/norm(r_ecef_ref) < 1e-7)
     disp('pass')
 else
     disp('fail')
 end