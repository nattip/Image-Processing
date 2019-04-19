%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Edge Detection
% Filename: Tipton_EGR532_Lab7PartB.m
% Author: Natalie Tipton
% Date: 3/21/19
% Instructor: Dr. Rhodes
% Description: This script applies sobel masks to a smoothed image 
%   in order to find the magnitude and angle images. The output shows
%   more defined horizontal and vertical edges than when the image was
%   not smoothed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B %%%%%%%%%%

%read in building image and find size
building = imread('Building.tif');
[row, col] = size(building);

%convert building to double
b = im2double(building);

%create both sobel masks
w1 = [-1 -2 -1; 0 0 0; 1 2 1];
w2 = [-1 0 1; -2 0 2; -1 0 1];

%complete summation equation to blur in 5x5 neighborhoods
for x = 1+2:row-2
    for y = 1+2:col-2
        total=0;
        for s = -2:2
            for t = -2:2
                total = total+(b(x+s,y+t));
            end
            smooth(x+2,y+2) = total/255;
        end
    end
end

%find derivative of image with first mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gx(x,y) = w1(1,1)*smooth(x-1,y-1)+w1(1,2)*smooth(x-1,y)+w1(1,3)*smooth(x-1,y+1)...
                      +w1(2,1)*smooth(x,y-1)+w1(2,2)*smooth(x,y)+w1(2,3)*smooth(x,y+1)...
                      +w1(3,1)*smooth(x+1,y-1)+w1(3,2)*smooth(x+1,y)+w1(3,3)*smooth(x+1,y+1);     
    end
end

%find derivative of image with second mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gy(x,y) = w2(1,1)*smooth(x-1,y-1)+w2(1,2)*smooth(x-1,y)+w2(1,3)*smooth(x-1,y+1)...
                      +w2(2,1)*smooth(x,y-1)+w2(2,2)*smooth(x,y)+w2(2,3)*smooth(x,y+1)...
                      +w2(3,1)*smooth(x+1,y-1)+w2(3,2)*smooth(x+1,y)+w2(3,3)*smooth(x+1,y+1);     
    end
end

%find gradient magnitude of image
M = abs(gx) + abs(gy);
M = im2uint8(M);
%find gradient angle of image
alpha = atan(gy ./ gx);
alpha = im2uint8(alpha);

%plot original image, smoothed image, gx, and gy in subplots
figure(1)
colormap gray;
subplot(2,2,1)
imagesc(building);
title('Original Building');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
imagesc(smooth);
title({'Smoothed Building','5x5 Averaging Filter'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imagesc(gx);
title({'Partial Derivative of Original','In Terms of X (gx)'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4)
imagesc(gy);
title({'Partial Derivative of Original','In Terms of Y (gy)'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%in new figure, show gradient magnitude and gradient angle in subplots
figure(2)
colormap gray;
subplot(1,2,1)
imagesc(M);
title('Gradient Magnitude of Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,2,2)
imagesc(alpha);
title('Gradient Angle of Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
