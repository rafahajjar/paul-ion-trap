function stay = stay(r0, z0, qn, ds, cent, dt, T, f, N)
    ri = initial_pos_multiple(r0, z0, N);
    vi = zeros(size(ri));
    qi = 1.60e-19 * ones(N, 1);
    m  = 30*1.66e-27 * ones(N, 1);
    src = trajectory_AC_multiple(ri, vi, qi, m, qn*(pi/4), ds, cent, dt, T, f, N);
    stay = 1;
    Rf = zeros(N, 3);
    for j=1:N
       Rf(j, :) = src(length(src)*(j/N), :);
    end
    for j=1:N
        if escaped(r0, z0, Rf(j, :))
            stay = 0;
        end
    end
end


