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

%% Calculo trayectoria de 1 ion

dt = 1e-5; % Timestep in seconds.
T = 0.1;  % Total time in seconds.
f = 640;   % Frequency in hertzs.
steps = round(T/dt);

ri = initial_pos(r0, z0);
vi = [0, 0, 0];
[r, v, a] = trajectory_AC(ri, vi, qn, ds, cent, dt, T, f);

%% Representación gráfica
close all;

vx = [v1(1,:); v2(1,:); v3(1,:)];
vy = [v1(2,:); v2(2,:); v3(2,:)];
vz = [v1(3,:); v2(3,:); v3(3,:)];

figure('Color','white','Position',[250,100,1000,800])
ax = axes;
set(ax,'xlim',[-rmax rmax],'ylim',[-rmax rmax],'zlim',[-zmax zmax]);
view(ax, 3)
axis equal
hold(ax)
s = fill3(ax, vx, vy, vz, qn, 'EdgeAlpha', 0, 'FaceAlpha', .3);
colormap jet

comet3(ax, r(:, 1), r(:, 2), r(:, 3))

%p = plot3(ax, r(1, 1), r(1, 2), r(1, 3), 'k');
%video = VideoWriter('videos/single_ion_AC', 'MPEG-4');
%open(video);
%period = 1/f;
%t = 0;
%for k = 1:steps
%    pause(.001)
%    if t > period
%        t = t - period;
%        qn = -qn;
%        set(s, 'FaceColor', qn)
%    end
%    set(p, 'XData', r(1:k,1), 'YData', r(1:k,2), 'ZData', r(1:k,3))
%    t = t+dt;
%end
%close(video);

%p = plot3(ax, r(1, 1), r(1, 2), r(1, 3), 'k*');
%filename = 'videos/single_ion_AC.gif';
%for k = 1:steps
%      set(p, 'XData', r(k,1), 'YData', r(k,2), 'ZData', r(k,3))
%      frame = getframe(gcf);
%      im = frame2im(frame);
%      [imind,cm] = rgb2ind(im,256);
%      if k == 1
%          imwrite(imind,cm,filename,'gif','Loopcount',inf);
%      else
%          imwrite(imind,cm,filename,'gif','WriteMode','append');
%      end
%end