function I = intgrt(arg,xpts,dx)
% function to compute integral of a given integrand "arg"
I = arg(1);
for i = 2:2:xpts-1
    I = I + 4*arg(i) + 2*arg(i+1);
    % warning: this adds 2*arg(xpts), so subtract arg(xpts)
end
I = I - arg(xpts);
I = I*dx/3;
end