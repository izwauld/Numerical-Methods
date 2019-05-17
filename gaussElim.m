function x = gaussElim(A,b)
%GAUSSELIM.m: Finds the solution, x, of a given system of linear equations
%allowing for row interchanges if necessary.
%INPUT: nxn matrix A and nx1 matrix b
%--------------------------------------------------------------------------%

format short;

%set dimension & x
n=size(A,1);
x=zeros(n,1);

%augment matrix
A=[A b];

%Make matrix upper triangular: leave diagonal entry 
%for each column, replace entries below with 
%itself minus K times the pivot row.
%
%Also checks if diagonal entry is zero at every step
%of elimination. If so, then interchanges current
%row with each row beneath it until A(i,i) is non-zero.
for i=1:(n-1)
	d=i+1;
	while ((A(i,i)==0) && (d<n))
		A([i d],:)=A([d i],:);
		d=d+1;
	end
    K=A(i+1:end,i)./A(i,i);
    A(i+1:end,:)=A(i+1:end,:)-K*A(i,:);
end

%Reassign b
b=A(:,size(A,2));

%For each of x1,...,xn, find sum of
%every term aside from a_nn*x_nn (subTerm), subtract
%from solution b(j) for each row j, and
%then divide by a_jj to get x_j
for j=n:-1:1
    subTerm=0;
    for k=1:n
        subTerm=subTerm+A(j,k)*x(k);
    end
    x(j)=(b(j)-subTerm)/A(j,j);
end

end
