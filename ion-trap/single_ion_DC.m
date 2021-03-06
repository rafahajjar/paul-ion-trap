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

[qn, v1, v2, v3, un, cent, ds] = electrodes(V, r0, z0);

%% Calculo trayectoria de 1 ion

dt = 1e-4; % Timestep in seconds.
T = 0.01; % Total time in seconds;

ri = initial_pos(r0, z0);
vi = [0, 0, 0];
r = trajectory_DC(ri, vi, qn, ds, cent, dt, T);

%% Representación gráfica

vx = [v1(1,:); v2(1,:); v3(1,:)];
vy = [v1(2,:); v2(2,:); v3(2,:)];
vz = [v1(3,:); v2(3,:); v3(3,:)];

figure('Color','white')
ax = axes;
set(ax,'xlim',[-rmax rmax],'ylim',[-rmax rmax],'zlim',[-zmax zmax]);
view(ax, 3)
axis equal
view([45 16.5])
set(gca,'FontSize',12)
title("Trajectory of an ion (DC)",'FontSize', 22);
xlabel("$x$",'FontSize', 20);
ylabel("$y$",'FontSize', 20);
zlabel("$z$",'FontSize', 20);
hold(ax)
fill3(ax, vx, vy, vz, qn, 'EdgeAlpha', 0, 'FaceAlpha', .3)
colormap jet
comet3(ax, r(:, 1), r(:, 2), r(:, 3))