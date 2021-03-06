clear;
close all;
addpath('utils')

%% Condensador hiperbolico: obtencion de la carga

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

% Potencial en cada placa hiperbolica del condensador
V = 0.5;

[qn, V1, V2, V3, un, cent, ds] = electrodes(V, r0, z0);

%% Calculo trayectoria de 2 iones

dt = 3e-5; % Timestep in seconds.
T = 0.1;  % Total time in seconds.
f = 674;  % Frequency in hertzs.

r1i = initial_pos(r0, z0);
r2i = initial_pos(r0, z0);
v1i = [0, 0, 0];
v2i = [0, 0, 0];
[src] = trajectory_AC_sinusoidal_2(r1i, r2i, v1i, v2i, qn*(pi/4), ds, cent, dt, T, f);
%[src] = trajectory_AC_triangular_2(r1i, r2i, v1i, v2i, qn, ds, cent, dt, T, f);
%[src] = trajectory_AC_square_2(r1i, r2i, v1i, v2i, qn*(1/2), ds, cent, dt, T, f);


%% Representación gráfica

vx = [V1(1,:); V2(1,:); V3(1,:)];
vy = [V1(2,:); V2(2,:); V3(2,:)];
vz = [V1(3,:); V2(3,:); V3(3,:)];

comet3n(src, rmax, zmax, vx, vy, vz, qn, 'speed', 10, 'headsize', 1.6, 'tailwidth', 1,... 
'taillength', 150)