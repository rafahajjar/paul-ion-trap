function stay = stay(r0, z0, qn, ds, cent, dt, T, f, N, qi, mi)
    steps = round(T/dt);
    ri = initial_pos_multiple(r0, z0, N);
    vi = zeros(size(ri));
    src = trajectory_AC_multiple(ri, vi, qi, mi, qn*(pi/4), ds, cent, dt, T, f, N);
    stay = 1;
    Rf = zeros(N, 5);
    for j=1:N
       Rf(j, :) = src(j*steps, :);
    end
    for j=1:N
        if escaped(r0, z0, Rf(j, :))
            stay = 0;
        end
    end
end


