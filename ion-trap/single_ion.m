clear;
close all;

%% Condensador hiperbolico: obtencion de la carga

% Parametro de discretizacion.
N = 15;

% Constantes fisicas
epsilon = 8.854e-12;
K = 1/(4*pi*epsilon);
qe = 1.6e-19;
mp = 1.6749e-27;

% Potencial en cada placa hiperbolica del condensador
V = 0.5;

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

[qn, v1, v2, v3, un, cent, ds] = electrodes(V, r0, z0, N);

%% Calculo trayectoria de 1 ion

h = 1e-6; % Timestep in seconds.
T = 0.01; % Total time in seconds;
steps = T/h;

ri = initial_pos(r0, z0);
vi = [0, 0, 0];
[r, v, a] = trajectory(ri, vi, qn', ds, cent, h, steps);