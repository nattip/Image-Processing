%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Edge Detection
% Filename: Tipton_EGR532_Lab7PartA.m
% Author: Natalie Tipton
% Date: 3/21/19
% Instructor: Dr. Rhodes
% Description: This script applies sobel masks to an image in order to
%   find the magnitude and angle images. The horizontal and vertical
%   lines are emphasized.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A %%%%%%%%%%

%read in building image and find size
building = imread('Building.tif');
[row, col] = size(building);

%convert building to type double
b = im2double(building);

%create both masks
w1 = [-1 -2 -1; 0 0 0; 1 2 1];
w2 = [-1 0 1; -2 0 2; -1 0 1];

%find derivative of image with first mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gx(x,y) = w1(1,1)*b(x-1,y-1)+w1(1,2)*b(x-1,y)+w1(1,3)*b(x-1,y+1)...
                      +w1(2,1)*b(x,y-1)+w1(2,2)*b(x,y)+w1(2,3)*b(x,y+1)...
                      +w1(3,1)*b(x+1,y-1)+w1(3,2)*b(x+1,y)+w1(3,3)*b(x+1,y+1);     
    end
end

%find derivative of image with second mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gy(x,y) = w2(1,1)*b(x-1,y-1)+w2(1,2)*b(x-1,y)+w2(1,3)*b(x-1,y+1)...
                      +w2(2,1)*b(x,y-1)+w2(2,2)*b(x,y)+w2(2,3)*b(x,y+1)...
                      +w2(3,1)*b(x+1,y-1)+w2(3,2)*b(x+1,y)+w2(3,3)*b(x+1,y+1);     
    end
end

%find gradient magnitude of image
M = abs(gx) + abs(gy);
%find gradient angle of image
alpha = atan(gy ./ gx);

%plot original image and gx and gy in subplots
figure(1)
colormap gray;
subplot(2,2,1)
imagesc(building);
title('Original Building');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
imagesc(gx);
title({'Partial Derivative of Original','In Terms of X (gx)'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imagesc(gy);
title({'Partial Derivative of Original','In Terms of Y (gy)'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

figure(2)
colormap gray;
subplot(1,2,1)
imagesc(M);
title('Gradient Magnitude of Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,2,2)
imagesc(alpha);
title('Gradient Angle of Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;