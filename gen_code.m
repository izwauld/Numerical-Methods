function [A,b] = gen_code()
% ====================== Ax=b GENERATION CODE ======================

% This code generates the matrix A and right-hand side vector b for the
% system of equations Ax = b, where A is a block-tridiagonal n^2-by-n^2
% matrix whose main block-diagonal is built from matrices having -4 along
% the main diagonal and 1 along the upper- and lower-main diagonals; and
% above- and below-main block-diagonal identity matrices.

n = 10;

A = zeros(n*n,n*n); % initialize the LHS matrix

for i = 1:n^2
    A(i,i) = -4;
end
for i = 1:n:n^2 - 1
    for j = 1:n-1
        A(i+j-1,i+j) = 1;
        A(i+j,i+j-1) = 1;
    end
end
for i = 1:n^2 - n
    A(i,i+n) = 1;
    A(i+n,i) = 1;
end

b = zeros(n*n,1); % initialize the RHS vector
b(1) = 2;
b(n) = 2;
b(n^2-n+1) = 2;
b(n^2) = 2;
for i = 2:n-1
    b(i) = 1;
    b(n^2-i+1) = 1;
end
for i = n+1:n:n^2-n
    b(i) = 1;
    b(i+n-1) = 1;
end
end
