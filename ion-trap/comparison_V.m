clear;
close all;
addpath('utils')

%% Condensador hiperbolico: obtencion de la carga

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

V = 1;
[qn, v1, v2, v3, un, cent, ds] = electrodes(V, r0, z0);

%% Halla el orden de magnitud del minimo potencial de la trampa para cada N

dt = 1e-5; % Timestep in seconds.
T = 0.1;  % Total time in seconds.
f = 1000;
N = 1:2;
minV = zeros(1, length(N));
v = [1e-6,1e-5,1e-4,1e-3,1e-2,1e-1,1]; % Fraccion del potencial.
for i = 1:length(N)
    for j = 1:length(v)
        s = stay(r0, z0, qn*v(j), ds, cent, dt, T, f, N(i));
        if minV(i) == 0 || s == 1
            minV(i) = v(j);
            break;
        end
    end
end
s = s./trials;
t = t./trials;

plot(N, minV)