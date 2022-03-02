%% atmosphere_density
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    3/1/2022
% Reference: Fundamentals of Astrodynamics and Applications, 4th edition,
% By David A.Vallado, Appendix B.2,  Page 1011
%
% Note: The atmosphere density model used here is the Russian GOST
% Atmosphere model. The model is accurate enough that only differes about
% 5%-10% from the Jacchia Model which has a much higher complexity in
% computation. Thus, the Russian GOST model is preffered here.
%
% The genral formula is:
%   - rho = rho_n*k_0*k_1*k_2*k_3*k_4.
%   - rho_n: Night time density profile.
%   - k_0: Coefficient relates the daily F_107 solar activity to a weighted
% average, F_81.
%   - k_1: The daily effect of the atmosphere density distribution.
%   - k_2: The semianual effect.
%   - k_3: The deviation of daily F_107 from F_87.
%   - k_4: Geomagnetic activities.
% ----------------------------------------------------------------------- %
% Inputs:
%   - r_ECEF: Position vector in the ECEF frame.
%   - time: The time.
% Outputs:
%   - rho: The atomosphere density.
% ----------------------------------------------------------------------- %
function rho = atmosphere_density(r_ECEF, time, const)
    JD = time.JD_UTC;
    r_I = r_ECEF(1);
    r_J = r_ECEF(2);
    r_K = r_ECEF(3);
    F_107 = const.param.F_107(const.param.F_107(:, 1) == floor(JD - 1.7), 2);
    F_81 = const.param.F_81(const.param.F_107(:, 1) == floor(JD - 1.7), 2);
    russian_gost_parm = const.param.russian_gost_param;

    F_0 = [75 100 125 150 175 200 250];
    [~, F_0_ii] = min(abs(F_0 - F_107));

    %% rho_n
    a = russian_gost_parm(1:3, F_0_ii);   
    [~, ~, h_ellp] = ecef2latlonh(r_ECEF, const);

    rho_n = 9.80665*exp(a(1) - a(2)*sqrt(h_ellp - a(3)));
    %% k_0
    l = russian_gost_parm(27:29, F_0_ii);
    k_0 = 1 + (l(1) + l(2)*h_ellp + l(3)*h_ellp^2)*(F_81 - F_107);
    %% k_1
    c = russian_gost_parm(10:13, F_0_ii);
    n = russian_gost_parm(14:15, F_0_ii);
    phi_b = russian_gost_parm(16, F_0_ii);

    [~, alpha_sun, delta_sun] = sun(time);
    gamma = alpha_sun + phi_b;
    
    phi = acos(1/norm(r_ECEF)*(r_K*sin(delta_sun) + cos(delta_sun)*(r_I*cos(gamma) + r_J*sin(gamma))));
    k_1 = 1 + (c(1) + c(2)*h_ellp + c(3)*h_ellp^2 + c(4)*h_ellp^3)*((cos(phi/2))^(n(1) + n(2)*h_ellp));
    %% k_2
    d = russian_gost_parm(4:6, F_0_ii);
    L_month = [31 28 31 30 31 30 31 31 30 31 30 31];
    if mod(time.ymd.y,4) == 0
         L_month(2) = 29;
    end
    day_of_year = sum(L_month(1:time.ymd.m)) + time.ymd.d;
    Ad = const.param.Ad(const.param.Ad(:, 1) == floor(day_of_year/10)*10, 2);

    k_2 = 1 + (d(1) + d(2)*h_ellp + d(3)*h_ellp^2)*Ad;
    %% k_3
    b = russian_gost_parm(7:9, F_0_ii);
    k_3 = 1 + ((b(1) + b(2)*h_ellp + b(3)*h_ellp^2)*(F_107 - F_81))/F_107;
    %% k_4
    %%
    rho = real(rho_n*k_0*k_1*k_2*k_3);
end
