%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Multidimensional Signal Processing
% Filename: Tipton_EGR532_Lab2PartD.m
% Author: Natalie Tipton
% Date: 1/29/18
% Instructor: Dr. Rhodes
% Description: This script completes steps outlines in LE #2 Part D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part D %%%%%%%%%%

%create delta x and delta y
x_B = 0 : 0.01 : 0.99; 
rows = 0 : 0.01: 0.99;
y_B = rows(:);

%declare dimensions of matrix
M  = 100;
N = 100;

%calculate f(m,n)
f_mn = sin(4 * pi .* x_B) + cos(6 * pi .* y_B);

tic;    %start stopwatch
%using MATLAB function to determine F(u,v) given f(m,n)
F_uv = fft2(f_mn);
elapsedTime = toc;  %stop stopwatch

%shift findings to center of image
F_uv_shift = fftshift(F_uv);

%in subplots, plot f(m,n) and amplitude of F(u,v)
subplot(1,2,1)
mesh(f_mn)
title("f(m,n)");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");
subplot(1,2,2)
imagesc(abs(F_uv_shift))
title("F(u,v)");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");