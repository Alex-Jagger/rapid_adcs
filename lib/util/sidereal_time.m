function [theta_LST, theta_GMST] = sidereal_time(time, longitude, const)
    HR2SEC = const.conv.HR2SEC;

    T_UT1 = time.T_UT1;

    theta_GMST = mod(67310.54841 + (876600*HR2SEC + 8640184.812866)*T_UT1 + ...
        0.093104*T_UT1^2 + 6.2e-6*T_UT1^3, 86400)/240;

    if theta_GMST < 0
        theta_GMST = theta_GMST + 360;
    end

    theta_LST = theta_GMST + longitude;
end