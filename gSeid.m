function [x,k,maxIt] = gSeid(A,x0,b,tol)
%GSEID.m: Finds the solution of the system of equations using
%the Gauss-Seidel iteration method
%----------------------------------------------------------------

%Set dimension, the (negative) upper triangular part of A, U, and find I-(A+U)\A
%and (A+U)\b, since x(n+1)=(I-(A+U)\A)x(n) + (A+U)\b for G-S.
n=size(A,1);
U=triu(A,1);
D=diag(diag(A));
x=zeros(size(x0,1),1);
I=eye(n);
term1=I-(A-U)\A;
term2=(A-U)\b;

%set the iteration number num, index k and max # of
%iterations 
k=1;
num=2;
maxIt=1000;

%intialise starting values in output matrix of guesses; 
%first value of 'out' is unimportant (only to make the while condition
%true the first time around)
out=zeros(n,1);out(:,num)=x0;out(:,num-1)=rand(n,1);

while(max(abs(out(:,num)-out(:,num-1))) > tol)
    x0=term1*x0+term2;
    x=x0;
    num=num+1;k=k+1;
    out(:,num)=x;
    if(k>maxIt)
        break
    end
end

end



