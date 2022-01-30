clc;

yr = 1996;
mo = 10;
d = 26;
h = 14;
min = 20;
s = 0;

JD = julian_date(yr, mo, d, h, min, s)

JD_ref = 2450383.09722222

if JD_ref - JD > 1e-6
    disp('fial');
else
    disp('pass');
end