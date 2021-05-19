clear;
close all;

% Parametro de discretizacion.
N = 15;

% Constantes fisicas
epsilon = 8.854e-12;
K = 1/(4*pi*epsilon);
qe = 1.6e-19;
mp = 1.6749e-27;

%% Condensador hiperbolico: geometria y obtencion de la carga

% Potencial en cada placa hiperbolica del condensador
Vint = 0.5; % Dos hojas
Vext = -0.5; % Una hoja

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

% Obtenemos vectores x, y, z con las coordenadas de las hiperbolas
[xint, yint, zint] = two_sheets_hyperboloid(r0, z0, N);
[xext, yext, zext, rs, thetas] = one_sheet_hyperboloid(r0, z0, N);

% Triangulacion de los hiperboloides (con simetria respecto z=0)
[i1, i2, i3, iun, icent, ids] = triangulacion(xint, yint, zint, xint, yint);
[e1, e2, e3, eun, ecent, eds] = triangulacion(xext, yext, zext, rs, thetas);

v1 = [i1, e1];
v2 = [i2, e2];
v3 = [i3, e3];
un = [iun, eun];
cent = [icent, ecent];
ds = [ids, eds];

% Obtención de la carga sobre los hiperboloides
M = length(cent);
Z = zeros(M);
for i = 1:M
    Z(i, :) = K*int_S_1divR(cent(:, i), v1, v2, v3, un, cent);
end
b = [(Vint * ones(length(icent), 1)); Vext * ones(length(ecent), 1)];
qn = Z\b;

% Representación de la geometria del objeto
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

%% Cálculo del potencial y campo eléctrico

n = 21; % Nº puntos malla de potencial
m = 7;  % Nº puntos malla de conos

% Representacion 3D
x = linspace(-rmax, rmax, n);
y = linspace(-rmax, rmax, n);
z = linspace(-zmax, zmax, n);
[xx, yy, zz] = meshgrid(x,y,z);

V = zeros(n, n, n);
for i = 1:n
    for j = 1:n
        for k = 1:n
            V(i,j,k) = K*int_S_1divR([x(i);y(j);z(k)], v1, v2, v3, un, cent)*qn;
            if i == (n+1)/2
            end
        end
    end
end
[Ex, Ey, Ez] = gradient(-V);
V2d = squeeze(V((n+1)/2,:,:));
[Ey2d, Ez2d] = gradient(-V2d);

cx = linspace(-rmax, rmax, m);
cy = linspace(-rmax, rmax, m);
cz = linspace(-zmax, zmax, m);
[cxx, cyy, czz] = meshgrid(cx,cy,cz);

%% Calculo trayectoria de 1 ion

h = 1e-6; % Timestep in seconds.
T = 0.01; % Total time in seconds;
steps = T/h;

ri = pos_inicial(r0, z0);
vi = [0, 0, 0];
[r, v, a] = trayectoria(ri, vi, qn', ds, cent, h, steps);

%% Representación gráfica

% One slice surface plot (x=0)
figure('Color','white')
surf(y,z,V2d')
colorbar
colormap jet
shading interp
saveas(gcf,'images/one_slice_surface.png')

% One slice contour plot (x=0)
[yy2d, zz2d] = meshgrid(y,z);
figure('Color','white')
hold on
pcolor(z,y,V2d')
quiver(zz2d,yy2d,Ez2d,Ey2d,.5)
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
coneplot(xx,yy,zz,Ex,Ey,Ez,cxx,cyy,czz,.5);
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
coneplot(xx,yy,zz,Ex,Ey,Ez,cxx,cyy,czz,.5)
hold off
saveas(gcf,'images/countourslice.png')
