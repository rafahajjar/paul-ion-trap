function [xint, yint, xext, yext] = ringpointsv1(N, r0, rmax)
% Separa los puntos de un cuadrado de lado rmax en los que pertenecen al
% circulo de radio r0 y los que pertenecen al anillo de radios r0 y rmax.
    x = linspace(-rmax, rmax, N);
    y = linspace(-rmax, rmax, N);
    isInt = zeros(N, N);
    isExt = zeros(N, N);
    numInt = 0;
    numExt = 0;
    for i=1:N
        for j=1:N
            if x(i)^2 + y(j)^2 < r0^2
                isInt(i, j) = true;
                numInt = numInt + 1;
            elseif x(i)^2 + y(j)^2 <= rmax^2
                isExt(i, j) = true;
                numExt = numExt + 1;
            end
        end
    end
    int = zeros(2, numInt);
    ext = zeros(2, numExt);
    a = 1;
    b = 1;
    for i=1:N
        for j=1:N
            if isInt(i, j) == true
                int(:, a) = [x(i), y(j)]';
                a = a + 1;
            elseif isExt(i, j) == true
                ext(:, b) = [x(i), y(j)]';
                b = b + 1;
            end
        end
    end
    xint = int(1, :);
    yint = int(2, :);
    xext = ext(1, :);
    yext = ext(2, :);
end

