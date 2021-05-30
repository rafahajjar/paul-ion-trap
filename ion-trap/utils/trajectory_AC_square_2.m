function [src] = trajectory_AC_square_2(r1i, r2i, v1i, v2i, qn, ds, cent, dt, T, f)
    epsilon = 8.854e-12;
    K = 1/(4*pi*epsilon);
    u = 1.66e-27; % unidad de masa atomica
    e = +1.60e-19; % carga elemental
    q1 = +e;
    q2 = +e;
    m1 = 30*u; % masa del ion 1
    m2 = 30*u; % masa del ion 2

    steps = round(T/dt);
    r1 = zeros(steps, 3); r2 = r1;
    v1 = zeros(steps, 3); v2 = v1;
    a1 = zeros(steps, 3); a2 = a1;

    r1(1, :) = r1i; r2(1, :) = r2i;
    v1(1, :) = v1i; v2(1, :) = v2i;
    a1(1, :) = 0;   a2(2, :) = 0;

    period = 1/f;
    t = 0;
    for i=2:steps
        if t > period
            t = t - period;
            qn = -qn;
        end
        F12 = K*q1*q2*vecnorm(r1(i-1, :)' - r2(i-1, :)').^(-3).*(r1(i-1, :)'-r2(i-1, :)');
        a1(i, :) = +F12/m1 + (K*q1/m1)*sum(qn'.*ds.*(vecnorm(r1(i-1, :)' - cent).^(-3)).*(r1(i-1, :)'-cent), 2);
        a2(i, :) = -F12/m2 + (K*q2/m2)*sum(qn'.*ds.*(vecnorm(r2(i-1, :)' - cent).^(-3)).*(r2(i-1, :)'-cent), 2);
        v1(i, :) = v1(i-1, :) + a1(i, :)*dt;
        v2(i, :) = v2(i-1, :) + a2(i, :)*dt;
        r1(i, :) = r1(i-1, :) + v1(i, :)*dt + 0.5*a1(i, :)*dt^2;
        r2(i, :) = r2(i-1, :) + v2(i, :)*dt + 0.5*a2(i, :)*dt^2;        
        t = t + dt;
    end
    
   % Preparation for comet3n
    t=1:steps;
    id = ones(length(t), 1); 
    obj1 = cat(2, r1(:,1), r1(:,2), r1(:,3), t', id);
    obj2 = cat(2, r2(:,1), r2(:,2), r2(:,3), t', 2*id);
    src = cat(1, obj1, obj2); 
end