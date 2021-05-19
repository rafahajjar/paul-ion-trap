function [xint, yint] = circlepoints(r, N)
% Crea un cuadrado de lado 2r y se queda con los puntos del circulo de
% radio r.
    x = linspace(-r, r, N);
    y = linspace(-r, r, N);
    isInt = zeros(N, N);
    numInt = 0;
    for i=1:N
        for j=1:N
            if x(i)^2 + y(j)^2 < r^2
                isInt(i, j) = true;
                numInt = numInt + 1;
            end
        end
    end
    int = zeros(2, numInt);
    a = 1;
    for i=1:N
        for j=1:N
            if isInt(i, j) == true
                int(:, a) = [x(i), y(j)]';
                a = a + 1;
            end
        end
    end
    xint = int(1, :);
    yint = int(2, :);
end

