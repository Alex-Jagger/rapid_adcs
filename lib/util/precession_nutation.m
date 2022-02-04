%% precession_nutation
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    2/4/2022
% Reference: FAA, page 213
% ----------------------------------------------------------------------- %
% Inputs:
%   - time: The time.
%   - const: The structure containing important constants.
%       - X_CIP, Y_CIP: The matrix containing all coefficient needed to
%       calculate X and Y. (IERS Conventions 2010)
%       - EOP: The earth orientation parameters.
% Outputs:
%   - PN: Rotation matrix from CIRS to GCRF.
% ----------------------------------------------------------------------- %
function PN = precession_nutation(time, const)

    T_TT = time.T_TT;
    MJD = time.MJD;
    
    X_CIP = const.param.X_CIP;
    Y_CIP = const.param.Y_CIP;
    EOP = const.param.EOP;
    %-------------------------------------------------------------------------%
    M_moon = (485868.249036 + 1717915923.2178*T_TT + 31.8792*T_TT^2 + 0.051635*T_TT^3 - 0.0002447*T_TT^4)*const.conv.SEC2RAD; % [sec]
    M_sun = (1287104.79305 + 129596581.0481*T_TT - 0.5532*T_TT^2 + 0.000136*T_TT^3 - 0.00001149*T_TT^4)*const.conv.SEC2RAD;
    mu_moon = (335779.526232 + 1739527262.8478*T_TT - 12.7512*T_TT^2 - 0.001037*T_TT^3 + 0.00000417*T_TT^4)*const.conv.SEC2RAD;
    D_sun = (1072260.70369 + 1602961601.2090*T_TT - 6.3706*T_TT^2 + 0.006593*T_TT^3 - 0.00003169*T_TT^4)*const.conv.SEC2RAD;
    Omega_moon =  (450160.398036 - 6962890.5431*T_TT + 7.4722*T_TT^2 + 0.007702*T_TT^3 - 0.00005939*T_TT^4)*const.conv.SEC2RAD;
    
    lambdaM_mercury = 4.402608842 + 2608.7903141574*T_TT;
    lambdaM_venus = 3.176146697 + 1021.3285546211*T_TT;
    lambdaM_earth = 1.753470314 + 628.3075849991*T_TT;
    lambdaM_mars = 6.203480913 + 334.0612426700*T_TT;
    lambdaM_jupiter = 0.599546497 + 52.9690962641*T_TT;
    lambdaM_saturn = 0.874016757 + 21.329910496*T_TT;
    lambdaM_uranus = 5.481293872 + 7.4781598567*T_TT;
    lambdaM_Neptune = 5.311886287 + 3.8133035638*T_TT;
    p_lambda = 0.02438175*T_TT + 0.00000538691*T_TT^2;
    
    planetary_effects = [M_moon
                        M_sun
                        mu_moon
                        D_sun
                        Omega_moon
                        lambdaM_mercury
                        lambdaM_venus
                        lambdaM_earth
                        lambdaM_mars
                        lambdaM_jupiter
                        lambdaM_saturn
                        lambdaM_uranus
                        lambdaM_Neptune
                        p_lambda];
    %-------------------------------------------------------------------------%
    X_poly = -0.016617 + 2004.191898*T_TT - 0.4297829*T_TT^2 - 0.19861834*T_TT^3 + 0.000007578*T_TT^4 + 0.0000059285*T_TT^5;
    
    a_x0 = X_CIP.coe_0(:, 3:end)*planetary_effects;
    X_0 = sum(X_CIP.coe_0(:, 1).*sin(a_x0) + X_CIP.coe_0(:, 2).*cos(a_x0));
    
    a_x1 = X_CIP.coe_1(:, 3:end)*planetary_effects;
    X_1 = sum(X_CIP.coe_1(:, 1).*sin(a_x1) + X_CIP.coe_1(:, 2).*cos(a_x1))*T_TT;
    
    a_x2 = X_CIP.coe_2(:, 3:end)*planetary_effects;
    X_2 = sum(X_CIP.coe_2(:, 1).*sin(a_x2) + X_CIP.coe_2(:, 2).*cos(a_x2))*T_TT^2;
    
    a_x3 = X_CIP.coe_3(:, 3:end)*planetary_effects;
    X_3 = sum(X_CIP.coe_3(:, 1).*sin(a_x3) + X_CIP.coe_3(:, 2).*cos(a_x3))*T_TT^3;
    
    a_x4 = X_CIP.coe_4(:, 3:end)*planetary_effects;
    X_4 = sum(X_CIP.coe_4(:, 1).*sin(a_x4) + X_CIP.coe_4(:, 2).*cos(a_x4))*T_TT^4;
    
    dX = EOP(EOP(:, 1) == MJD, 6);
    
    X = (X_poly + (X_0 + X_1 + X_2 + X_3 + X_4)*const.conv.MICRO + dX)*const.conv.SEC2RAD;
    %-------------------------------------------------------------------------%
    Y_poly = -0.006951 - 0.025896*T_TT - 22.4072747*T_TT^2 + 0.00190059*T_TT^3 + 0.001112526*T_TT^4 + 0.0000001358*T_TT^5;
    
    a_y0 = Y_CIP.coe_0(:, 3:end)*planetary_effects;
    Y_0 = sum(Y_CIP.coe_0(:, 1).*sin(a_y0) + Y_CIP.coe_0(:, 2).*cos(a_y0));
    
    a_y1 = Y_CIP.coe_1(:, 3:end)*planetary_effects;
    Y_1 = sum(Y_CIP.coe_1(:, 1).*sin(a_y1) + Y_CIP.coe_1(:, 2).*cos(a_y1))*T_TT;
    
    a_y2 = Y_CIP.coe_2(:, 3:end)*planetary_effects;
    Y_2 = sum(Y_CIP.coe_2(:, 1).*sin(a_y2) + Y_CIP.coe_2(:, 2).*cos(a_y2))*T_TT^2;
    
    a_y3 = Y_CIP.coe_3(:, 3:end)*planetary_effects;
    Y_3 = sum(Y_CIP.coe_3(:, 1).*sin(a_y3) + Y_CIP.coe_3(:, 2).*cos(a_y3))*T_TT^3;
    
    a_y4 = Y_CIP.coe_4(:, 3:end)*planetary_effects;
    Y_4 = sum(Y_CIP.coe_4(:, 1).*sin(a_y4) + Y_CIP.coe_4(:, 2).*cos(a_y4))*T_TT^4;
    
    dY = EOP(EOP(:, 1) == MJD, 7);
    
    Y = (Y_poly + (Y_0 + Y_1 + Y_2 + Y_3 + Y_4)*const.conv.MICRO + dY)*const.conv.SEC2RAD;
