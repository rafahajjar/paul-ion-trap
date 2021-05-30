function [sinusoidal, triangular] = stays_1ion(r0, z0, qn, ds, cent, dt, T, f)
    ri = initial_pos(r0, z0);
    vi = [0, 0, 0];
    r1 = trajectory_AC_sinusoidal(ri, vi, qn*(pi/4), ds, cent, dt, T, f);
    r2 = trajectory_AC_triangular(ri, vi, qn, ds, cent, dt, T, f);
    sinusoidal = 1;
    triangular = 1;
    if escaped(r0, z0, r1(end, :))
        sinusoidal = 0;
    end
    if escaped(r0, z0, r2(end, :))
        triangular = 0;
    end    
end

