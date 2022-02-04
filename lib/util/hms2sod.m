function sod = hms2sod(hms)
    sod = 3600*hms.h + 60*hms.m + hms.s;
end