function [r, v, a] = trajectory_AC_multiple(ri, vi, q_ions, m, qn, ds, cent, dt, T, f, N)
    epsilon = 8.854e-12;
    K = 1/(4*pi*epsilon);
    u = 1.66e-27; % unidad de masa atomica
    
    steps = round(T/dt);
    r = zeros(steps, N, 3);
    v = zeros(steps, N, 3);
    a = zeros(steps, N, 3);
    r(1, :, :) = ri;
    v(1, :, :) = vi;
    a(1, :, :) = 0;
    
    q = [qn; q_ions];
    c = [cent; ri];
    
    period = 1/f;
    t = 0;
    for i=2:steps
        Q = q*cos(2*pi*f*dt*i);
        a12 = (K*qion^2/mion)*vecnorm(r1(i-1, :)' - r2(i-1, :)').^(-3).*(r1(i-1, :)'-r2(i-1, :)');
        a1(i, :) = +a12 + (K*qion/mion)*sum(qn'.*ds.*(vecnorm(r1(i-1, :)' - cent).^(-3)).*(r1(i-1, :)'-cent), 2);
        a2(i, :) = -a12 + (K*qion/mion)*sum(qn'.*ds.*(vecnorm(r2(i-1, :)' - cent).^(-3)).*(r2(i-1, :)'-cent), 2);
        
        v(i, :) = v(i-1, :) + a(i, :)*dt;
        r(i, :) = r(i-1, :) + v(i, :)*dt + 0.5*a(i, :)*dt^2;
        t = t + dt;
    end
    
    % Desfem el canvi. Aixo no cal si esta ben vectoritzat
    r(1, :, :) = r1;
    r(2, :, :) = r2;
    v(1, :, :) = v1;
    v(2, :, :) = v2;
end
