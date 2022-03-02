% clc

JD = 2449877.3458762;
[ymd, hms] = JD2ymd_hms(JD);

ymd_ref = struct('y', 1995, 'm', 6, 'd', 8);
hms_ref = struct('h', 20, 'm', 18, 's', 3.70368);

if(ymd_ref.y == ymd.y)
    disp("pass")
else
    disp("fail")
end

if(ymd_ref.m == ymd.m)
    disp("pass")
else
    disp("fail")
end

if(ymd_ref.d == ymd.d)
    disp("pass")
else
    disp("fail")
end

if(hms_ref.h == hms.h)
    disp("pass")
else
    disp("fail")
end

if(hms_ref.m == hms.m)
    disp("pass")
else
    disp("fail")
end

if(abs(hms_ref.s - hms.s)/hms_ref.s < 1e-5)
    disp("pass")
else
    disp("fail")
end