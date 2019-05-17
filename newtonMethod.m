%NEWTONMETHOD.m: Finds the zeros of the function f using different initial
%values and tolerances
%--------------------------------------------------------------------------%

format long;

%f(x) & f'(x)
f = @(x) x^2*cos((x^2/100)-25) - (x^3) + 5;
diff = @(x) 2*x*cos((x^2/100)-25) - (x^3/50) * sin((x^2/100)-25) ...
    - 3*x^2;

%set tolerances
eps = [1E-6, 1E-10];

%set initial approximations
initial_approx = [8,5,2];

%loop over all the values of the initial approximations
%for each tolerance
for i = 1:length(initial_approx)
    %initialise approximation
    xn = initial_approx(i);
    
    for j = 1:length(eps)
        %track number of iterations
        iter = 0;
        
        % Check if abs(x(n+1)-x(n)) is greater than tolerance - if yes, 
        % then continue to approximate. If not, then algorithm has
        % converged.
        % NOTE: abs(f(xn)/diff(xn)) is used since x(n+1)-x(n) = -f(x(n))/diff(x(n))
        while (abs(f(xn)/diff(xn)) > eps(j))
            xn1 = xn - (f(xn)/diff(xn));
            xn = xn1;
            iter = iter + 1;
        end
        % Print number of iterations, tolerance & initial approximation 
        % for that run
        fprintf('---------------\n');
        fprintf('The final approximation is x = %d, using %d iterations, with tolerance = %1.2e, and initial approximation x = %d.\n', ...
             xn, iter, eps(j), initial_approx(i));
      
        % Reset xn to the initial approximation
        xn = initial_approx(i);
    end
end

fprintf('DONE!\n')

