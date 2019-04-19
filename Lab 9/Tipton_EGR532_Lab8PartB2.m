%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Filtering in the Frequency Domain
% Filename: Tipton_EGR532_Lab8PartB2.m
% Author: Natalie Tipton
% Date: 4/2/19
% Instructor: Dr. Rhodes
% Description: This script completes a Laplacian filter in both
%   spatial and frequency domains
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B - Section 2 %%%%%%%%%%
clear; clc

%read in moon image and find size
moon = imread('Moon.tif');
[row,col] = size(moon);
laplace = zeros(row,col);
g = zeros(row,col);
moon_doub = im2double(moon);

%create first mask
w = [0 1 0; 1 -4 1; 0 1 0];

%apply laplacian equation
for x = 1+1:row-1
    for y = 1+1:col-1
        laplace(x,y) = w(1,1)*moon_doub(x-1,y-1)+w(1,2)*moon_doub(x-1,y)+w(1,3)*moon_doub(x-1,y+1)...
                      +w(2,1)*moon_doub(x,y-1)+w(2,2)*moon_doub(x,y)+w(2,3)*moon_doub(x,y+1)...
                      +w(3,1)*moon_doub(x+1,y-1)+w(3,2)*moon_doub(x+1,y)+w(3,3)*moon_doub(x+1,y+1);     
    end
end

%find min intensity in laplacian
min_col = min(laplace);
min_laplace = min(min_col);

%scale laplacian by adding minimum intensity to image
laplace_scale = laplace + abs(min_laplace);

%find min and max of scaled image
min_scale_col = min(laplace_scale);
min_scale = min(min_scale_col);
max_scale_col = max(laplace_scale);
max_scale = max(max_scale_col);

%expand intensities to fit range of 0 to 255
laplace_scale_exp = (laplace_scale-min_scale).*(255/(max_scale-min_scale));

%find difference image of moon and laplacian
for x=1+1:row-1
    for y = 1+1:col-1
        g(x,y) = moon_doub(x,y) + (-1 * laplace(x,y));
    end
end

%convert output to uint8 to get intensities from 0-255
g_final = im2uint8(g);

%plot original, laplacian, scaled, and difference imagesin subplots
figure(1)
colormap gray;
subplot(2,2,1)
imagesc(moon_doub);
title({'Part B - Section 2','Original Image'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
imagesc(im2uint8(laplace));
title({'Laplace of Moon','Spacial Filter'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imagesc(laplace_scale_exp);
title({'Scaled and Expanded Laplace','Spatial Filter'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4)
imagesc(g_final);
title({'Original moon - Laplacian','spatial Filter'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%clear;

%read in image, convert to double, and find size
moon = imread('Moon.tif');
moon_norm = im2double(moon);
[M,N] = size(moon);

%zero pad image and find size
moon_pad = padarray(moon_norm,[M N],0,'post');
[P,Q] = size(moon_pad);

%center zero-padded image
for x = 1:P
    for y = 1:Q
        moon_pad_center(x,y) = moon_pad(x,y) * ((-1)^(x+y));
    end
end

%find 2D FT
F = fft2(moon_pad_center);

%calculate D
for u = 1:P
    for v = 1:Q
        D(u,v) = sqrt(((u - P/2)^2) + ((v - Q/2)^2));
    end
end

%determine filter by finding H for all D0s
for u = 1:P
    for v = 1:Q
        H1(u,v) = (-4) * (pi^2) * (D(u,v)^2);
    end
end

%calculate G for all D0
G1 = H1 .* F;

%Find gp
lap1 = real(ifft2(G1));
max = max(lap1(:));
lap1 = lap1 / max;

rect = [0 0 N M];
lap1 = imcrop(lap1, rect);

for x = 1:M
    for y = 1:N
        gp1(x,y) = lap1(x,y)*((-1)^(x+y));
    end
end

output = moon_norm - gp1;

%display original and padded image
figure(4)
subplot(1,2,1); imshow(moon); title({'Part B - Section 2','Original Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,2,2); imshow(moon_pad); title({'Part B - Section 2','Zero Padded Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');


%display final, cropped, output images
figure(5)
subplot(1,2,1)
imshow(lap1);
title({'Part B - Section 2','Laplacian, Frequency Filter'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,2,2)
imshow(output);
title({'Part B - Section 2','Sharpened Image, Frequency Filter'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

