%LEASTSQUARES.m: Fits a linear and quadratic function to a pre-defined
%data set using least-squares approximation
%--------------------------------------------------------------------------%

clear all;

%Call the function getData() which stores x,y values used
%to perform approximation
[u,v] = getData();

%-m is size of dataset, a is the intial x value, b is final x value
%-2x1 vector xL contains coefficients for linear fit (xP for quadratic fit)
%-p1,p2 & xk used for plotting the final approximating polynomials
%-tmp vectors used for calculating the error; l_error/q_error contain
%square errors for P_1 and P_2, respectively
m=size(u,1); n=10; a=0; b=2;
p1=zeros(n,1);p2=zeros(n,1);
tmp1=zeros(size(v,1));tmp2=zeros(size(v,1));
l_error=0; q_error=0;
xk=zeros(n,1);

%Define matrices used to solve for coefficients a,b,c;
%In linear case, writing/solving normal equations will yield
%a 2x2 matrix A1 (where A1*xL=b), and xL contains (2) coefficients.
%
%In quadratic case, writing/solving normal equations will yield
%3x3 matrix A2 (where A2*xP=b), and xP contains (3) coefficients.
%
%Also initialise veriables that hold summation of u(i), u(i)^2, and other 
%terms (that come from normal equations)
A1=zeros(2,2);
A2=zeros(3,3);
x1=0;x2=0;x3=0;x4=0;xy=0;x2y=0;y1=0;

%Sum over all data points to find various quantities
for i=1:m
    x4=x4+u(i)^4;
    x3=x3+u(i)^3;
    x2=x2+u(i)^2;
    x1=x1+u(i);
    xy=xy+u(i)*v(i);
    x2y=x2y+u(i)^2*v(i);
    y1=y1+v(i);
end


%-------Populate the matrix A1-------%
A1(1,1)=m;A1(1,2)=x1;A1(2,1)=x1;A1(2,2)=x2;


%-------Populate the matrix A2-------%
A2(1,2)=x1; A2(2,1)=x1;
A2(1,3)=x2; A2(3,1)=x2;
A2(2,3)=x3; A2(3,2)=x3;
A2(1,1)=m;A2(2,2)=x2;A2(3,3)=x4;


%Find linear coefficients by calling gaussElim, which solves A1*xL=b1
b1 = [y1;xy];
xL = gaussElim(A1,b1);

%Find quadratic coefficients by calling gaussElim, which solves A2*xP=b2
b2 = [y1;xy;x2y];
xP = gaussElim(A2,b2);

%Error calculation for linear & quadratic cases
for i=1:m
    tmp1(i)=xL(1)+xL(2)*u(i);
    tmp2(i)=xP(1)+xP(2)*u(i)+xP(3)*u(i)^2;
    l_error=l_error+(tmp1(i)-v(i)).^2;
    q_error=q_error+(tmp2(i)-v(i)).^2;
end

fprintf("Linear least squares error: %1.2e\n", l_error)
fprintf("Quadratic least squares error: %1.2e\n", q_error)

%Bonus: Generate uniformly distributed values of x to be supplied 
%to p1,p2 to obtain plots of P_1(x), P_2(x) 
for i=1:n
    if (i==1)
        xk(i)=a;
    elseif(i==n)
        xk(i)=b;
    else
        xk(i)=xk(i-1)+((b-a)/n);
    end
    p1(i)=xL(1)+xL(2)*xk(i);
    p2(i)=xP(1)+xP(2)*xk(i)+xP(3)*xk(i)^2;
end

%Plot the approximating functions
figure(1);
hold on;
plot(u,v,'.black', 'MarkerSize', 20);
plot(xk,p1);
plot(xk,p2);
xlim([0,2]);
xlabel('x');ylabel('y');
title('Linear (P_1) & Quadratic (P_2) fits to a given data set.');
legend('input data','P_1(x)','P_2(x)','location','nw');







%%for i=1:size(A2,1)
%    for j=1:size(A2,1)
%        if (i==1 && j==2)
%            A2(i,j)=x1; A2(j,i)=x1;
%        elseif (i==1 && j==3)
%            A2(i,j)=x2; A2(j,i)=x2;
%        elseif (i==2 && j==3)
%            A2(i,j)=x3; A2(j,i)=x3;
%        end
%    end 
%%end