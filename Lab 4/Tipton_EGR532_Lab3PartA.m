%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Image Transformations - Image Manipulation
% Filename: Tipton_EGR532_Lab3PartA.m
% Author: Natalie Tipton
% Date: 2/14/19
% Instructor: Dr. Rhodes
% Description: This script completes image subtraction and image
%       multiplication as described in Part A of Learning Exercise 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A - Image Subtraction %%%%%%%%%%

%read in angio images
angio_live = imread('Angio_Live.tif');
angio_mask = imread ('Angio_Mask.tif');

%complete image subtraction
angio_dif = angio_mask - angio_live;

%plot in subplots the original images and subtracted image
figure(1)
colormap gray;
subplot(1,3,1);
imagesc(angio_live);
colorbar;
title("Angio Live");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(1,3,2);
imagesc(angio_mask);
colorbar;
title("Angio Mask");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(1,3,3);
imagesc(angio_dif);
colorbar;
title("Angio Mask - Angio Live");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");

%%%%%%%% Part A - Image Multiplication %%%%%%%%%%

%read in dental images and convert to double
dental_image = imread('Dental_Image.tif');
dental_image_doub = im2double(dental_image);
dental_mask = imread ('Dental_Mask.tif');
dental_mask_doub = im2double(dental_mask);

%calculate product of image and mask
dental_prod_doub = dental_image_doub .* dental_mask_doub;
dental_prod = im2uint8(dental_prod_doub);

%in new figure plot in subplots the original images and product img
figure(2)
colormap gray;
subplot(2,2,1)
imagesc(dental_image);
colorbar;
title("Dental Image");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,2,2)
imagesc(dental_mask);
colorbar;
title("Dental Mask");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
subplot(2,2,3)
imagesc(dental_prod);
colorbar;
title("Dental Image * Dental Mask");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");

%create mask with white rectangle big enough to fit bottom 3 teeth
bottom_mask = zeros(674,882);
for i=300:650
    for j=20:800
        bottom_mask(i,j) = 255;
    end
end

%image multiplication to show only bottom 3 teeth
bottom_image_doub = dental_image_doub .* bottom_mask;

%in same image, new subplot, plot product image to show bottom 3
subplot(2,2,4)
imagesc(bottom_image_doub);
colorbar;
title("Masked Image Showing Bottom Teeth");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");