function [r, v, a] = trayectoria(ri, vi, Ex, Ey, Ez, h, steps)
    r = zeros(steps, 3);
    v = zeros(steps, 3);
    a = zeros(steps, 3);
    r(1, :) = ri;
    v(1, :) = vi;
    a(1, :) = (qe/me)*[Ex(r(1, 1)), Ey(r(1, 2)), Ez(r(1, 3))];
    for i=2:steps
        a(i) = (qe/me)*[Ex(r(i, 1)), Ey(r(i, 2)), Ez(r(i, 3))];
        v(i) = v(i-1) + h*a(i);
        r(i) = r(i-1) + h*v(i-1) + 0.25*(a(i-1) + a(i))*h^2;
    end
end

