%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Edge Detection
% Filename: Tipton_EGR532_Lab7PartD.m
% Author: Natalie Tipton
% Date: 3/21/19
% Instructor: Dr. Rhodes
% Description: This script applies thresholding to gradient magnitude
%   images of smoothed and unsmoothed original images.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part D %%%%%%%%%%

%read in building image and find size
building = imread('Building.tif');
[row, col] = size(building);

%convert building to type double
b = im2double(building);

%create both masks
w1 = [-1 -2 -1; 0 0 0; 1 2 1];
w2 = [-1 0 1; -2 0 2; -1 0 1];

%find derivative of image with first mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gx(x,y) = w1(1,1)*b(x-1,y-1)+w1(1,2)*b(x-1,y)+w1(1,3)*b(x-1,y+1)...
                      +w1(2,1)*b(x,y-1)+w1(2,2)*b(x,y)+w1(2,3)*b(x,y+1)...
                      +w1(3,1)*b(x+1,y-1)+w1(3,2)*b(x+1,y)+w1(3,3)*b(x+1,y+1);     
    end
end

%find derivative of image with second mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gy(x,y) = w2(1,1)*b(x-1,y-1)+w2(1,2)*b(x-1,y)+w2(1,3)*b(x-1,y+1)...
                      +w2(2,1)*b(x,y-1)+w2(2,2)*b(x,y)+w2(2,3)*b(x,y+1)...
                      +w2(3,1)*b(x+1,y-1)+w2(3,2)*b(x+1,y)+w2(3,3)*b(x+1,y+1);     
    end
end

%find gradient magnitude of image
M = abs(gx) + abs(gy);
M = im2uint8(M);
[row_M, col_M] = size(M);
%find max intensity and create threshold from that
max_intensity = max(M(:));
threshold = max_intensity * 0.33;

%apply thresholdhing
for i = 1:row_M
    for j = 1:col_M
        if M(i,j) > threshold
            M_thresh(i,j) = 255;
        else
            M_thresh(i,j) = 0;
        end
    end
end

%complete summation equation to blur original in 5x5 neighborhoods
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

%find derivative of smoothed image with first mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gx(x,y) = w1(1,1)*smooth(x-1,y-1)+w1(1,2)*smooth(x-1,y)+w1(1,3)*smooth(x-1,y+1)...
                      +w1(2,1)*smooth(x,y-1)+w1(2,2)*smooth(x,y)+w1(2,3)*smooth(x,y+1)...
                      +w1(3,1)*smooth(x+1,y-1)+w1(3,2)*smooth(x+1,y)+w1(3,3)*smooth(x+1,y+1);     
    end
end

%find derivative of smoothed image with second mask
for x = 1+1:row-1
    for y = 1+1:col-1
        gy(x,y) = w2(1,1)*smooth(x-1,y-1)+w2(1,2)*smooth(x-1,y)+w2(1,3)*smooth(x-1,y+1)...
                      +w2(2,1)*smooth(x,y-1)+w2(2,2)*smooth(x,y)+w2(2,3)*smooth(x,y+1)...
                      +w2(3,1)*smooth(x+1,y-1)+w2(3,2)*smooth(x+1,y)+w2(3,3)*smooth(x+1,y+1);     
    end
end

%find gradient magnitude of smoothed image
M_smooth = abs(gx) + abs(gy);
M_smooth = im2uint8(M_smooth);
[row_Msmooth, col_Msmooth] = size(M_smooth);

%find max intensity of smoothed image and create threshold
max_intensity_smooth = max(M_smooth(:));
threshold_smooth = max_intensity_smooth * 0.33;

%apply thresholding
for i = 1:row_Msmooth
    for j = 1:col_Msmooth
        if M_smooth(i,j) > threshold_smooth
            M_thresh_smooth(i,j) = 255;
        else
            M_thresh_smooth(i,j) = M(i,j);
        end
        
        if M_thresh_smooth(i,j) ~= 255
            M_thresh_smooth(i,j) = 0;
        end
    end
end

%plot original and smoothed and thresholded magnitude images for both
figure(1)
colormap gray;
subplot(2,2,1)
imagesc(building);
title('Original Building');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2);
imagesc(M_thresh);
title({'Thresholded Gradient Magnitude','of Un-Smoothed Building'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imagesc(smooth);
title('Smoothed Building');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4);
imagesc(M_thresh_smooth);
title({'Thresholded Gradient Magnitude','of Smoothed Building'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;




