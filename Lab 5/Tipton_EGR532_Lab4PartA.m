%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Intensity Transforms
% Filename: Tipton_EGR532_Lab4PartA.m
% Author: Natalie Tipton
% Date: 2/21/19
% Instructor: Dr. Rhodes
% Description: This script completes negative, log, and power-law
%   transformations to enhance contrast
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A %%%%%%%%%%

%load in mammogram image
dig_mammogram = imread('DigitalMammogram.tif');

%convert image to negative
dig_mammogram_neg = 255 - dig_mammogram;

%plot original and negative image in subplots
figure(1)
subplot(1,2,1)
colormap gray;
imagesc(dig_mammogram)
title('Original Digital Mammogram');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,2,2)
imagesc(dig_mammogram_neg)
title('Negative Digital Mammogram');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%read in fourier transformation, turn to double, and find size
fourier_tran = imread('FourierTransform.tif');
fourier_tran_doub = im2double(fourier_tran);
[row,col] = size(fourier_tran);
fourier_tran_log_doub = zeros(row,col);

%take log transform of each pixel in fourier tran image
for x = 1:row
    for y = 1:col
        fourier_tran_log_doub(x,y) = log10(1 + fourier_tran_doub(x,y));
    end
end

%convert back to uint8
fourier_tran_log = im2uint8(fourier_tran_log_doub);

%plot original and log transformed images on subplots
figure(2)
subplot(1,2,1)
colormap gray;
imagesc(fourier_tran)
title('Original Fourier Transformation');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,2,2)
imagesc(fourier_tran_log);
title('Logarithmic Fourier Transform');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%read in spine mri image and convert to double
spine_mri = imread('SpineMRI.tif');
spine_mri_doub = im2double(spine_mri);

%initialize gamma values
gamma6 = 0.6;
gamma4 = 0.4;
gamma3 = 0.3;

%complete gamma transformations for three dif gamma values
spine_mri_gamma6_doub = spine_mri_doub.^gamma6;
spine_mri_gamma4_doub = spine_mri_doub.^gamma4;
spine_mri_gamma3_doub = spine_mri_doub.^gamma3;

%convert back to uint8
spine_mri_gamma6 = im2uint8(spine_mri_gamma6_doub);
spine_mri_gamma4 = im2uint8(spine_mri_gamma4_doub);
spine_mri_gamma3 = im2uint8(spine_mri_gamma3_doub);
   
%plot original and three gamma transformed images on subplot
figure(3)
subplot(2,2,1)
colormap gray;
imagesc(spine_mri)
title('Original Spine MRI');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
colormap gray;
imagesc(spine_mri_gamma6)
title({'Power Law Spine MRI', 'Gamma = 0.6'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
colormap gray;
imagesc(spine_mri_gamma4)
title({'Power Law Spine MRI','Gamma = 0.4'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4)
colormap gray;
imagesc(spine_mri_gamma3)
title({'Power Law Spine MRI','Gamma = 0.3'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
