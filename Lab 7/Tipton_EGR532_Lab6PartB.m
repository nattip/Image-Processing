%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Pseudocolor Image Processing
% Filename: Tipton_EGR532_Lab6PartB.m
% Author: Natalie Tipton
% Date: 3/14/19
% Instructor: Dr. Rhodes
% Description: This script assigns pseudocolor to 5 equal ranges of 
%   pixel values, changing gray levels to certain colors.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B %%%%%%%%%%

%read in B&W thyroid image
t_orig = imread('Thyroid.tif');
t = mat2gray(t(:,:));
t = im2uint8(t);
%find size of original image and create new image of same size
[row,col] = size(t);
new_t = zeros(row,col,3);

%cycle through all pixels of original image
for i = 1:row
    for j = 1:col
        %give pseudocolor based on ranges of pixel values
        if t(i,j)>=0 && t(i,j)<32
            %make black
            new_t(i,j,1) = 0;
            new_t(i,j,2) = 0;
            new_t(i,j,3) = 0;
        end
        if t(i,j)>=32 && t(i,j)<64
            %make blue
            new_t(i,j,1) = 0;
            new_t(i,j,2) = 0;
            new_t(i,j,3) = 1;
        end
        if t(i,j)>=64 && t(i,j)<96
            %make light blue
            new_t(i,j,1) = 0;
            new_t(i,j,2) = 1;
            new_t(i,j,3) = 1;
        end
        if t(i,j)>=96 && t(i,j)<128
            %make green
            new_t(i,j,1) = 0;
            new_t(i,j,2) = 1;
            new_t(i,j,3) = 0;
        end
        if t(i,j)>=128 && t(i,j)<160
            %make orange
            new_t(i,j,1) = 1;
            new_t(i,j,2) = 0.5;
            new_t(i,j,3) = 0;
        end
        if t(i,j)>=160 && t(i,j)<192
            %make yellow
            new_t(i,j,1) = 1;
            new_t(i,j,2) = 1;
            new_t(i,j,3) = 0;
        end
        if t(i,j)>=192 && t(i,j)<224
            %make red
            new_t(i,j,1) = 1;
            new_t(i,j,2) = 0;
            new_t(i,j,3) = 0;
        end
        if t(i,j)>=224 && t(i,j)<256
            %make white
            new_t(i,j,1) = 1;
            new_t(i,j,2) = 1;
            new_t(i,j,3) = 1;
        end
    end
end

%plot original and intensity sliced images in subplots of figure 1
figure(1)
subplot(1,2,1)
imshow(t_orig);
title('Original Thyroid');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,2,2)
imshow(new_t);
title('Intensity Sliced Thyroid');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;