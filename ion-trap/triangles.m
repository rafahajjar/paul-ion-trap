function [v1, v2, v3, un, cent, ds] = triangles(x, y, z, param1, param2)
    vertex_up = [x; y; z];
    vertex_down = [x; y; -z];    
    topol = delaunay(param1', param2')';
    v1 = [vertex_down(:,topol(1,:)), vertex_up(:,topol(1,:))];
    v2 = [vertex_down(:,topol(2,:)), vertex_up(:,topol(2,:))];
    v3 = [vertex_down(:,topol(3,:)), vertex_up(:,topol(3,:))];
    c = cross(v2-v1, v3-v1);
    ds = sqrt(sum(c.^2))/2;
    un = c./repmat(2*ds,3,1);
    cent =(v1+v2+v3)/3;
end