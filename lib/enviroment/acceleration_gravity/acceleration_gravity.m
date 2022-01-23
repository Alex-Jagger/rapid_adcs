%% acceleration_gravity
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    1/22/2022
% Reference: Fundamentals of Astrodynamics and Applications, 3rd edition,
% By David A.Vallado, Chap 8.7,  Page 589
% ----------------------------------------------------------------------- %
% Inputs:
%   - r: Position vector.
% Outputs:
%   - a_g: Acceleration vector because of gravity.
%
% Variables:
% ----------------------------------------------------------------------- %
function a_g = acceleration_gravity(r, const)
r_I = r(1);
r_J = r(2);
r_K = r(3);
r_norm = norm(r);

J_2 = 1.08262668355e-3;
J_3 = -2.53265648533e-6;

r_e = const.gbl.R_EARTH_KM*const.convert.KM2M;
mu = const.gbl.MU_EARTH_KM3_S2*(const.convert.KM2M)^3;

a_I_J_2 = -(3*J_2*mu*r_e^2*r_I)/(2*r_norm^5)*(1 - 5*r_K^2/r_norm^2);
a_J_J_2 = -(3*J_2*mu*r_e^2*r_J)/(2*r_norm^5)*(1 - 5*r_K^2/r_norm^2);
a_K_J_2 = -(3*J_2*mu*r_e^2*r_K)/(2*r_norm^5)*(3 - 5*r_K^2/r_norm^2);
a_J_2 = [a_I_J_2; a_J_J_2; a_K_J_2];

a_I_J_3 = -(5*J_3*mu*r_e^3*r_I)/(2*r_norm^7)*(3*r_K - 7*r_K^3/r_norm^2);
a_J_J_3 = -(5*J_3*mu*r_e^3*r_J)/(2*r_norm^7)*(3*r_K - 7*r_K^3/r_norm^2);
a_K_J_3 = -(5*J_3*mu*r_e^2)/(2*r_norm^7)*...
            (6*r_K^2 - 7*r_K^4/r_norm^2 -3/5*r_norm^2);
a_J_3 = [a_I_J_3; a_J_J_3; a_K_J_3];

a_g = -mu/r_norm^3*r + a_J_2 + a_J_3;
end

