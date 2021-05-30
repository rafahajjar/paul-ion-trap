clear;
close all;
set(0,'defaulttextinterpreter','latex')
addpath('utils')

%% Condensador hiperbolico: obtencion de la carga

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

dt = 1e-5; % Timestep in seconds.
T = 0.01; % Total time in seconds;

[qn, v1, v2, v3, un, cent, ds] = electrodes(1, r0, z0); % qn for V=1

% Potencial en cada placa hiperbolica del condensador
V = [0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100];
freq = zeros(size(V));
for j = 1:length(V)
    q = qn*V(j); % La carga depende linealmente del potencial
    trials = 100;
    time = zeros(1, trials);
    for i = 1:trials
        ri = initial_pos(r0, z0);
        vi = [0, 0, 0];
        time(i) = escape_time(ri, vi, q, ds, cent, dt, T, r0, z0);
    end
    freq(j) = 1/mean(time);
end

figure ('Position',[0,100,500,300], 'Color', 'white')
plot(V, freq, 'LineWidth', 2);
grid on
title("Inverse averaged period for each $V$",'FontSize', 20);
xlabel("$V$",'FontSize', 20);
ylabel("$1/T$",'FontSize', 20);
saveas(gcf,'images/freq_vs_potential.png')

figure ('Position',[0,100,500,300], 'Color', 'white')
plot(log(V), log(freq), 'LineWidth', 2);
grid on
set(gca,'FontSize',12)
title("Average escape time vs potential",'FontSize', 22);
xlabel("$\log V$",'FontSize', 20);
ylabel("$\log(1/T)$",'FontSize', 20);
saveas(gcf,'images/logfreq_vs_logpotential.png')


% freq = kV^a.
p = polyfit(log(V), log(freq), 1);
a = p(1); % a = 1/2
k = exp(p(2)); % k = 1000

% Conclusion: f = 1000sqrt(V), en unidades del SI.

Ve = 0.5;
f = k*Ve^a;

% Conclusion: f = const*sqrt(V), en unidades del SI.
