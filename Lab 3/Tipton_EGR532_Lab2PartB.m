%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Multidimensional Signal Processing
% Filename: Tipton_EGR532_Lab2PartB.m
% Author: Natalie Tipton
% Date: 1/29/18
% Instructor: Dr. Rhodes
% Description: This script completes steps outlines in LE #2 Part B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B %%%%%%%%%%

%create delta x and delta y
x_B = 0 : 0.01 : 0.99;
rows = 0 : 0.01: 0.99;
y_B = rows(:);

%declare range of x and y sizes
M = 100;
N = 100;

%calculate f(m,n)
f_mn = sin(4 * pi .* x_B) + cos(6 * pi .* y_B);

%allocate same size as f(m,n) to F(u,v)
F_uv = zeros(size(f_mn));

tic;    %start stopwatch

%compute double summation for DFT
summation = 0;
for u = 0 : M-1
    for v = 0 : N-1
        summation = 0;
        for m = 0 : M-1
            for n = 0 : N-1
               summation = summation + f_mn(m+1,n+1) .* exp(-1j*2*pi * (m.*u./M + n.*v./N));
            end
        end
        F_uv(u+1,v+1) = summation;
    end
end
elapsedTime = toc;  %stop stopwatch

%in subplots, plot f(m,n) and the absolute value of the FT F(u,v)
colormap;
subplot(1,2,1);
mesh(f_mn);
title("f(m,n)");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");
subplot(1,2,2)
imagesc(abs(F_uv));
title("F(u,v)");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");
