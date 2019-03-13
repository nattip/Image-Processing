%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Intensity Transforms
% Filename: Tipton_EGR532_Lab4PartC.m
% Author: Natalie Tipton
% Date: 2/21/19
% Instructor: Dr. Rhodes
% Description: This script completes histogram equalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part C - Pollen Light %%%%%%%%%%

%read in pollen image and find size
pollen_light = imread('PollenLight.tif');
[row,col] = size(pollen_light);
s_light = zeros(1,255);
r = 1:255;

%map pixel intensity values from original to equalized  
for k = 1:255
    for j = 1:k
        prob_light(k) = nnz(pollen_light == k) / (row * col);
        s_light(k) = s_light(k) + prob_light(j);
    end
end

%complete transform equation
transform_light = 254 .* s_light;

%creates new, equalized image from transformed intensities
for x = 1:row
    for y = 1:col
        orig_intensity_light = round(pollen_light(x,y));
        pollen_light_eq_doub(x,y) = s_light(orig_intensity_light);
    end
end

%converts equalized image to uint8
pollen_light_eq = im2uint8(pollen_light_eq_doub);

%plot original image, original image hist, new image, new hist
figure(1)
subplot(2,2,1)
imshow(pollen_light)
title('Original Pollen Light');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,2)
imhist(pollen_light)
title('Histogram For Original Pollen Light');
ylabel('Number Of Pixels At Given Intensity');
subplot(2,2,3)
imshow(pollen_light_eq)
title('Equalized Pollen Light');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imhist(pollen_light_eq);
title('Histogram For Equalized Pollen Light');
ylabel('Number Of Pixels At Given Intensity');

%plot transformation
figure(2)
plot(s_light,r)
title('Transform for Pollen Light');
xlabel('sk');
ylabel('rk');

%repeat all steps from above for 3 different images
%%%%%%%% Part C - Pollen Dark %%%%%%%%%%

pollen_dark = imread('PollenDark.tif');
[row,col] = size(pollen_dark);
s_dark = zeros(1,255);

for k = 1:255
    for j = 1:k
        prob_dark(k) = nnz(pollen_dark == k) / (row * col);
        s_dark(k) = s_dark(k) + prob_dark(j);
    end
end

transform_dark = 254 .* s_dark;

for x = 1:row
    for y = 1:col
        orig_intensity_dark = round(pollen_dark(x,y));
        pollen_dark_eq_doub(x,y) = s_dark(orig_intensity_dark);
    end
end

pollen_dark_eq = im2uint8(pollen_dark_eq_doub);


figure(3)
subplot(2,2,1)
imshow(pollen_dark)
title('Original Pollen Dark');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,2)
imhist(pollen_dark)
title('Histogram For Original Pollen Dark');
ylabel('Number Of Pixels At Given Intensity');
subplot(2,2,3)
imshow(pollen_dark_eq)
title('Equalized Pollen Dark');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imhist(pollen_dark_eq);
title('Histogram For Equalized Pollen Dark');
ylabel('Number Of Pixels At Given Intensity');

figure(4)
plot(s_dark,r)
title('Transform for Pollen Dark');
xlabel('sk');
ylabel('rk');

%%%%%%%% Part C - Pollen Low Contrast %%%%%%%%%%

pollen_low_con = imread('PollenLowContrast.tif');
[row,col] = size(pollen_low_con);
s_low_con = zeros(1,255);

for k = 1:255
    for j = 1:k
        prob_low_con(k) = nnz(pollen_low_con == k) / (row * col);
        s_low_con(k) = s_low_con(k) + prob_low_con(j);
    end
end

transform_low_con = 254 .* s_low_con;

for x = 1:row
    for y = 1:col
        orig_intensity_low_con = round(pollen_low_con(x,y));
        pollen_low_con_eq_doub(x,y) = s_low_con(orig_intensity_low_con);
    end
end

pollen_low_con_eq = im2uint8(pollen_low_con_eq_doub);


figure(5)
subplot(2,2,1)
imshow(pollen_low_con)
title('Original Pollen Low Contrast');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,2)
imhist(pollen_low_con)
title('Histogram For Original Pollen Low Contrast');
ylabel('Number Of Pixels At Given Intensity');
subplot(2,2,3)
imshow(pollen_low_con_eq)
title('Equalized Pollen Low Contrast');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imhist(pollen_low_con_eq);
title('Histogram For Equalized Pollen Low Contrast');
ylabel('Number Of Pixels At Given Intensity');

figure(6)
plot(s_low_con,r)
title('Transform for Pollen Low Contrast');
xlabel('sk');
ylabel('rk');

%%%%%%%% Part C - Pollen High Contrast %%%%%%%%%%

pollen_high_con = imread('PollenHighContrast.tif');
[row,col] = size(pollen_high_con);
s_high_con = zeros(1,255);

for k = 1:255
    for j = 1:k
        prob_high_con(k) = nnz(pollen_high_con == k) / (row * col);
        s_high_con(k) = s_high_con(k) + prob_high_con(j);
    end
end

transform_high_con = 254 .* s_high_con;

for x = 1:row
    for y = 1:col
        orig_intensity_high_con = round(pollen_high_con(x,y));
        pollen_high_con_eq_doub(x,y) = s_high_con(orig_intensity_high_con+1);
    end
end

pollen_high_con_eq = im2uint8(pollen_high_con_eq_doub);


figure(7)
subplot(2,2,1)
imshow(pollen_high_con)
title('Original Pollen High Contrast');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,2)
imhist(pollen_high_con)
title('Histogram For Original Pollen High Contrast');
ylabel('Number Of Pixels At Given Intensity');
subplot(2,2,3)
imshow(pollen_high_con_eq)
title('Equalized Pollen High Contrast');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imhist(pollen_high_con_eq);
title('Histogram For Equalized Pollen High Contrast');
ylabel('Number Of Pixels At Given Intensity');

figure(8)
plot(s_high_con,r)
title('Transform for Pollen High Contrast');
xlabel('sk');
ylabel('rk');