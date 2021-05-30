clear;
close all;

% Numero de cargas fuente en la discretizacion
N = 200;

% Constantes fisicas
epsilon = 8.854e-12;
K = 1/(4*pi*epsilon);

%% Condensador plano

% Dimensiones
d = 0.05;
L = 1;

% Capacidad ideal por unidad de longitud (aproximada)
Cideal = epsilon*L/d;

% Potencial en cada placa del condensador (abajo y arriba resp.)
V1 = 0.5;
V2 = -0.5;

% Distancia entre puntos con cargas fuente (discretizacion).
% Para el c. plano, es importante que h sea menor que d.
h = 2*L/N;

% Geometria discretizada 2D del condensador plano
loc = zeros(N, 1);
for i = 1:N
    if i <= N/2
        loc(i) = (L/(N/2))*(i-1)-L/2+h/2 - 1i*d/2;
    else 
        loc(i) = (L/(N/2))*(i-1-N/2)-L/2+h/2 + 1i*d/2;
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
x = linspace(-L/2, L/2, 41);
y = linspace(-d, d, 11);
[xx, yy] = meshgrid(x,y);
rr = xx + 1i*yy;

V = zeros(11, 41);
for i = 1:11
    for j = 1:41
        for k = 1:length(loc)
            V(i,j) = V(i,j) + qn(k)*potentialpercharge(rr(i,j), loc(k), h);
        end
    end
end
[Ex, Ey] = gradient(-V);

figure('Color', 'white')
surf(x,y,V)
colorbar
colormap jet
shading interp
saveas(gcf,'images/V_planar.png')

figure('Color', 'white')
hold on
pcolor(x,y,V)
quiver(xx,yy,Ex,Ey)
contour(xx,yy,V)
colorbar
colormap jet
saveas(gcf,'images/E_planar.png')
shading interp