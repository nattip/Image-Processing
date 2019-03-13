%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Spatial Filtering & Image Enhancement
% Filename: Tipton_EGR532_Lab5PartA.m
% Author: Natalie Tipton
% Date: 2/28/19
% Instructor: Dr. Rhodes
% Description: This script completes linear and non-linear smoothing 
%   spatial filters using neighborhoods as described by Part A of LE 5.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A - Section 1 %%%%%%%%%%

%read in hubble image
hubble = imread('Hubble.tif');

%pad image with zeroes around outside
hubble_pad = padarray(hubble, [7 7], 0, 'both');

%find size of image and convert to double
[row,col] = size(hubble_pad);
hubble_pad_doub = im2double(hubble_pad);

%complete summation equation to blur in 15x15 neighborhoods
for x = 1+7:row-7
    for y = 1+7:col-7
        total=0;
        for s = -7:7
            for t = -7:7
                total = total+(hubble_pad_doub(x+s,y+t));
            end
            g(x-7,y+7) = total/255;
        end
    end
end

%find max intensity of smoothed image
max_col = max(g);
max_value = max(max_col);

%find size of smoothed image
[row,col] = size(g);

%compete intensity threshold with m = 25% of max intensity
m = 0.25 * max_value;
for x=1:row
    for y=1:col
        if(g(x,y)>m)
            smooth_hubble_thresh(x,y) = 255;
        else
            smooth_hubble_thresh(x,y) = 0;
        end
    end
end

%plot original, smoothed, and intensity threshold images in subplots
figure(1)
colormap gray;
subplot(1,3,1)
imagesc(hubble);
title('Original Hubble');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,3,2)
imagesc(g);
title('Smoothed Hubble');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,3,3)
imagesc(smooth_hubble_thresh)
title({'Smoothed Hubble','Intensity Threshold - 25%'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;


%%%%%%%% Part A - Section 2 %%%%%%%%%% 

circuit_board = imread('CircuitBoard.tif');

circuit_pad = padarray(circuit_board, [1 1], 0, 'both');

%find size of image and convert to double
[row,col] = size(circuit_pad);
circuit_pad_doub = im2double(circuit_pad);

%complete summation equation to blur in 3x3 neighborhoods
for x = 1+1:row-1
    for y = 1+1:col-1
        total=0;
        for s = -1:1
            for t = -1:1
                total = total+(circuit_pad_doub(x+s,y+t));
            end
            out(x-1,y+1) = total/9;
        end
    end
end

%plot original, average filtered, and median filtered images in subplots
figure(2)
colormap gray;
subplot(1,3,1)
imagesc(circuit_board);
title('Original Circuit Board');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,3,2)
imagesc(out);
title({'Circuit Board','Average Filtered'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(1,3,3)
imagesc(medfilt2(circuit_board))
title({'Circuit Board','Median Filtered'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;        