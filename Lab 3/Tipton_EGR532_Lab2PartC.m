%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Multidimensional Signal Processing
% Filename: Tipton_EGR532_Lab2PartC.m
% Author: Natalie Tipton
% Date: 1/29/18
% Instructor: Dr. Rhodes
% Description: This script completes steps outlines in LE #2 Part C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part C %%%%%%%%%%

%create delta x and delta y
x_B = 0 : 0.01 : 0.99;
rows = 0 : 0.01: 0.99;
y_B = rows(:);

%declare size of x and y dimensions for matrix
M  = 100;
N = 100;

%calculate f(m,n)
f_mn = sin(4 * pi .* x_B) + cos(6 * pi .* y_B);

%allocate size to 1D FT matrices
Fy = zeros(size(f_mn));
Fx = zeros(size(f_mn));

tic;    %start stopwatch
%loop through u and x to calculate 1D FT Fy
for u = 0 : (M-1) 
    for x = 0 : (M-1)
        Fy(u+1,x+1) = exp(-1j * 2 * pi * x * u / M);
    end
end

%loop through v and y to calculate 1D FT Fx
for v = 0 : (N-1)
    for y = 0 : (N-1)
        Fx(v+1,y+1) = exp(-1j * 2 * pi * y * v / N);
    end
end

%multiply the 1D FTs with 2D f(m,n)
F_uv = Fy * f_mn * Fx;
elapsedTime = toc;  %stop stopwatch

%in subplots, plot f(m,n) and amplitude of F(u,v)
subplot(1,2,1);
mesh(f_mn);
title("f(m,n)");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");
subplot(1,2,2);
imagesc(abs(F_uv));
title("F(u,v)");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");
        