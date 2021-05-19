function [x, y, z, r, t] = one_sheet_hyperboloid(r0, z0, N)

    [x, y, r, t] = ringpoints(r0, z0, N);
    
    % Funcion que calcula la parte superior (z>0) del hiperboloide de una hoja
    % dado por r^2 - 2z^2 = r0^2.
    z = sqrt(0.5*(x.^2 + y.^2 - r0^2));
end