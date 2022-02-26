function [r_sun, right_ascension_sun, declination_sun] = sun(time)
    T_UT1 = time.T_UT1;
    lambda_M_sun = mod(280.46 + 36000.771*T_UT1, 360);
    M_sun = mod(357.5291092 + 35999.05034*T_UT1, 360);
    lambda_ecliptic = lambda_M_sun + 1.914666471*sind(M_sun) + 0.019994643*sind(2*M_sun);
    d_sun = 1.000140612 - 0.016708617*cosd(M_sun) - 0.000139589*cosd(2*M_sun);
    epsilon = 23.439291 - 0.0130042*T_UT1;
    
    r_sun = [d_sun*cosd(lambda_ecliptic);
             d_sun*cosd(epsilon)*sind(lambda_ecliptic);
             d_sun*sind(epsilon)*sind(lambda_ecliptic)]*149598000;
    
    declination_sun = asin(sind(epsilon)*sind(lambda_ecliptic));     % rad
    right_ascension_sun = atan2(cosd(epsilon)*sind(lambda_ecliptic)/cos(declination_sun), ...
        cosd(lambda_ecliptic)/cos(declination_sun));               %rad
end