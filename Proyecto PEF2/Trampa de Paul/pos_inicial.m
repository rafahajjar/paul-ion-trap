function [ri] = pos_inicial(r0,z0)
    % Genera una posicion inicial aleatoria en el cubo centrado en el
    % origen y con vertice rmax.
    rmax = 0.1*[r0, r0, z0];
    ri = -rmax + 2*rand(1, 3).*rmax;
end

