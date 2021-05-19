function [r, v, a] = trajectory(ri, vi, qn, ds, cent, h, steps)
    epsilon = 8.854e-12;
    K = 1/(4*pi*epsilon);
    u = 1.66e-27; % unidad de masa atomica
    qion = 1.60e-19; % carga del ion (con signo)
    mion = 223*u; % masa del ion (Francio 1+)
    r = zeros(steps, 3);
    v = zeros(steps, 3);
    a = zeros(steps, 3);
    r(1, :) = ri;
    v(1, :) = vi;
    a(1, :) = 0;
    for i=2:steps
        a(i, :) = (K*qion/mion)*sum(qn.*ds*(vecnorm(r(i-1, :)' - cent).^(-2))'*sign(qn).*unitary(r(i-1, :)'-cent), 2);
        v(i, :) = v(i-1, :) + h*a(i, :);
        r(i, :) = r(i-1, :) + h*v(i, :) + 0.5*a(i, :)*h^2;
    end
end
