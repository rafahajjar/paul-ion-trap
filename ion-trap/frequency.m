clear;
close all;

%% Condensador hiperbolico: obtencion de la carga

% Parametro de discretizacion.
N = 15;

% Parametros de tamaño de la hiperbola
r0 = 1;
z0 = 0.3;
rmax = sqrt(2*z0^2+r0^2);
zmax = sqrt(z0^2+r0^2/2);

dt = 1e-5; % Timestep in seconds.
T = 0.01; % Total time in seconds;

% Potencial en cada placa hiperbolica del condensador
V = [0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100];
freq = zeros(size(V));
for j = 1:length(V)
    [qn, v1, v2, v3, un, cent, ds] = electrodes(V(j), r0, z0, N);
    trials = 100;
    time = zeros(1, trials);
    for i = 1:trials
        ri = initial_pos(r0, z0);
        vi = [0, 0, 0];
        time(i) = escape_time(ri, vi, qn, ds, cent, dt, T, r0, z0);
    end
    freq(j) = 1/mean(time);
end

plot(V, freq)

% freq = kV^a.
p = polyfit(log(V), log(freq), 1);
a = p(1); % a = 1/2
k = exp(p(2)); % k = 600

% Conclusion: f = 600sqrt(V), en unidades del SI.