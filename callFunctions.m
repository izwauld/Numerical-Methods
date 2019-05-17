function [F , Jf] = callFunctions()
F = @(x,y,z) [x + exp(y*z - 1) - 2; 0.5*x*z^2 + y - 1.5; z - x - y^3 + 1];
Jf = @(x,y,z) [1  z*exp(y*z - 1) y*exp(y*z - 1); ...
    0.5*z^2 1 x*z; -1 -3*y^2 1];
end