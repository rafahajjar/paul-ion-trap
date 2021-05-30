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

%% Comparacion entre señal senoidal y triangular

dt = 1e-5; % Timestep in seconds.
T = 0.1;  % Total time in seconds.
% Frequencies used for article, very slow to run:
%  f = [660	665	668	669 670	672	674	676	678	680	682	684	686	688	690	692	694 695	700];
f = 670:2:676;
trials = 10; % Number of trials per frequency
s = zeros(1, length(f));
t = zeros(1, length(f));

for i = 1:length(f)
    for j = 1:trials
        [sinusoidal, triangular] = stays_1ion(r0, z0, qn, ds, cent, dt, T, f(i));
        %[sinusoidal, triangular] = stay_2ions(r0, z0, qn, ds, cent, dt, T, f(i));
        s(i) = s(i) + sinusoidal;
        t(i) = t(i) + triangular;
    end
end
s = s./trials;
t = t./trials;

figure (1)
plot(f, s, '-s', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerEdgeColor','blue','MarkerFaceColor',[0.5 1 0]);
grid on
hold on
plot(f, t, '-s', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerEdgeColor','red','MarkerFaceColor',[1 .8 .6]);
set(gca,'FontSize',12)
title("Success comparison for different AC signals",'FontSize', 22);
xlabel("Frequency (Hz)",'FontSize', 20);
ylabel("Ratio of success",'FontSize', 20);
legend({'Sinusoidal', 'Triangular'},'Location','northwest','FontSize', 16, 'Interpreter','latex');
saveas(gcf,'images/comparison_AC.png')

% Conclusions about the trap's minimum frequency:
% Para el AC sinusoidal, f = 950*sqrt(V), transition of 5Hz
% Para el AC triangular, f = 969*sqrt(V), transition of 20Hz
