%DERIVAPP.m: Approximates the derivative of a function using forward &
%centered difference approaches
%--------------------------------------------------------------------------%

%Define interval end points and spacing values
a=0;b=3;
h=[0.01;0.05;0.1];

%Generate the derivative approximations using FD for all the
%h values
[f1,x1]=forDiff(a,b,h(1));
[f2,x2]=forDiff(a,b,h(2));
[f3,x3]=forDiff(a,b,h(3));

%Plot resulting approximations
figure(1);
hold on;

plot(x1,f1); plot(x2,f2); plot(x3,f3);
xlim([0,3]);
ylim([-4,3]);
xlabel('x');ylabel("f'(x)");
title('Derivative approximations using the FD approach');
legend('h=0.01','h=0.05','h=0.1','location','ne');
%---------------------------------------------------------------------%

%Generate the derivative approximations using CD for all the
%h values
[b1,y1]=centDiff(a,b,h(1));
[b2,y2]=centDiff(a,b,h(2));
[b3,y3]=centDiff(a,b,h(3));

%Plot resulting approximations
figure(2);
hold on;

plot(y1,b1); plot(y2,b2); plot(y3,b3);
xlim([0,3]);
ylim([-4,3]);
xlabel('x');ylabel("f'(x)");
title('Derivative approximations using the CD approach');
legend('h=0.01','h=0.05','h=0.1','location','ne');
%---------------------------------------------------------------------%

fprintf("The best approximation appears to be the centered-difference approximation with h=0.01.\n")