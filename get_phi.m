function phi = get_phi(x,dx,pkm1,pkm2)

phi = zeros(size(x));
npts=length(x);
arg1=zeros(size(x));arg2=zeros(size(x));
arg3=zeros(size(x));arg4=zeros(size(x));

for i = 1:npts
    arg1(i)=x(i)*(pkm1(i)^2);
    arg2(i)=x(i)*pkm1(i)*pkm2(i);
    arg3(i)=(pkm1(i)^2); arg4(i)=(pkm2(i)^2);
end

B = intgrt(arg1,npts,dx)/intgrt(arg3,npts,dx);
C = intgrt(arg2,npts,dx)/intgrt(arg4,npts,dx);

for i=1:npts
    phi(i)=(x(i)-B)*pkm1(i)-C*pkm2(i); 
end

end