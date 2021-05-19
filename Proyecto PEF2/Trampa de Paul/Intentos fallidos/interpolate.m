function [Exx, Eyy, Ezz] = interpolate(xx, yy, zz, Ex, Ey, Ez)
    % Step 1: Meshgrid to Ngrid format
    P = [2 1 3];
    xx = permute(xx, P);
    yy = permute(yy, P);
    zz = permute(zz, P);   
    Ex = permute(Ex, P);
    Ey = permute(Ey, P);
    Ez = permute(Ez, P);

    % Step 2: Interpolating
    Exx = griddedInterpolant(xx, yy, zz, Ex);
    Eyy = griddedInterpolant(xx, yy, zz, Ey);
    Ezz = griddedInterpolant(xx, yy, zz, Ez);
end

