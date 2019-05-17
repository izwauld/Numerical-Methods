function [f,x] = forDiff(a,b,h)
%FORDIFF.m: Approximates the derivative of a function using the forward
%difference approach
%--------------------------------------------------------------------------%

%Define number of nodes, initilise function and x vectors
%Also, populate x with evenly spaced number of nodes
n=(b-a)/h;
f=zeros(n,1);x=zeros(n,1);
x(1)=a;x(n)=b;
for i=2:(n-1)
    x(i)=x(i-1)+h;
end

%Use forward difference for x on interval [a,b)
for i=1:(n-1)
    tmp=sin(pi*(x(i)+h-2))*exp(-(x(i)+h-1)^2) - sin(pi*(x(i)-2))*exp(-(x(i)-1)^2);
    f(i)=tmp/h;
end

%At x=b, use backward-difference
tmp=sin(pi*(x(n)-2))*exp(-(x(n)-1)^2) - sin(pi*(x(n)-h-2))*exp(-(x(n)-h-1)^2);
f(n)=tmp/h;
end

