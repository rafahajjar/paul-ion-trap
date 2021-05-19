function [xext, yext, zext, rs, thetas] = one_sheet_hyperboloid(r0, z0, N)
    % Genera N*N puntos (x,y) en un anillo de radios r0 y rmax. Lo hace de
    % manera que queden bien espaciados en z sobre la hiperbola de una hoja.
    z = linspace(0, z0, N/3);
    r = sqrt(2*z.^2+r0^2) + 1e-9;
    theta = linspace(0, 2*pi, 3*N);
    [rr, ttheta] = meshgrid(r, theta);
    xx = rr.*cos(ttheta);
    yy = rr.*sin(ttheta);
    
    xext = xx(:)';
    yext = yy(:)';
    rs = rr(:)';
    thetas = ttheta(:)';
    
    % Funcion que calcula la parte superior (z>0) del hiperboloide de una hoja
    % dado por r^2 - 2z^2 = r0^2.
    zext = sqrt(0.5*(xext.^2 + yext.^2 - r0^2));
end