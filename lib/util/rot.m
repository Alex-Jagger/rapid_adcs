%% rot
% Bruin Space Group - ADCS Subsystem team
%   Author:     Jiaping Zhen
%   Updated:    2/2/2022
% ----------------------------------------------------------------------- %
% Inputs:
%   - angle: The rotation angle value.
%   - axis: The rotation axis.
% Outputs:
%   - R: The rotation matrix.
% ----------------------------------------------------------------------- %
function R = rot(angle,axis)

try
    assert( isequal(axis,'x') || isequal(axis,'y') || isequal(axis,'z') )
catch
    error('Axis input must be one of "x", "y" or "z"')
end

ca = cos(angle);
sa = sin(angle);

switch axis
    case 'x'
        R = [ 1.0, 0.0, 0.0;
              0.0,  ca,  sa;
              0.0, -sa,  ca ];
    case 'y'
        R = [  ca, 0.0, -sa;
              0.0, 1.0, 0.0;
               sa, 0.0,  ca ];
    case 'z'
        R = [  ca,  sa, 0.0;
              -sa,  ca, 0.0;
              0.0, 0.0, 1.0 ];
end

end