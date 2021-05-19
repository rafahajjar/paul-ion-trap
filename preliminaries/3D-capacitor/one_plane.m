function [x, y, z] = one_plane(d, L, N)
    % Creamos la geometria del condensador plano (solo plano z=1)
    [xx, yy, zz] = meshgrid(linspace(-L/2, L/2, N),linspace(-L/2, L/2, N),d);
    x = xx(:)';
    y = yy(:)';
    z = zz(:)';
end