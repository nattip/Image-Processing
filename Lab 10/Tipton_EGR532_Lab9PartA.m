%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Filtering in the Frequency Domain
% Filename: Tipton_EGR532_Lab9PartA.m
% Author: Natalie Tipton
% Date: 4/9/19
% Instructor: Dr. Rhodes
% Description: This script completes a radon transformation to
%   create sinogram images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A %%%%%%%%%%
clear; clc

%read in first image, convert to double, find size
rect = imread('RectanglePhantom.tif');
rect_doub = im2double(rect);
[row_rect, col_rect] = size(rect_doub);

%create incrementation for theta values
theta = 0:0.5:180;
angles = length(theta);

%preallocate space for sinogram
g = zeros([col_rect angles]);

%calculate sinogram
for i = 1:angles
    %rotate image through 0 to 180 degrees
    f = imrotate(rect_doub, theta(i), 'bicubic', 'crop');
    for x = 1:row_rect
        for y = 1:col_rect
            g(col_rect+1-y,i) = g(col_rect+1-y,i) + f(x,y);
        end
    end
end

%find sinogram with matlabs built in function
rect_rad = radon(rect);

%plot original imgae, manually created sinogram
%and matlab created sinogram
figure(1)
colormap gray;
subplot(2,2,1)
imagesc(rect)
title('Part A - Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,3)
imagesc(g')
title('Part A - Manually Created Sinogram');
xlabel('l');
ylabel('theta (0.5 degrees)');
subplot(2,2,4)
imagesc(rect_rad');
title('Part A - radon Function Created Sinogram');
xlabel('l');
ylabel('theta (degrees)');

%repeat above with a second image

shepp = imread('Shepp-LoganPhantom.tif');
shepp_doub = im2double(shepp);
[row_shepp, col_shepp] = size(shepp_doub);
theta = 0:0.5:180;
angles = length(theta);

g2 = zeros([col_shepp angles]);

for i = 1:angles
    f2 = imrotate(shepp_doub, theta(i), 'bicubic', 'crop');
    for x = 1:row_shepp
        for y = 1:col_shepp
            g2(col_shepp-y+1,i) = g2(col_shepp-y+1,i) + f2(x,y);
        end
    end
end

shepp_rad = radon(shepp);

figure(2)
colormap gray;
subplot(2,2,1)
imagesc(shepp)
title('Part A - Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,3)
imagesc(g2')
title('Part A - Manually Created Sinogram');
xlabel('l');
ylabel('theta (0.5 degrees)');
subplot(2,2,4)
imagesc(shepp_rad');
title('Part A - radon Function Created Sinogram');
xlabel('l');
ylabel('theta (degrees)');



