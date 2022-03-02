%clc;

ymd.y = 1996;
ymd.m = 10;
ymd.d = 26;
hms.h = 14;
hms.m = 20;
hms.s = 0;

JD = julian_date(ymd, hms);

JD_ref = 2450383.09722222;

if JD_ref - JD > 1e-6
    disp('fial');
else
    disp('pass');
end