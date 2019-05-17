%MULTNEWTONMETHOD.m: Finds the solution of the given system of equations
%defined in callFunctions() using a tolerance e = 1E-4.
%--------------------------------------------------------------------------%

format long;

%import pre-defined functions; returns F=[f1;f2;f3]
%& the jacobian matrix of F, JF.
[F,Jf] = callFunctions();

%set initial guess & tolerance
x=[2;2;2];
tol=1E-4;

%set number of iterations
nIt=1;

% Check if norm of distance between current approximation
% and previous is greater than tolerance; if so, continue, 
% and increment nIt by 1; when it isn't, we can stop.
while (norm(F(x(1),x(2),x(3))) > tol)
    x=x-Jf(x(1),x(2),x(3))\F(x(1),x(2),x(3));
    nIt=nIt+1;
end

fprintf('Iterations: %d\nFinal Approximation: (x,y,z) = (%d,%d,%d)\nTolerance: %1.2e\n', nIt, x(1), x(2), x(3), tol)

