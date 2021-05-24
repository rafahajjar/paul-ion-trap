function [time] = escape_time(ri, vi, qn, ds, cent, dt, T, r0, z0)
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
    time = T;
    for i=2:steps
        a(i, :) = (K*qion/mion)*sum(qn'.*ds.*(vecnorm(r(i-1, :)' - cent).^(-3)).*(r(i-1, :)'-cent), 2);
        v(i, :) = v(i-1, :) + a(i, :)*dt;
        r(i, :) = r(i-1, :) + v(i, :)*dt + 0.5*a(i, :)*dt^2;
        if (r(i, 1)^2 + r(i,2)^2 >= (r0/4)^2) || (r(i, 3) >= z0/4)
           time = i*dt;
           break
        end
    end
end
