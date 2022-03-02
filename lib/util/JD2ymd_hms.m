function [ymd, hms] = JD2ymd_hms(JD)

    L_month = [31 28 31 30 31 30 31 31 30 31 30 31];

    T_1900 = (JD - 2415019.5)/365.25;
    y = 1900 + floor(T_1900);
    leap_year = floor((y - 1900 - 1)*0.25);
    days = (JD - 2415019.5) - ((y - 1900)*365 + leap_year);
    if days < 1
        y = y - 1;
        leap_year = floor((y - 1900 - 1)*4);
        days = (JD - 2415019.5) - ((y - 1900)*365 + leap_year);
    end

    if mod(y, 4) == 0
        L_month(2) = 29;
    end

    day_of_year = floor(days);

    m = 1;
    sum_day = L_month(1);
    while sum_day <= day_of_year
        m = m + 1;
        sum_day = sum_day + L_month(m);    
    end

    d = day_of_year - sum_day + L_month(m);

    sod = (days - day_of_year)*24*3600;

    hms = sod2hms(sod);
    ymd = struct('y', y, 'm', m, 'd', d);
end