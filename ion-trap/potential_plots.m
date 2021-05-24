clear;
close all;

%% Condensador hiperbolico: obtencion de la carga

% Constantes fisicas
epsilon = 8.854e-12;
K = 1/(4*pi*epsilon);

% Potencial en cada placa hiperbolica del condensador
V = 0.5;

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

[qn, v1, v2, v3, un, cent, ds] = electrodes(V, r0, z0);

%% Creación de las mallas. Cálculo del potencial y campo eléctrico

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

%% Representación gráfica

% One slice surface plot (x=0)
figure('Color','white')
surf(y,z,V2d')
colorbar
colormap jet
shading interp
axis equal
saveas(gcf,'images/one_slice_surface.png')

% One slice contour plot (x=0)
[yy2d, zz2d] = meshgrid(y,z);
figure('Color','white')
pcolor(y,z,V2d')
colorbar
colormap jet
shading interp
axis equal
hold on
quiver(yy2d(2:end-1,2:end-1),zz2d(2:end-1,2:end-1),Ez2d(2:end-1,2:end-1)',Ey2d(2:end-1,2:end-1)',.5)
contour(yy2d,zz2d,V2d', 'k')
hold off
saveas(gcf,'images/one_slice_contour.png')

% 3D Slice plot
figure('Color','white')
slice(xx,yy,zz,V,0,0,0)
colorbar
colormap jet
shading interp
axis equal
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
axis equal
hold on
coneplot(xx,yy,zz,Ex,Ey,Ez,cxx,cyy,czz,.5)
hold off
saveas(gcf,'images/countourslice.png')