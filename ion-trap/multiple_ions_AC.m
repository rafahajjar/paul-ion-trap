clear;
close all;

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

dt = 2e-6; % Timestep in seconds.
T = 0.07;  % Total time in seconds.
f = 640;   % Frequency in hertzs.

ri = initial_pos_multiple(r0, z0, N);
vi = zeros(size(ri));
[r, v, a] = trajectory_AC_multiple(ri, vi, qn, ds, cent, dt, T, f, N);

%% Representación gráfica

vx = [v1(1,:); v2(1,:); v3(1,:)];
vy = [v1(2,:); v2(2,:); v3(2,:)];
vz = [v1(3,:); v2(3,:); v3(3,:)];

figure('Color','white','Position',[0,100,1000,800])
ax = axes;
set(ax,'xlim',[-rmax rmax],'ylim',[-rmax rmax],'zlim',[-zmax zmax]);
view(ax, 3)
hold(ax)
fill3(ax, vx, vy, vz, qn, 'EdgeAlpha', 0, 'FaceAlpha', .3)
colormap jet
comet3(ax, r(:, 1), r(:, 2), r(:, 3))

%% Write video

for k = 1:20 
   frame = getframe(gcf);
   writeVideo(v,frame);
end

close(v);