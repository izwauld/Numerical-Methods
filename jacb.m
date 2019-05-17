function [x,k,maxIt] = jacb(A,x0,b,tol)
%JACB.m: Finds the solution of the system of equations using
%the Jacobi iteration method
%----------------------------------------------------------------

%Set dimension and -- since we solve x(n+1)=(I-D\A)xn + D\b --
%find I, D\A=inv(D)*A and D\b=inv(D)*b.
n=size(A,1);
x=zeros(size(x0,1),1);
D=diag(diag(A));
I=eye(n);
term1=I-D\A;
term2=D\b;

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