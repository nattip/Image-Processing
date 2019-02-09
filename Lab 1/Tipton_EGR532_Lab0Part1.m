%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Introduction to Image Processing Exercise 1
% Filename: Tipton_EGR532_Lab0Part1.m
% Author: Natalie Tipton
% Date: 1/15/18
% Instructor: Dr. Rhodes
% Description: This script file includes the basics of image processing in
%              MATLAB. It includes reading an image in from a file
%              location, plotting with subplots, converting a color image
%              to grayscale, inverting that grayscale image, mirroring 
%              about the x and y axes, rotating an image, blurring an 
%              image, and tiling an image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Exercise 1 %%%%%%%%%%

% cell1.jpg

cell1 = imread('cell1.jpg');    %read in image

figure(1)   %creates first figure
subplot(1,3,1)  %first subplot in 1 row of 3 images
imshow(cell1);  %plot original image
title('Cell1.jpg Original');    %label image
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

cell1Neg = 255 - cell1; %inverts image colors
    
subplot(1,3,2)  %second subplot in 1 row of 3 images
imshow(cell1Neg);   %plot negative image
title('Cell1.jpg Negative');    %label image
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

cell1rot = cell1(end:-1:1,end:-1:1,:);  %reverses the order of the rows and
                                        %colums to rotate image 180 degrees
subplot(1,3,3)  %third subplot in 1 row of 3 images
imshow(cell1rot);   %plot rotated image
title('Cell1.jpg Rotate 180 deg');  %label plot
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

% Heart.tif

heart = imread('Heart.tif');    %read in heart image

figure(2)   %create new figure

subplot(2,2,1)  %first subplot in 2 rows of 2 images
imshow(heart);  %plot original heart image
title('Heart.tif Original');    %label plot
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

heartDouble = im2double(heart); %converts image from uint8 to double size
                                %allowing manipulation of numbers >255
heartGrayDouble = (heartDouble(:,:,1) + heartDouble(:,:,2) + heartDouble(:,:,3))/3;
                                %takes avg of RGB values in all rows & cols
heartGray = im2uint8(heartGrayDouble);  %converts grayscale image back to 
                                        %uint8 from double

subplot(2,2,2)  %second subplot in 2 rows of 2 images
imshow(heartGray);  %plots grayscale image
title('Heart.tif Grayscale');   %label plot
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

heartGrayNeg = 255 - heartGray; %invert values of all rows and columns

subplot(2,2,3)  %third subplot in 2 rows of 2 images
imshow(heartGrayNeg);   %plot negative grayscale image
title('Heart.tif Grayscale Negative');  %label plot
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

heartMirror = heart(:,end:-1:1,:);  %reverses order of all columns 
                                    %to mirror about y axis

subplot(2,2,4)  %fourth subplot in 2 rows of 2 images
imshow(heartMirror);    %plot mirrored image
title('Heart.tif Mirrored About Y Axis');   %label image
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

        

