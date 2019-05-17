function [f,x] = centDiff(a,b,h)
%CENTDIFF.m: Approximates the derivative of a function using the centered
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

%Use forward difference for x=a
tmp=sin(pi*(x(1)+h-2))*exp(-(x(1)+h-1)^2) - sin(pi*(x(1)-2))*exp(-(x(1)-1)^2);
f(1)=tmp/h;

%Use centered difference for x on interval (a,b)
for i=2:n-1
    tmp=sin(pi*(x(i)+h-2))*exp(-(x(i)+h-1)^2) - sin(pi*(x(i)-h-2))*exp(-(x(i)-h-1)^2);
    f(i)=tmp/(2*h);
end

%Use backward difference for x=b
tmp=sin(pi*(x(n)-2))*exp(-(x(n)-1)^2) - sin(pi*(x(n)-h-2))*exp(-(x(n)-h-1)^2);
f(n)=tmp/h;
end