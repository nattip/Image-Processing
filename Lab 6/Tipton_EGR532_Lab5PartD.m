%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Spatial Filtering & Image Enhancement
% Filename: Tipton_EGR532_Lab5PartD.m
% Author: Natalie Tipton
% Date: 2/28/19
% Instructor: Dr. Rhodes
% Description: This script completes global and local equalization
%   of an image to see how they differently affect the outcome
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part D %%%%%%%%%%

checker = imread('CheckerBoard.tif');
%read in pollen image and find size
[row,col] = size(checker);
s = zeros(1,255);
r = 1:255;

%map pixel intensity values from original to equalized  
for k = 1:255
    for j = 1:k
        prob(k) = nnz(checker == k) / (row * col);
        s(k) = s(k) + prob(j);
    end
end

%complete transform equation
transform = 254 .* s;
checker_eq_doub = zeros(row,col);

%creates new, equalized image from transformed intensities
for x = 1:row
    for y = 1:col
        orig_intensity = round(checker(x,y));
        checker_eq_doub(x,y) = s(orig_intensity+1);
    end
end

%converts equalized image to uint8
checker_eq = im2uint8(checker_eq_doub);

%plot original image, original image hist, new image, new hist
figure(1)
subplot(2,2,1)
imshow(checker)
title('Original Checker Board');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,2)
imhist(checker)
title('Histogram For Original Checker Board');
ylabel('Number Of Pixels At Given Intensity');
subplot(2,2,3)
imshow(checker_eq)
title('Globally Equalized Checker Board');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imhist(checker_eq);
title('Histogram For Globally Equalized Checker Board');
ylabel('Number Of Pixels At Given Intensity');

%plot transformation
figure(2)
plot(s,r)
title({'Transform for Checker Board','Global Equalization'});
xlabel('sk');
ylabel('rk');

%create local equalized image for given neighborhood size
local_checker = checker;
M = 3;
N = 3;

%find middle pixel in neighborhood
mid_pixel = round((M*N)/2);

%pad image based on neighborhood size
pad_x = 1;
pad_y = 1;
checker_pad = padarray(checker,[pad_x pad_y], 0, 'both');
[row_pad,col_pad] = size(checker_pad);

%comlete local equalization
for i= 1:row_pad - 3
    for j = 1:col_pad - 3
        prob = zeros(256,1);
        pixel_num = 1;
        for x = 1:M
            for y = 1:N
                %find value of middle pixel     
                if(pixel_num == mid_pixel)
                    equ_element = checker_pad(i+x-1,j+y-1) + 1;
                end
                    %find probability of current pixel in neighborhood
                    position = checker_pad(i+x-1,j+y-1) + 1;
                    prob(position) = prob(position) + 1;
                    pixel_num = pixel_num + 1;
            end
        end
                      
        %find probability for neighborhood values
        for l = 2:256
            prob(l) = prob(l) + prob(l-1);
        end
            local_checker(i,j) = round(prob(equ_element) / (M*N)*255);
     end
end

figure(3)
colormap gray;
subplot(1,2,1)
imagesc(local_checker)
title('Locally Equalized Checker Board');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colormap;
subplot(1,2,2)
imhist(local_checker);
title('Histogram of Locally Equalized Checker Board');
ylabel('Number of Pixels at Given Intensity');
colormap;
