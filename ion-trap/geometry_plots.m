clear;
close all;

%% Condensador hiperbolico: obtencion de la carga

% Potencial en cada placa hiperbolica del condensador
V = 0.5;

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;

[qn, v1, v2, v3, un, cent, ds] = electrodes(V, r0, z0);

%% Representación de la geometria del objeto

vx = [v1(1,:); v2(1,:); v3(1,:)];
vy = [v1(2,:); v2(2,:); v3(2,:)];
vz = [v1(3,:); v2(3,:); v3(3,:)];

figure('Color', 'white')
fill3(vx, vy, vz, qn, 'EdgeAlpha', 0)
colorbar
colormap jet
saveas(gcf,'images/geometry.png')

figure('Color', 'white')
fill3(vx, vy, vz, 'g')
saveas(gcf,'images/geometry_raw.png')
