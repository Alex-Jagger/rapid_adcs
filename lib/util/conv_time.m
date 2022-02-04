%% polar_ymd.mtion
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    2/2/2022
% Reference: FAA, page 195
% ----------------------------------------------------------------------- %
% Inputs:
%   - ymd: Year, month, and day.
%   - UTC: The coordinated universal time.
%   - EOP: The earth orientation parameters data.
%   - Delta_AT: Atomic time difference data.
% Outputs:
%   - time: Rotation matrix from ITRF to TIRS
%       -time.ymd.y: Year.
%       -time.ymd.m: Month.
%       -time.ymd.d: Day.
%       -time.UTC: The coordinated universal time.
%       -time.UT1: The universal time 1.
%       -time.TAI: The atomic time.
%       -time.TT: The terretrial time.
%       -time.JD_UTC: The Julian date of the UTC.
%       -time.JD_TAI: The Julian date of the TAI.
%       -time.JD_TT: The Julian date of the TT.
% ----------------------------------------------------------------------- %
function time = conv_time(ymd, UTC, const)

    EOP = const.param.EOP;
    Delta_AT = const.param.Delta_AT;

    JD_UTC = julian_date(ymd, UTC);
    MJD = floor(JD_UTC - 2400000.5);
    delta_UT1 = EOP(EOP(:, 1) == MJD, 4);

    delta_AT = Delta_AT((Delta_AT(:, 1) - ymd.y) <= 0, 2);
    delta_AT = delta_AT(end);

    UT1 = sod2hms(hms2sod(UTC) - delta_UT1);
    TAI = sod2hms(hms2sod(UTC) + delta_AT);
    TT = sod2hms(hms2sod(TAI) + 32.184);

    JD_UT1 = julian_date(ymd, UT1);
    JD_TT = julian_date(ymd, TT);
    JD_TAI = julian_date(ymd, TAI);
    
    T_UTC = JD2T(JD_UTC);
    T_UT1 = JD2T(JD_UT1);
    T_TT = JD2T(JD_TT);
    T_TAI = JD2T(JD_TAI);
    
    time.ymd = ymd;

    time.UTC = UTC;
    time.UT1 = UT1;
    time.TAI = TAI;
    time.TT = TT;

    time.JD_UTC = JD_UTC;
    time.MJD = MJD;
    time.JD_UT1 = JD_UT1;
    time.JD_TAI = JD_TAI;
    time.JD_TT = JD_TT;

    time.T_UTC = T_UTC;
    time.T_UT1 = T_UT1;
    time.T_TT = T_TT;
    time.T_TAI = T_TAI;
end