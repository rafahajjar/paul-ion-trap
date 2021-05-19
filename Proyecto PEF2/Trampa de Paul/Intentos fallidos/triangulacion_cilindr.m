function [v1, v2, v3, un, cent, Z] = triangulacion_cilindr(x, y, z, r, theta)
    vertex_up = [x; y; z];
    vertex_down = [x; y; -z];    
    topol = delaunay(r', theta')';
    v1 = [vertex_down(:,topol(1,:)), vertex_up(:,topol(1,:))];
    v2 = [vertex_down(:,topol(2,:)), vertex_up(:,topol(2,:))];
    v3 = [vertex_down(:,topol(3,:)), vertex_up(:,topol(3,:))];
    c = cross(v2-v1, v3-v1);
    ds = sqrt(sum(c.^2))/2;
    un = c./repmat(2*ds,3,1);
    cent =(v1+v2+v3)/3;
    
    M = length(cent);
    Z = zeros(M);
    for i = 1:M
        Z(i, :) = int_S_1divR(cent(:, i), v1, v2, v3, un, cent);
    end
end