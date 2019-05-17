%ITERSOLVER.m: Solves the system Ax=b using the Jacobi and Gauss-Seidel 
%iterative methods.
%--------------------------------------------------------------------------%

%Define the matrices A and b
[A,b] = gen_code();

%Set initial guess vector x0
a1=zeros(size(A,1),1); a2=a1-3;
x0 = [a1 a2];

%Set tolerance
tol=1E-6;


%Note: The solutions and guesses are written as single values to make
%output less crowded. A solution vector of '-1' means a column vector
%containing all -1's. The code would need modifications to work for a general
%system without a clean solution vector.

%-------Jacobi Iteration-------
for i=1:size(x0,2)
    [xJ,nIt,maxIt] = jacb(A,x0(:,i),b,tol);
    if(nIt>maxIt)
        fprintf("JACOBI METHOD SUMMARY:\n")
        fprintf("----------------------\n")
        fprintf("The system was not convergent!")
    else
        fprintf("JACOBI METHOD SUMMARY:\n")
        fprintf("----------------------\n")
        fprintf("SOLUTION VECTOR = %1.0e\n", xJ(1))
        fprintf("GUESS VECTOR = %1.0e\n", x0(i,i))
        fprintf("ITERATIONS = %d\n\n\n", nIt)
    end
end


%-------Gauss-Seidel Iteration-------
for i=1:size(x0,2)
    [xG,nIt,maxIt] = gSeid(A,x0(:,i),b,tol);
    if(nIt>maxIt)
        fprintf("GAUSS-SEIDEL METHOD SUMMARY:\n")
        fprintf("----------------------\n")
        fprintf("The system was not convergent!")
    else
        fprintf("GAUSS-SEIDEL METHOD SUMMARY:\n")
        fprintf("----------------------\n")
        fprintf("SOLUTION VECTOR = %1.0e\n", xG(1))
        fprintf("GUESS VECTOR = %1.0e\n", x0(i,i))
        fprintf("ITERATIONS = %d\n\n\n", nIt)
    end
end

