%FNAPPROXLP.m: Approximates the function f(x) using Legendre polynomials.
%--------------------------------------------------------------------------%

%Get data by calling fx_vals()
[x,f] = fx_vals;

%Initialise a_k, highest legendre polynomial degree Nmax
%the square error l2norm (randomly set initially (>tol)), tolerance for 
%convergence, etc.
%----------------------%
a=zeros(size(f,1),1);
arg=zeros(size(f));
Nmax = 10;
N=0;
npts=length(f);
L2norm=5;
tol = 1E-2;
%----------------------%

%Initialise the approximating polynomial Pk, and the legendre 
%polynomials pk. pkm1 & pkm2
Pk = zeros(size(f));
pk=zeros(size(f));pkm1=zeros(size(f));pkm2=zeros(size(f));

%----------------------------------------------------%
%   CASE 1: CHECKING IF P0 OR P1 converge to f(x)    %
%----------------------------------------------------%

%Store phi(0), phi(1) in pkm2, pkm1 respectively
for i=1:npts
   pkm2(i)=1;
   pkm1(i)=x(i);
end

%Set dx (used in intgrt.m) 
dx=x(2)-x(1);

%Test case for P0 and P1 convergence
while (L2norm > tol && N<2)
    N=N+1;
    %If we are approximating P2 (N=2), then 
    %pass pkm1 to get_a and add a(2)*pkm1(i) onto
    %Pk(i), and calc square error term; else, we are
    %finding a(1)*pkm2(i)
    if (N==2)
        a(N)=get_a(pkm1,f,dx);
        for i=1:npts
            Pk(i)=Pk(i)+a(N)*pkm1(i);
            arg(i)=(f(i)-Pk(i))^2;
        end
    else
        a(N)=get_a(pkm2,f,dx);
        for i=1:npts
            Pk(i)=a(N)*pkm2(i);
            arg(i)=(f(i)-Pk(i))^2;
        end
    end
    %Find the least-square error term (which is compared to while
    %condition) and increment N
    L2norm = sqrt(intgrt(arg,npts,dx)); 
end

%--------------------------------------------------------%
%   CASE 2: TESTING CONVERGENCE OF ORDER>2 POLYNOMIALS   %
%--------------------------------------------------------%


%If P0 or P1 didn't converge, while loop is triggered:
while(L2norm>tol && N<=Nmax)
    N=N+1;
    %Calculate kth L.P by calling get_phi() & get corresponding a_k
    pk = get_phi(x,dx,pkm1,pkm2);
    a(N)=get_a(pk,f,dx);
    %Add on a_k*phi_k to existing Pk
    for i=1:npts
        Pk(i)=Pk(i)+a(N)*pk(i);
        arg(i)=(f(i)-Pk(i))^2;
    end
    
    %As usual, find associated square-error term
    L2norm = sqrt(intgrt(arg,npts,dx)); 
    
    %Update values of pkm2,pkm1 to latest (k-1),(k-2)th phi's &
    %increment N
    pkm2=pkm1;
    pkm1=pk;
end



%Miscounted N by one, and MATLAB indexes from one and not zero (as in lab
%notation) so subtract two from it to get final order of legendre
%polynomial
N=N-1;
fprintf('Order of convergent Legendre polynomial (n): %d \n', N)

%Now, we visulise the approximating polynomial Pk and the function f(x):
figure(1)
hold on
plot(x,f)
plot(x,Pk)

xlabel('x')
ylabel('f(x)/Pn(x)')
title('f(x) & Pn(x)')
legend('f(x)','Pn(x)','location','nw')





