%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Filtering in the Frequency Domain
% Filename: Tipton_EGR532_Lab8PartA.m
% Author: Natalie Tipton
% Date: 4/2/19
% Instructor: Dr. Rhodes
% Description: This script applies Ideal Low Pass Filter to an image
% with multiple different cut off values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A - Section 1 %%%%%%%%%%
clear; clc;

%read in image, convert to double, and find size
test = imread('TestPattern.tif');
test_norm = mat2gray(test);
[M,N] = size(test);

%zero pad image and find size
test_pad = padarray(test_norm,[M N],0,'post');
[P,Q] = size(test_pad);

%center zero-padded image
for x = 1:P
    for y = 1:Q
        test_pad_center(x,y) = test_pad(x,y) * ((-1)^(x+y));
    end
end

%find 2D FT
F = fft2(test_pad_center);

%initialize D0 values
D01 = 10;
D02 = 30;
D03 = 60;
D04 = 160;
D05 = 460;

%calculate D
for u = 1:P
    for v = 1:Q
        D(u,v) = sqrt(((u - P/2)^2) + ((v - Q/2)^2));
    end
end

%determine filter by finding H for all D0s
for i = 1:P
    for j = 1:Q
        if D(i,j) <= D01
            H1(i,j) = 1;
        else
            H1(i,j) = 0;
        end
    end
end

%D0 2
for i = 1:P
    for j = 1:Q
        if D(i,j) <= D02
            H2(i,j) = 1;
        else
            H2(i,j) = 0;
        end
    end
end

%D0 3
for i = 1:P
    for j = 1:Q
        if D(i,j) <= D03
            H3(i,j) = 1;
        else
            H3(i,j) = 0;
        end
    end
end

%D0 4
for i = 1:P
    for j = 1:Q
        if D(i,j) <= D04
            H4(i,j) = 1;
        else
            H4(i,j) = 0;
        end
    end
end

%D0 5
for i = 1:P
    for j = 1:Q
        if D(i,j) <= D05
            H5(i,j) = 1;
        else
            H5(i,j) = 0;
        end
    end
end

%calculate G for all D0
G1 = H1 .* F;
G2 = H2 .* F;
G3 = H3 .* F;
G4 = H4 .* F;
G5 = H5 .* F;

%Find gp for all D0 
gp1 = real(ifft2(G1));
gp2 = real(ifft2(G2));
gp3 = real(ifft2(G3));
gp4 = real(ifft2(G4));
gp5 = real(ifft2(G5));

for x = 1:P
    for y = 1:Q
        gp1(x,y) = gp1(x,y)*((-1)^(x+y));
        gp2(x,y) = gp2(x,y)*((-1)^(x+y));
        gp3(x,y) = gp3(x,y)*((-1)^(x+y));
        gp4(x,y) = gp4(x,y)*((-1)^(x+y));
        gp5(x,y) = gp5(x,y)*((-1)^(x+y));
    end
end

%crop gps to quadrant 2
rect = [0 0 M N];
gp1 = imcrop(gp1, rect);
gp1 = im2uint8(gp1);
gp2 = imcrop(gp2, rect);
gp2 = im2uint8(gp2);
gp3 = imcrop(gp3, rect);
gp3 = im2uint8(gp3);
gp4 = imcrop(gp4, rect);
gp4 = im2uint8(gp4);
gp5 = imcrop(gp5, rect);
gp5 = im2uint8(gp5);

%display original and padded image
figure(1)
subplot(1,2,1); imshow(test); title({'Part A - Section 1','Original Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,2,2); imshow(test_pad); title({'Part A - Section 1','Zero Padded Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display G (H * F)
figure(2);
subplot(3,2,1); imshow(G1); title({'Part A - Section 1, ILPF','Filtered FT (G), D0 = 10'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,2); imshow(G2); title({'Part A - Section 1, ILPF','Filtered FT (G), D0 = 30'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,3); imshow(G3); title({'Part A - Section 1, ILPF','Filtered FT (G), D0 = 60'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,4); imshow(G4); title({'Part A - Section 1, ILPF','Filtered FT (G), D0 = 160'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,5); imshow(G5); title({'Part A - Section 1, ILPF','Filtered FT (G), D0 = 460'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display final, cropped, output images
figure(3)
subplot(3,2,1); imshow(gp1); title({'Part A - Section 1, ILPF','Smoothed Image (gp), D0 = 10'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,2); imshow(gp2); title({'Part A - Section 1, ILPF','Smoothed Image (gp), D0 = 30'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,3); imshow(gp3); title({'Part A - Section 1, ILPF','Smoothed Image (gp), D0 = 60'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,4); imshow(gp4); title({'Part A - Section 1, ILPF','Smoothed Image (gp), D0 = 160'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,5); imshow(gp5); title({'Part A - Section 1, ILPF','Smoothed Image (gp), D0 = 460'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');