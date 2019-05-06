%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Title: Project 1: Infarct Szie
%Filename: Tipton_EGR532_Project1.m
%Author: Natalie Tipton
%Date: 3/28/19
%Instructor: Dr. Rhodes
%Description: This program automatically detects the percentage of
%   infarcted tissue in slices of and cumulatively in an entire
%   guinea pig heart with no input from the user beyond a directory
%   that includes all of the necessary tif or tiff images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%clear all variables and command window
clear; clc;

%obtain directory path from user
path = uigetdir('*.tif*'); 
cd(path)    %change directory so MATLAB can find files
files = dir('*IS*.tif*');   %open all .tif or .tiff files in directory with IS in name
mask = ismember({files.name}, {'.', '..'});
files(mask) = [];   %get rid of . and .. directories
[num_files,z] = size(files);    %determine number of files read

%complete loop for each image read from directory
for n = 1:num_files
    %after each image, clear all variables except cumulative data variables
    if n > 1
        clearvars -except percent im weight_final n num_files files
    end
  %read in all images in directory
  im{n} = imread(files(n).name); 

  %determine weight of heart slice based on image name
  start_w = strfind(files(n).name,'S');
  end_w = strfind(files(n).name,'mg');
  weight = files(n).name(start_w+1:end_w-1);
  weight_final(n) = str2num(weight);
  
  %use nth image in directory for current analysis
  image = im{1,n};

[row,col] = size(image(:,:,1)); %find size of image
im_doub = im2double(image); %convert image to double

gray = rgb2gray(image); %create grayscale image
hsv = rgb2hsv(im_doub); %create hsv image

sat = hsv(:,:,2);   %find saturation plane of hsv image
sat_uint = im2uint8(sat);   %convert saturation image to uint8

%cycle through all pixels and create background mask
%by masking nearly black pixels in saturation image
for x = 1:row
    for y = 1:col
        if sat_uint(x,y) < 50
            mask(x,y) = 0;    
        else
            mask(x,y) = 1; 
        end
    end
end

%smooth mask to get rid of erroneous pixels
 mask_new(:,:) = conv2(mask(:,:), ones(8,8)/64, 'same');
 
 %get rid of gray pixels in smoothed mask image
 for x = 1:row
     for y = 1:col
         if mask_new(x,y) < 0.9
             mask_new(x,y) = 0;
         else
             mask_new(x,y) = 1;
         end
     end
 end
 
%apply mask to original imgae
masked = mask_new .* im_doub;

%convert masked image to uint8 grayscale
gray_mask_doub = rgb2gray(masked);
gray_mask = im2uint8(gray_mask_doub);

%preallocate space for arrays
gray_mask_eq = zeros(1,255);
prob_gray = zeros(1,255);

%map pixel intensity values from original to equalized  
for k = 1:255
    for j = 1:k
         prob_gray(k) = nnz(gray_mask == k) / (row * col);
         gray_mask_eq(k) = gray_mask_eq(k) + prob_gray(j);
    end
end

gray_eq_doub = zeros(row,col);

%creates new, equalized image from transformed intensities
for x = 1:row
    for y = 1:col
         orig_intensity_gray = round(gray_mask(x,y));
         if orig_intensity_gray == 0
             orig_intensity_gray = 1;
         end
         gray_eq_doub(x,y) = gray_mask_eq(orig_intensity_gray);
    end
end

%converts equalized image to uint8
gray_eq = im2uint8(gray_eq_doub);

%create threshold for segmenting infarcted tissue on masked, equalized,
%grayscale image
for x = 1:row
    for y = 1:col
        thresh = 0.77 * max(gray_eq(:));
        if gray_eq(x,y) > thresh
            blobs(x,y) = 255;
        else
            blobs(x,y) = gray_mask(x,y);
        end
    end
end

%initialize pixel categorization
infarcted = 0;
healthy = 0; 

%determine infarcted versus healthy tissue based on masking
for x = 1:row
    for y = 1:col
        if blobs(x,y) == 255
            infarcted = infarcted + 1;
        elseif blobs(x,y) ~= 0 && blobs(x,y) ~= 255
            healthy = healthy + 1;
        end
    end
end

%calculate percent of infarcted tissue in current slice
percent(n) = (infarcted / (infarcted + healthy)) * 100;

%plot the original and grayscale images
figure
subplot(1,2,1)
imshow(image)
cap = sprintf('Original %d mg Image',weight_final(1,n));
title(cap);
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(1,2,2)
imshow(gray)
cap = sprintf('Grayscale %d mg Image',weight_final(1,n));
title(cap);
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

%in new figure plot saturation image with first mask, final mask, and
%masked original image
figure
subplot(2,2,1)
imshow(sat)
cap = sprintf('Saturation of Original %d mg Image',weight_final(1,n));
title(cap);
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,2)
imshow(mask)
title({'First Background Mask','Created By Thresholding Saturation'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,3)
imshow(mask_new)
title({'Final Background Mask','Created By Smoothing First Mask'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imshow(masked);
cap = sprintf('Background Masked %d mg Image',weight_final(1,n));
title(cap);
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

%plot original image, original image hist, equalized image, equalized hist
figure
subplot(2,2,1)
imshow(gray)
cap = sprintf('Grayscale Image %d mg',weight_final(1,n));
title(cap);
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,2)
imhist(gray)
cap = sprintf('Histogram For Grayscale %d mg Image',weight_final(1,n));
title(cap);
ylabel('Number Of Pixels At Given Intensity');
subplot(2,2,3)
imshow(gray_eq)
cap = sprintf('Equalized Gray %d Image',weight_final(1,n));
title(cap);
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imhist(gray_eq);
cap = sprintf('Histogram For Equalized Gray %d Image',weight_final(1,n));
title(cap);
ylabel('Number Of Pixels At Given Intensity');

%plot the original image and the segmented image side by side
figure
subplot(1,2,1)
imshow(image)
cap = sprintf('Original %d mg Image',weight_final(1,n));
title(cap);
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(1,2,2)
imshow(blobs)
cap = sprintf('Infarcted Tissue in %d mg Slice',weight_final(1,n));
title(cap);
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

end

 %calculate the total weight
weight_tot = sum(weight_final);
percentage_tot = 0;

%calculate the total percentage and print the percentage infarcted of each
%slide
for n = 1:num_files
    percentage_tot = percentage_tot + (weight_final(n)/weight_tot)*percent(n);
    fprintf('Percentage Infarcted for %d mg slice: %f \n',weight_final(1,n),percent(1,n));
end

%print total percentage of infarction for entire heart
fprintf('Percentage of infarcted tissue in entire heart: %f\n',percentage_tot);