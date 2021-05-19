function [qn, v1, v2, v3, un, cent, ds] = electrodes(V, r0, z0, N)
    epsilon = 8.854e-12;
    K = 1/(4*pi*epsilon);

    % Obtenemos vectores x, y, z con las coordenadas de las hiperbolas
    [xint, yint, zint] = two_sheets_hyperboloid(r0, z0, N);
    [xext, yext, zext, rs, thetas] = one_sheet_hyperboloid(r0, z0, N);

    % Triangulacion de los hiperboloides (con simetria respecto z=0)
    [i1, i2, i3, iun, icent, ids] = triangles(xint, yint, zint, xint, yint);
    [e1, e2, e3, eun, ecent, eds] = triangles(xext, yext, zext, rs, thetas);

    v1 = [i1, e1];
    v2 = [i2, e2];
    v3 = [i3, e3];
    un = [iun, eun];
    cent = [icent, ecent];
    ds = [ids, eds];
    
    M = length(cent);
    Z = zeros(M);
    for i = 1:M
        Z(i, :) = K*int_S_1divR(cent(:, i), v1, v2, v3, un, cent);
    end
    b = [(V * ones(length(icent), 1)); -V * ones(length(ecent), 1)];
    qn = Z\b;
end