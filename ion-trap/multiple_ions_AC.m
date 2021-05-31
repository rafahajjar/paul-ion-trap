clear;
close all;
addpath('utils')

N = 2; % Numero de iones

%% Condensador hiperbolico: obtencion de la carga

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

% Potencial en cada placa hiperbolica del condensador
V = 0.5; 

[qn, v1, v2, v3, un, cent, ds] = electrodes(V, r0, z0);

%% Calculo trayectoria de 1 ion

dt = 2e-5; % Timestep in seconds.
T = 0.1;  % Total time in seconds.
f = 4800;   % Frequency in hertzs.

u = 1.66e-27; % unidad de masa atomica
ri = initial_pos_multiple(r0, z0, N);
vi = zeros(size(ri));
qi = 1.60e-19 * ones(N, 1);
m  = 30*u * ones(N, 1);
[src] = trajectory_AC_multiple(ri, vi, qi, m, qn, ds, cent, dt, T, f, N);

%% Representación gráfica

vx = [v1(1,:); v2(1,:); v3(1,:)];
vy = [v1(2,:); v2(2,:); v3(2,:)];
vz = [v1(3,:); v2(3,:); v3(3,:)];

comet3n(src, rmax, zmax, vx, vy, vz, qn, 'speed', 10, 'headsize', 1, 'tailwidth', 1,... 
'taillength', 150)