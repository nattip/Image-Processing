%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Edge Detection
% Filename: Tipton_EGR532_Lab7PartE.m
% Author: Natalie Tipton
% Date: 3/21/19
% Instructor: Dr. Rhodes
% Description: This script performs edge detection on an image using
%   MATLAB's built in edge function. Results are plotted side by side.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part E %%%%%%%%%%

%read in blood image
blood = imread('blood1.tif');

%perform edge detection using 5 different methods
sobel = edge(blood, 'sobel',0.13);
prewitt = edge(blood, 'prewitt',0.13);
roberts = edge(blood, 'roberts',0.13);
log = edge(blood, 'log',0.0065);
canny = edge(blood, 'canny',[0.1 .11]);

%plot original image and results from 5 edge detect methods in subplots
figure(1)
colormap gray;
subplot(2,3,1);
imagesc(blood);
title('Original Blood Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,2)
imagesc(sobel)
title({'Edge Detect - Sobel','Threshold = 0.13'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,3)
imagesc(prewitt)
title({'Edge Detect - Prewitt','Threshold = 0.13'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,4)
imagesc(roberts)
title({'Edge Detect - Roberts','Threshold = 0.13'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,5)
imagesc(log)
title({'Edge Detect - Log','Threshold = 0.0065'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,6)
imagesc(canny)
title({'Edge Detect - Canny','Threshold = [0.1 0.11]'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');