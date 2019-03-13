%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Image Transformations - Image Manipulation
% Filename: Tipton_EGR532_Lab3PartB.m
% Author: Natalie Tipton
% Date: 2/14/19
% Instructor: Dr. Rhodes
% Description: This script blurs an image using neighborhood operations
%   of size 41x41 and 20x20. This follows instructions as stated in Part B
%   of LE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B %%%%%%%%%%

%read in image and take size
kidney =(imread('Kidney.tif'));
[rows, cols] = size(kidney);

%create an anonymous function to get the average of the neighborhood
fun = @(block_struct) mean(block_struct.data);

%apply averaging function to neighborhoods across entire image
kidney_blur41 = blockproc(kidney,[41,41],fun);
kidney_blur20 = blockproc(kidney,[20,20], fun);

%plot original image
figure(1)
colormap gray;
imagesc(kidney);
colorbar;
title("Kidney");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");

%plot two blurred images
figure(2)
subplot(1,2,1)
colormap gray;
imagesc(kidney_blur41)
colorbar;
title("Kidney blurred with 41x41 neighborhood");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(1,2,2)
imagesc(kidney_blur20);
colorbar;
title("Kidney blurred with 20x20 neighborhood");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
