%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Spatial Filtering & Image Enhancement
% Filename: Tipton_EGR532_Lab5PartC.m
% Author: Natalie Tipton
% Date: 2/28/19
% Instructor: Dr. Rhodes
% Description: This script completes a series of manipulations
%   to an image to display how they can compound to obtain an
%   end result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part C %%%%%%%%%%

skeleton = imread('Skeleton.tif');
[row,col] = size(skeleton);
skeleton_doub = im2double(skeleton);

w2 = [1 1 1; 1 -8 1; 1 1 1];

%repeat above steps using second mask in place of first
for x = 1+1:row-1
    for y = 1+1:col-1
        laplace(x,y) = w2(1,1)*skeleton_doub(x-1,y-1)+w2(1,2)*skeleton_doub(x-1,y)+w2(1,3)*skeleton_doub(x-1,y+1)...
                      +w2(2,1)*skeleton_doub(x,y-1)+w2(2,2)*skeleton_doub(x,y)+w2(2,3)*skeleton_doub(x,y+1)...
                      +w2(3,1)*skeleton_doub(x+1,y-1)+w2(3,2)*skeleton_doub(x+1,y)+w2(3,3)*skeleton_doub(x+1,y+1);     
    end
end

min_col = min(laplace);
min_laplace = min(min_col);

laplace_scale = laplace + abs(min_laplace);

min_scale_col = min(laplace_scale);
min_scale = min(min_scale_col);
max_scale_col = max(laplace_scale);
max_scale = max(max_scale_col);

laplace_exp = (laplace_scale-min_scale).*(255/(max_scale-min_scale));

for x=1+1:row-1
    for y = 1+1:col-1
        g(x,y) = skeleton_doub(x,y) + (-1 * laplace(x,y));
    end
end
g_final = im2uint8(g);

figure(1)
colormap gray;
subplot(2,2,1)
imshow(skeleton);
title('Original Skeleton');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
imagesc(im2uint8(laplace));
title({'Laplace of Skeleton','Mask 2'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imagesc(laplace_exp);
title({'Scaled and Expanded Laplace','Mask 2'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4)
imagesc(g_final);
title({'Original Skeleton - Laplacian','Mask 2'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

for x=1+1:row-1
    for y = 1+1:col-1
        add_laplace(x,y) = skeleton_doub(x,y) + g(x,y);
    end
end
add_laplace_final = im2uint8(add_laplace);

figure(2)
colormap gray;
subplot(1,2,1)
imagesc(g_final);
title('Scaled Laplacian Output');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(1,2,2)
imagesc(add_laplace_final);
title('Original Skeleton + Scaled Laplacian Output');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

w3 = [-1 -2 -1; 0 0 0; 1 2 1];
w4 = [-1 0 1; -2 0 2; -1 0 1];

%find derivative of image with firt mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gx(x,y) = w3(1,1)*skeleton_doub(x-1,y-1)+w3(1,2)*skeleton_doub(x-1,y)+w3(1,3)*skeleton_doub(x-1,y+1)...
                      +w3(2,1)*skeleton_doub(x,y-1)+w3(2,2)*skeleton_doub(x,y)+w3(2,3)*skeleton_doub(x,y+1)...
                      +w3(3,1)*skeleton_doub(x+1,y-1)+w3(3,2)*skeleton_doub(x+1,y)+w3(3,3)*skeleton_doub(x+1,y+1);     
    end
end

%find dirivative of image with second mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gy(x,y) = w4(1,1)*skeleton_doub(x-1,y-1)+w4(1,2)*skeleton_doub(x-1,y)+w4(1,3)*skeleton_doub(x-1,y+1)...
                      +w4(2,1)*skeleton_doub(x,y-1)+w4(2,2)*skeleton_doub(x,y)+w4(2,3)*skeleton_doub(x,y+1)...
                      +w4(3,1)*skeleton_doub(x+1,y-1)+w4(3,2)*skeleton_doub(x+1,y)+w4(3,3)*skeleton_doub(x+1,y+1);     
    end
end

%find gradient of image
M = abs(gx) + abs(gy);
gradient = im2uint8(M);

%find min and max of gradient image
min_col = min(gradient);
min_grad = min(min_col);
max_col = max(gradient);
max_grad = max(max_col);

%expand intensities to fit range of 0 to 255
gradient_exp = (gradient-min_grad).*(255/(max_grad-min_grad));

%plot original image and gradient image in subplots
figure(3)
colormap gray;
subplot(1,2,1)
imagesc(skeleton);
title('Original Skeleton');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,2,2)
imagesc(gradient_exp);
title('Gradient of Skeleton');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

skeleton_pad = padarray(skeleton, [2 2], 0, 'both');

%find size of image and convert to double
[row,col] = size(skeleton_pad);
skeleton_pad_doub = im2double(skeleton_pad);

%complete summation equation to blur in 15x15 neighborhoods
for x = 1+2:row-2
    for y = 1+2:col-2
        total=0;
        for s = -2:2
            for t = -2:2
                total = total+(skeleton_pad_doub(x+s,y+t));
            end
            average(x-2,y-2) = total/255;
        end
    end
end

%find max intensity of smoothed image
min_col = min(average);
min_value = min(min_col);
max_col = max(average);
max_value = max(max_col);

%expand intensities to fit range of 0 to 255
average_exp = (average-min_value).*(255/(max_value-min_value));

%plot original image and gradient image in subplots
figure(4)
colormap gray;
subplot(1,2,1)
imagesc(skeleton);
title('Original Skeleton');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,2,2)
imagesc(average_exp);
title('5x5 Neighborhood averaging of Skeleton');
xlabel('X (spatial units)'); 
ylabel('Y (spatial units)');
colorbar;

%find product of (laplace + origina) * 5x5 blurred
[row_prod, col_prod] = size(add_laplace_final);
for x=1+1:row_prod-1
    for y = 1+1:col_prod-1
       product(x,y) = add_laplace_final(x,y) * average_exp(x,y);
    end
end

%convert to uint8 data type
product_final = im2uint8(product);

%plot product image
figure(5)
colormap gray;
imshow(product_final);
title('Product image');
xlabel('X (spatial units)'); 
ylabel('Y (spatial units)');

%find addition image of original skeleton and the product above
for x=1+1:row_prod-1
    for y = 1+1:col_prod-1
        addition(x,y) = skeleton(x,y) + product_final(x,y);
    end
end

%plot addition image
figure(6)
colormap gray;
imshow(addition);
title('Addition image');
xlabel('X (spatial units)'); 
ylabel('Y (spatial units)');

%complete gamma transformation
addition_doub = im2double(addition);
addition_gamma = addition_doub.^0.5;

%plot gamma transformation
figure(7)
subplot(1,2,1)
imshow(skeleton);
title('Original Skeleton');
xlabel('X (spatial units)'); 
ylabel('Y (spatial units)');
subplot(1,2,2)
imshow(addition_gamma);
title({'Final Image, Gamma Corrected', 'Gamma = 0.5'});
xlabel('X (spatial units)'); 
ylabel('Y (spatial units)');