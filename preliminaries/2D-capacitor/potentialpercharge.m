function potential = potentialpercharge(z, loc, h)
    epsilon = 8.854e-12;
    if abs(z-loc) < 1e-9
        potential = -h*(log(h/2)-1)/(2*pi*epsilon);
    else
        potential = -h*log(abs(z - loc))/(2*pi*epsilon);
    end
end