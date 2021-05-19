function [z] = unahoja(x, y, r0)
% Funcion que calcula la parte superior (z>0) del hiperboloide de una hoja
% dado por r^2 - 2z^2 = r0^2.
    z = sqrt(0.5*(x.^2 + y.^2 - r0^2));
end