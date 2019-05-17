function a = get_a(phi,f,dx)

npts=length(f);
arg1=zeros(size(f,1),1);
arg2=zeros(size(f,1),1);

for i = 1:npts
    arg1(i)=phi(i)*f(i);
    arg2(i)=(phi(i))^2;
end

a = intgrt(arg1,npts,dx)/intgrt(arg2,npts,dx);