function [z] = doshojas(x, y, z0)
% Funcion que calcula la hoja superior (z>0) del hiperboloide de dos hojas
% dado por 2z^2 - r^2 = 2z0^2.
    z = sqrt(0.5*(2*z0^2 + x.^2 + y.^2));
end