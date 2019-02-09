%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Multidimensional Signal Processing
% Filename: Tipton_EGR532_Lab2PartA.m
% Author: Natalie Tipton
% Date: 1/29/18
% Instructor: Dr. Rhodes
% Description: This script completes steps outlines in LE #2 Part A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A %%%%%%%%%%

%create delta x and delta y
x_A = 0 : 0.01 : 1.99;
rows = 0 : 0.01 : 1.99;
y_A = rows(:);

%declare different u naughts
u0_a = 1;
u0_b = 2;
u0_c = 4;
u0_d = 4;
u0_e = 4;
u0_f = 4;

%declare different v naughts
v0_a = 0;
v0_b = 0;
v0_c = 0;
v0_d = 1;
v0_e = 2;
v0_f = 4;

%calculate sinusoids with different fundamental frequencies
fa = sin(2*pi*((u0_a * x_A) + (v0_a * y_A)));
fb = sin(2*pi*(u0_b * x_A + v0_b * y_A));
fc = sin(2*pi*(u0_c * x_A + v0_c * y_A));
fd = sin(2*pi*(u0_d * x_A + v0_d * y_A));
fe = sin(2*pi*(u0_e * x_A + v0_e * y_A));
ff = sin(2*pi*((u0_f * x_A) + (v0_f * y_A)));

%in subplots on a new figure, plot each of the above sinusoids

figure (1)
colormap gray;      %plot in grayscale
subplot(2,3,1)
imagesc(fa)
title("A")
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,3,2)
imagesc(fb)
title("B")
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,3,3)
imagesc(fc)
title("C")
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,3,4)
imagesc(fd)
title("D")
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,3,5)
imagesc(fe)
title("E")
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,3,6)
imagesc(ff)
title("F")
xlabel("X (spatial units)");
ylabel("Y (spatial units)");

