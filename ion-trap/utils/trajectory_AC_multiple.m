function [src] = trajectory_AC_multiple(ri, vi, qi, m, qn, ds, cent, dt, T, f, N)
    epsilon = 8.854e-12;
    K = 1/(4*pi*epsilon);
    
    steps = round(T/dt);
    r = zeros(steps, N, 3);
    v = zeros(steps, N, 3);
    a = zeros(steps, N, 3);
    r(1, :, :) = ri;
    v(1, :, :) = vi;
    a(1, :, :) = 0;
    
    q = [qn; qi];
    c = [cent, ri'];
    s = [ds, ones(1,N)];
    
    t = 0;
    for i=2:steps
        Q = q*cos(2*pi*f*t);
        
        for j = 1:N
            a(i, j, :) = (K*qi(j)/m(j))*sum(Q'.*s.*(vecnorm(squeeze(r(i-1, j, :))-c).^(-3)).*(squeeze(r(i-1, j, :))-c), 2, 'omitnan');
        end
        v(i, :, :) = v(i-1, :, :) + a(i, :, :)*dt;
        r(i, :, :) = r(i-1, :, :) + v(i-1, :, :)*dt + 0.5*a(i, :, :)*dt^2;
        
        if N == 1
            c = [cent, squeeze(r(i,:,:))];
        else 
            c = [cent, squeeze(r(i,:,:))'];
        end
        
        t = t + dt;
    end
    
    t=1:steps;
    id = ones(steps, 1); 
    src = [];
    for j = 1:N
        obj = cat(2, r(:,j,1), r(:,j,2), r(:,j,3), t', j*id);
        src = cat(1, src, obj);
    end
end
