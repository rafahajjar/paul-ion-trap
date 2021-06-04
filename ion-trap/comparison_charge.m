clear;
close all;
addpath('utils')

%% Condensador hiperbolico: obtencion de la carga

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

V = 1;
[qn, v1, v2, v3, un, cent, ds] = electrodes(V, r0, z0);

%% Halla el máximo potencial de la trampa para cada N

dt = 1e-4; % Timestep in seconds.
T = 0.1;  % Total time in seconds.
f = 1000;
N = [1, 2, 5, 10, 20, 50, 100, 200];
minV = zeros(1, length(N));
%v = [1, 2, 5, 10, 20, 30, 50, 70, 100, 200, 300, 500, 1000];
v = 10.^(0:0.2:3);
for i = 1:length(N)
    qi = 1.60e-19 * ones(N(i), 1);
    mi = 30*1.66e-27 * ones(N(i), 1);
    for j = 1:length(v)
        s = stay(r0, z0, qn/v(j), ds, cent, dt, T, f, N(i), qi*v(j), mi);
        if s == 1
            minV(i) = v(j);
        else
            break
        end
    end
end

%% Plot

figure('Position',[0,100,1000,600],'Color','white')
grid on
hold on
set(gca,'FontSize',12)
plot(log10(N), log10(minV), '-s', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerEdgeColor','blue','MarkerFaceColor',[0.5 1 0])
xlabel('Number of ions (log)','FontSize', 20,'Interpreter','latex')
ylabel('Max. charge scale factor (log)','FontSize', 20,'Interpreter','latex')
saveas(gcf,'images/multiple_ions.png')

