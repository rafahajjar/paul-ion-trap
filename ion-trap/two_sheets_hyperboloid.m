function [xint, yint, zint] = two_sheets_hyperboloid(r0, z0, N)
    % Crea un cuadrado de lado 2r y se queda con los puntos del circulo de
% radio r.
    x = linspace(-r0, r0, N);
    y = linspace(-r0, r0, N);
    isInt = zeros(N, N);
    numInt = 0;
    for i=1:N
        for j=1:N
            if x(i)^2 + y(j)^2 < r0^2
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
    
    % Funcion que calcula la hoja superior (z>0) del hiperboloide de dos hojas
    % dado por 2z^2 - r^2 = 2z0^2.
    zint = sqrt(0.5*(2*z0^2 + xint.^2 + yint.^2));
end