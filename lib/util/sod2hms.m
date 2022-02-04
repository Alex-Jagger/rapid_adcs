function hms = sod2hms(sod)
    temp = sod/3600;
    hms.h = fix(temp);
    hms.m = fix((temp - hms.h)*60);
    hms.s = (temp - hms.h - hms.m/60)*3600;
end