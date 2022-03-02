%clc

ymd.y = 2004;
ymd.m = 5;
ymd.d = 14;
UTC.h = 16;
UTC.m = 43;
UTC.s = 0;

time = conv_time(ymd, UTC, const);

% ref to FAA P.196