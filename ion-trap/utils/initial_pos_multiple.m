function [ri] = initial_pos_multiple(r0, z0, N)
    % Genera una posicion inicial aleatoria en el cubo centrado en el
    % origen y con vertice rmax.
    rmax = 0.1*[r0, r0, z0];
    ri = zeros(N, 3);
    for j = 1:N
        ri(j,:) = -rmax + 2*rand(1, 3).*rmax;
    end
end