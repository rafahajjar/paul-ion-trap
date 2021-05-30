function [escaped] = escaped(r0, z0, r)
    escaped = false;
    if (r(1)^2 + r(2)^2 >= r0^2) || (r(3) >= z0)
        escaped = true;
    end
end