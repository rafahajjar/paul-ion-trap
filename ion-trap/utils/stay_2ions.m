function [sinusoidal, triangular] = stay_2ions(r0, z0, qn, ds, cent, dt, T, f)
    r1i = initial_pos(r0, z0);
    r2i = initial_pos(r0, z0);
    v1i = [0, 0, 0];
    v2i = [0, 0, 0];
    src1 = trajectory_AC_sinusoidal_2(r1i, r2i, v1i, v2i, qn*(pi/4), ds, cent, dt, T, f);
    src2 = trajectory_AC_triangular_2(r1i, r2i, v1i, v2i, qn, ds, cent, dt, T, f);
    sinusoidal = 1;
    triangular = 1;
    r11 = src1(length(src1)/2, :);
    r12 = src1(length(src1), :);
    if escaped(r0, z0, r11) || escaped(r0, z0, r12)
       sinusoidal = 0; 
    end
    r21 = src2(length(src2)/2, :);
    r22 = src2(length(src2), :);    
    if escaped(r0, z0, r21) || escaped(r0, z0, r22)
       triangular = 0; 
    end 
end

