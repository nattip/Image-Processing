%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Multidimensional Signal Processing
% Filename: Tipton_EGR532_Lab2PartE.m
% Author: Natalie Tipton
% Date: 1/29/18
% Instructor: Dr. Rhodes
% Description: This script completes steps outlines in LE #2 Part E 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part E %%%%%%%%%%

%read in image
rectangle = imread('Rectangle.tif');

%use MATLAB functions for find FT of image and shift component to center
F_rect = fft2(rectangle);
F_rect_shift = fftshift(F_rect);

%take log10 of shifted FT to see clearer results
log_F_rect_shift = log10(F_rect_shift);

%in subplots, plot image, shifted FT, and log10 shifted FT in grayscale
colormap gray;
subplot(2,3,1)
imshow(rectangle);
title("Rectangle.tif");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,3,2)
imagesc(abs(F_rect_shift));
title("F(u,v) Rectangle.tif");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");
subplot(2,3,3)
imagesc(abs(log_F_rect_shift));
title("log10 F(u,v) Rectangle.tif");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");

%rotate image by 45 degrees and repeat above steps
rectangle_rot = imrotate(rectangle, 45);
F_rect_rot = fft2(rectangle_rot);
F_rect_shift_rot = fftshift(F_rect_rot);

log_F_rect_shift_rot = log10(F_rect_shift_rot);

subplot(2,3,4)
imshow(rectangle_rot);
title("45 Deg Rotated Rectangle.tif");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,3,5)
imagesc(abs(F_rect_shift_rot));
title("45 Deg Rotated F(u,v)");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");
subplot(2,3,6)
imagesc(abs(log_F_rect_shift_rot));
title("45 Deg Rotated log10 F(u,v)");
xlabel("X (spatial frequency)");
ylabel("Y (spatial frequency)");



