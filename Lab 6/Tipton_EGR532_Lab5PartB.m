%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Spatial Filtering & Image Enhancement
% Filename: Tipton_EGR532_Lab5PartB.m
% Author: Natalie Tipton
% Date: 2/28/19
% Instructor: Dr. Rhodes
% Description: This script completes the Laplaceian and Gradient 
%   sharpening filters as described in part B of LE 5.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B - Section 1 %%%%%%%%%%

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
title('Original Moon');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
imagesc(im2uint8(laplace));
title({'Laplace of Moon','Mask 1'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imagesc(laplace_scale_exp);
title({'Scaled and Expanded Laplace','Mask 1'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4)
imagesc(g_final);
title({'Original moon - Laplacian','Mask 1'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%create second mask
w2 = [1 1 1; 1 -8 1; 1 1 1];

%repeat above steps using second mask in place of first
for x = 1+1:row-1
    for y = 1+1:col-1
        laplace2(x,y) = w2(1,1)*moon_doub(x-1,y-1)+w2(1,2)*moon_doub(x-1,y)+w2(1,3)*moon_doub(x-1,y+1)...
                      +w2(2,1)*moon_doub(x,y-1)+w2(2,2)*moon_doub(x,y)+w2(2,3)*moon_doub(x,y+1)...
                      +w2(3,1)*moon_doub(x+1,y-1)+w2(3,2)*moon_doub(x+1,y)+w2(3,3)*moon_doub(x+1,y+1);     
    end
end

min_col2 = min(laplace2);
min_laplace2 = min(min_col);

laplace_scale2 = laplace2 + abs(min_laplace2);

min_scale_col2 = min(laplace_scale2);
min_scale2 = min(min_scale_col2);
max_scale_col2 = max(laplace_scale2);
max_scale2 = max(max_scale_col2);

laplace_scale_exp2 = (laplace_scale2-min_scale2).*(255/(max_scale2-min_scale2));

for x=1+1:row-1
    for y = 1+1:col-1
        g2(x,y) = moon_doub(x,y) + (-1 * laplace2(x,y));
    end
end
g2_final = im2uint8(g2);

figure(2)
colormap gray;
subplot(2,2,1)
imagesc(moon_doub);
title('Original Moon');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
imagesc(im2uint8(laplace2));
title({'Laplace of Moon','Mask 2'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imagesc(laplace_scale_exp2);
title({'Scaled and Expanded Laplace','Mask 2'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4)
imagesc(g2_final);
title({'Original moon - Laplacian','Mask 2'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%%%%%%%% Part B - Section 2 %%%%%%%%%%

%read in contact lens image and find size
contact_lens = imread('ContactLens.tif');
[row, col] = size(contact_lens);

%convert contact lens to type double
contact_lens_doub = im2double(contact_lens);

%create both masks
w3 = [-1 -2 -1; 0 0 0; 1 2 1];
w4 = [-1 0 1; -2 0 2; -1 0 1];

%find derivative of image with firt mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gx(x,y) = w3(1,1)*contact_lens_doub(x-1,y-1)+w3(1,2)*contact_lens_doub(x-1,y)+w3(1,3)*contact_lens_doub(x-1,y+1)...
                      +w3(2,1)*contact_lens_doub(x,y-1)+w3(2,2)*contact_lens_doub(x,y)+w3(2,3)*contact_lens_doub(x,y+1)...
                      +w3(3,1)*contact_lens_doub(x+1,y-1)+w3(3,2)*contact_lens_doub(x+1,y)+w3(3,3)*contact_lens_doub(x+1,y+1);     
    end
end

%find dirivative of image with second mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gy(x,y) = w4(1,1)*contact_lens_doub(x-1,y-1)+w4(1,2)*contact_lens_doub(x-1,y)+w4(1,3)*contact_lens_doub(x-1,y+1)...
                      +w4(2,1)*contact_lens_doub(x,y-1)+w4(2,2)*contact_lens_doub(x,y)+w4(2,3)*contact_lens_doub(x,y+1)...
                      +w4(3,1)*contact_lens_doub(x+1,y-1)+w4(3,2)*contact_lens_doub(x+1,y)+w4(3,3)*contact_lens_doub(x+1,y+1);     
    end
end

%find gradient of image
M = abs(gx) + abs(gy);

%plot original image and gradient image in subplots
figure(3)
colormap gray;
subplot(1,2,1)
imagesc(contact_lens);
title('Original Contact Lens');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,2,2)
imagesc(M);
title('Gradient of Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
