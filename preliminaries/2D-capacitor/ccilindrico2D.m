clear;
close all;

% Numero de cargas fuente en la discretizacion
N = 200;

% Constantes fisicas
epsilon = 8.854e-12;
K = 1/(4*pi*epsilon);

%% Condensador cilíndrico

% Dimensiones
d = 2;
R = 1;

% Capacidad ideal por unidad de longitud (exacta)
Cideal = pi*epsilon/acosh(d/R);

% Potencial en cada placa del condensador (abajo y arriba resp.)
V1 = 0.5;
V2 = -0.5;

% Distancia entre puntos con cargas fuente (discretizacion).
h = 4*pi*R/N;

% Geometria discretizada 2D del condensador plano
loc = zeros(N, 1);
for i = 1:N
    if i <= N/2
        loc(i) = (R*cos(4*pi*i/N)-d) + 1i * (R*sin(4*pi*i/N));
    else 
        loc(i) = (R*cos(4*pi*i/N)+d) + 1i * (R*sin(4*pi*i/N));
    end
end

%% Metodo de los momentos

% Preparacion de Z
Z = zeros(N);
for i = 1:N
    for j = 1:N
        Z(i, j) = potentialpercharge(loc(i), loc(j), h);
    end
end

% Preparacion de b
b = [V1 * ones(N/2, 1); V2 * ones(N/2,1)];

% Resolucion de la ecuacion integral discretizada
qn = Z\b;

% Capacidad por unidad de longitud obtenida numericamente
Q = h*sum(abs(qn))/2;
dV = abs(V2 - V1);
C = Q/dV;

% Comparacion con la capacidad ideal del condensador
ea = abs(C-Cideal);
er = ea/Cideal;

% Representacion 2D
x = linspace(-2*d, 2*d, 21);
y = linspace(-2*d, 2*d, 21);
[xx, yy] = meshgrid(x,y);
rr = xx + 1i*yy;

V = zeros(length(y), length(x));
for i = 1:length(y)
    for j = 1:length(x)
        for k = 1:length(loc)
            V(i,j) = V(i,j) + qn(k)*potentialpercharge(rr(i,j), loc(k), h);
        end
    end
end
[Ex, Ey] = gradient(-V);

surf(x,y,V)
colorbar
colormap jet
shading interp
set(gcf,'color','white')
saveas(gcf,'images/V_cilindric.png')

figure(2)
hold on
pcolor(x,y,V)
quiver(xx,yy,Ex,Ey)
contour(xx,yy,V)
colorbar
colormap jet
shading interp
axis equal
set(gcf,'color','white')
saveas(gcf,'images/E_cilindric.png')