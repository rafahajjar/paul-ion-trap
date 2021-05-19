clear;
close all;

% Numero de cargas fuente en la discretizacion
N = 20;

% Constantes fisicas
epsilon = 8.854e-12;
K = 1/(4*pi*epsilon);

%% Condensador plano: geometría y obtención de la carga

% Potencial en cada placa del condensador (abajo y arriba resp.)
V1 = 0.5;
V2 = -0.5;

% Dimensiones
d = 0.05;
L = 1;

% Capacidad ideal (aproximada)
Cideal = epsilon*L*L/d;

% Distancia entre puntos con cargas fuente (discretizacion).
% Para el c. plano, es importante que h sea menor que d.
h = 2*L/N;

% Obtenemos vectores x, y, z con las coordenadas del plano superior
[x, y, z] = one_plane(d, L, N);

% Triangulación (aprovechando la simetria respecto el plano z=0)
[v1, v2, v3, un, cent, ds] = triangulacion(x, y, z, x, y);

% Obtención de la carga por Metodo de los momentos
M = length(cent);
Z = zeros(M);
for i = 1:M
    Z(i, :) = K*int_S_1divR(cent(:, i), v1, v2, v3, un, cent);
end
b = [V1 * ones(M/2, 1); V2 * ones(M/2,1)];
qn = Z\b;

% Representación de la geometría del objeto
figure('Color', 'white')
vx = [v1(1,:); v2(1,:); v3(1,:)];
vy = [v1(2,:); v2(2,:); v3(2,:)];
vz = [v1(3,:); v2(3,:); v3(3,:)];
fill3(vx, vy, vz, qn, 'EdgeAlpha', 0)
colorbar
colormap jet
saveas(gcf,'images/geometry.png')

figure('Color', 'white')
fill3(vx, vy, vz, 'g')
saveas(gcf,'images/geometry_raw.png')


%% Cálculo de la capacidad y comparación con ideal

% Capacidad obtenida numericamente
Q = dot(abs(qn), ds)/2;
dV = abs(V2 - V1);
C = Q/dV;

% Comparacion con la capacidad ideal del condensador
ea = abs(C-Cideal);
er = ea/Cideal;

%% Cálculo del potencial y campo eléctrico

% Parámetros de m
n = 11; % puntos por eje (potencial)
m = 8;  % puntos por eje (conos)

% Red Representacion 3D
x = linspace(-L/2, L/2, n);
y = linspace(-L/2, L/2, n);
z = linspace(-L/2, L/2, n);
[xx, yy, zz] = meshgrid(x,y,z);

V = zeros(n, n, n);
for i = 1:n
    for j = 1:n
        for k = 1:n
            V(i,j,k) = K*int_S_1divR([x(i);y(j);z(k)], v1, v2, v3, un, cent)*qn;
        end
    end
end
[Ex, Ey, Ez] = gradient(-V);
V2d = squeeze(V((n+1)/2,:,:));
[Ey2d, Ez2d] = gradient(-V2d);

cx = linspace(-L/2, L/2, m);
cy = linspace(-L/2, L/2, m);
cz = linspace(-L/2, L/2, m);
[cxx, cyy, czz] = meshgrid(cx,cy,cz);

%% Representación gráfica

% One slice surface plot (x=0)
figure('Color','white')
surf(y,z,V2d)
colorbar
colormap jet
shading interp
saveas(gcf,'images/one_slice_surface.png')

% One slice contour plot (x=0)
[yy2d, zz2d] = meshgrid(y,z);
figure('Color','white')
hold on
pcolor(z,y,V2d')
quiver(zz2d,yy2d,Ez2d,Ey2d)
contour(zz2d,yy2d,V2d, 'k')
colorbar
colormap jet
shading interp
hold off
saveas(gcf,'images/one_slice_contour.png')

% 3D Slice plot
figure('Color','white')
slice(xx,yy,zz,V,0,0,0)
colorbar
colormap jet
shading interp
hold on
coneplot(xx,yy,zz,Ex,Ey,Ez,cxx,cyy,czz,1);
hold off
saveas(gcf,'images/3d_slice.png')

% Countourslice plot
figure('Color','white')
slice(xx,yy,zz,V,[],[],0)
hold on
contourslice(xx,yy,zz,V,[],[],z)
colorbar
colormap jet
shading interp
hold on
coneplot(xx,yy,zz,Ex,Ey,Ez,cxx,cyy,czz,1)
hold off
saveas(gcf,'images/countourslice.png')