%-------------------------------------------------------------------------%
    s_poly = -X*Y/2 + 0.000094 + 0.00380865*T_TT - 0.00012268*T_TT^2 - 0.07257411*T_TT^3; %[sec]


    s_coe = [0.00264073
        -0.00006353
        -0.00001175
        -0.00001121
        0.00000457
        -0.00000202
        -0.00000198
        0.00000172
        0.00000141
        0.00000126
        0.00000063
        0.00000063];

    a_s = [Omega_moon
        2*Omega_moon
        2*mu_moon - 2*D_sun + 3*M_moon
        2*mu_moon - 2*D_sun + Omega_moon
        2*mu_moon - 2*D_sun + 2*M_moon
        2*mu_moon + 3*Omega_moon
        2*mu_moon + Omega_moon
        3*Omega_moon
        M_sun + Omega_moon
        M_sun - Omega_moon
        M_moon + Omega_moon
        M_moon - Omega_moon];

    s_sum = sin(a_s)'*s_coe;

    s_rest = 0.00000173*T_TT*sin(Omega_moon) + 0.00000357*T_TT*cos(2*Omega_moon) + ...
        0.00074352*T_TT^2*sin(Omega_moon) + 0.00005691*T_TT^2*sin(2*(mu_moon - D_sun + Omega_moon)) + ...
        0.00000984*T_TT^2*sin(2*(mu_moon + Omega_moon)) - 0.00000885*T_TT^2*sin(2*Omega_moon);

    s = (s_poly + s_sum + s_rest)*const.conv.SEC2RAD;
%-------------------------------------------------------------------------%
    
    a = 1/2 + 1/8*(X^2 + Y^2);
    
    PN = [(1 - a*X^2)     -a*X*Y      X
        -a*X*Y          (1 - a*Y^2)   Y
        -X              -Y          (1 - a*(X^2+Y^2))] * rot(s, 'z');
end