function [r, v, a] = trajectory_DC(ri, vi, qn, ds, cent, dt, T)
    epsilon = 8.854e-12;
    K = 1/(4*pi*epsilon);
    u = 1.66e-27; % unidad de masa atomica
    qion = 1.60e-19; % carga del ion (con signo)
    mion = 223*u; % masa del ion (Francio 1+)
    
    steps = round(T/dt);
    r = zeros(steps, 3);
    v = zeros(steps, 3);
    a = zeros(steps, 3);
    r(1, :) = ri;
    v(1, :) = vi;
    a(1, :) = 0;
    for i=2:steps
        a(i, :) = (K*qion/mion)*sum(qn'.*ds.*(vecnorm(r(i-1, :)' - cent).^(-3)).*(r(i-1, :)'-cent), 2);
        v(i, :) = v(i-1, :) + a(i, :)*dt;
        r(i, :) = r(i-1, :) + v(i, :)*dt + 0.5*a(i, :)*dt^2;
    end
end
