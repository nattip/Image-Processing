%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Intensity Transforms
% Filename: Tipton_EGR532_Lab4PartB.m
% Author: Natalie Tipton
% Date: 2/21/19
% Instructor: Dr. Rhodes
% Description: This script completes contrast stretchin, intensity
%   slicing, and bit-plane slicing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B %%%%%%%%%%

%read in pollen image and find size
pollen = imread('Pollen.tif');
[row,col]=size(pollen);

%find min, max,and avg pixel intensities
min_col = min(pollen);
min_value = min(min_col);
max_col = max(pollen);
max_value = max(max_col);
average = mean(pollen(:,:));

%find first expanded contrast image
pollen_expanded1 = (pollen-min_value).*(255/(max_value-min_value));

%find second expanded contrast image
for x=1:row
    for y=1:col
        if(pollen(x,y)>average)
            pollen_expanded2(x,y) = 255;
        else
            pollen_expanded2(x,y) = 0;
        end
    end
end

%plot original and contrast expanded images in subplots
figure(1)
colormap gray;
subplot(1,3,1)
imshow(pollen)
title('Original Pollen');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar
subplot(1,3,2)
imshow(pollen_expanded1)
title('Expanded Pollen');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,3,3)
imshow(pollen_expanded2);
title('Binary Pollen')
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%read in kidney angio img and find size
kidney_angio = imread('KidneyAngio.tif');
[row,col] = size(kidney_angio);

%intensity slice for white if intensity of orig >175 and black if <
for x = 1:row
    for y = 1:col
        if(kidney_angio(x,y)<175)
            kidney_angio_slice1(x,y) = 0;
        else
            kidney_angio_slice1(x,y) = 255;
        end
    end
end

%intesnsity slice for while if itensity > 175 or stay same if <
for x = 1:row
    for y = 1:col
        if(kidney_angio(x,y)<175)
            kidney_angio_slice2(x,y) = kidney_angio(x,y);
        else
            kidney_angio_slice2(x,y) = 255;
        end
    end
end

%plot original and both intensity sliced images
figure(2)
colormap gray;
subplot(1,3,1)
imagesc(kidney_angio)
title('Original Kidney Angio');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,3,2)
imagesc(kidney_angio_slice1)
title('First Sliced Kidney Angio');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,3,3)
imagesc(kidney_angio_slice2)
title('Second Sliced Kidney Angio');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%read in dollars, and find size
dollars = imread('Dollars.tif');
dollars = dollars(:,:,1);
[row,col] = size(dollars);
dollars_plane = zeros(row,col,8);

%slice to find each bit plane
for bit = 1:8
    for x = 1:row
        for y = 1:col
            dollars_plane(x,y,bit) = bitget(dollars(x,y),bit);    %get kth bit from each pixel 
        end
    end
end

reconstruct_1 = dollars_plane(:,:,7)*64+dollars_plane(:,:,8)*128;
reconstruct1 = im2uint8(reconstruct_1);
reconstruct_2 = dollars_plane(:,:,6)*32+dollars_plane(:,:,7)*64+dollars_plane(:,:,8)*128;
reconstruct2 = im2uint8(reconstruct_2);
reconstruct_3 = dollars_plane(:,:,5)*16+dollars_plane(:,:,6)*32+dollars_plane(:,:,7)*64+dollars_plane(:,:,8)*128;
reconstruct3 = im2uint8(reconstruct_3);

%plot original dollars image
figure(3)
colormap gray;
imagesc(dollars);
colorbar;
title('Original Dollars');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

%plot each bit plane
figure(4)
colormap gray;
subplot(4,2,1)
imshow(dollars_plane(:,:,1));
title('Dollars - Bit 1');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(4,2,2)
imshow(dollars_plane(:,:,2));
title('Dollars - Bit 2');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(4,2,3)
imshow(dollars_plane(:,:,3));
title('Dollars - Bit 3');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(4,2,4)
imshow(dollars_plane(:,:,4));
title('Dollars - Bit 4');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(4,2,5)
imshow(dollars_plane(:,:,5));
title('Dollars - Bit 5');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(4,2,6)
imshow(dollars_plane(:,:,6));
title('Dollars - Bit 6');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(4,2,7)
imshow(dollars_plane(:,:,7));
title('Dollars - Bit 7');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(4,2,8)
imshow(dollars_plane(:,:,8));
title('Dollars - Bit 8');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

%reconstruct using certain bit planes
figure(5)
colormap gray;
subplot(1,3,1)
imagesc(reconstruct_1);
title('Dollars - Bit 7 & 8');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(1,3,2)
imagesc(reconstruct_2);
title('Dollars - Bit 6, 7, & 8');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(1,3,3)
imagesc(reconstruct_3);
title('Dollars - Bit 5, 6, 7, & 8');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

figure(6)
colormap gray;
subplot(1,3,1)
imagesc(dollars-reconstruct1);
title('Difference between Dollars and Bits 7 & 8');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(1,3,2)
imagesc(dollars-reconstruct2);
title('Difference between Dollars and Bits 6, 7, & 8');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(1,3,3)
imagesc(dollars-reconstruct3);
title('Difference between Dollars and Bits 5, 6, 7, & 8');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

