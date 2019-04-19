%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Filtering in the Frequency Domain
% Filename: Tipton_EGR532_Lab8PartA2.m
% Author: Natalie Tipton
% Date: 4/2/19
% Instructor: Dr. Rhodes
% Description: This script applies a Butterworth Low Pass Filter
%   to an image using differing cut off values and orders
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A - Section 2 %%%%%%%%%%
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
n = 2;

%calculate D
for u = 1:P
    for v = 1:Q
        D(u,v) = sqrt(((u - P/2)^2) + ((v - Q/2)^2));
    end
end

%determine filter by finding H for all D0s
for u = 1:P
    for v = 1:Q
        H1(u,v) = 1 / (1 + (D(u,v)/D01)^n);
        H2(u,v) = 1 / (1 + (D(u,v)/D02)^n);
        H3(u,v) = 1 / (1 + (D(u,v)/D03)^n);
        H4(u,v) = 1 / (1 + (D(u,v)/D04)^n);
        H5(u,v) = 1 / (1 + (D(u,v)/D05)^n);
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
        gp1(x,y) = gp1(x,y) *((-1)^(x+y));
        gp2(x,y) = gp2(x,y) *((-1)^(x+y));
        gp3(x,y) = gp3(x,y) *((-1)^(x+y));
        gp4(x,y) = gp4(x,y) *((-1)^(x+y));
        gp5(x,y) = gp5(x,y) *((-1)^(x+y));
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
subplot(1,2,1); imshow(test); title({'Part A - Section 2','Original Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,2,2); imshow(test_pad); title({'Part A - Section 2','Zero Padded Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display G (H * F)
figure(2);
subplot(3,2,1); imshow(G1); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 10, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,2); imshow(G2); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 30, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,3); imshow(G3); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 60, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,4); imshow(G4); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 160, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,5); imshow(G5); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 460, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display final, cropped, output images
figure(3)
subplot(3,2,1); imshow(gp1); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 10, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,2); imshow(gp2); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 30, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,3); imshow(gp3); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 60, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,4); imshow(gp4); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 160, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,5); imshow(gp5); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 460, n = 2'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

n2 = 20;

%calculate D
for u = 1:P
    for v = 1:Q
        D(u,v) = sqrt(((u - P/2)^2) + ((v - Q/2)^2));
    end
end

%determine filter by finding H for all D0s
for u = 1:P
    for v = 1:Q
        H1b(u,v) = 1 / (1 + (D(u,v)/D01)^n2);
        H2b(u,v) = 1 / (1 + (D(u,v)/D02)^n2);
        H3b(u,v) = 1 / (1 + (D(u,v)/D03)^n2);
        H4b(u,v) = 1 / (1 + (D(u,v)/D04)^n2);
        H5b(u,v) = 1 / (1 + (D(u,v)/D05)^n2);
    end
end

%calculate G for all D0
G1b = H1b .* F;
G2b = H2b .* F;
G3b = H3b .* F;
G4b = H4b .* F;
G5b = H5b .* F;

%Find gp for all D0 
gp1b = real(ifft2(G1b));
gp2b = real(ifft2(G2b));
gp3b = real(ifft2(G3b));
gp4b = real(ifft2(G4b));
gp5b = real(ifft2(G5b));
for x = 1:P
    for y = 1:Q
        gp1b(x,y) = gp1b(x,y) *((-1)^(x+y));
        gp2b(x,y) = gp2b(x,y) *((-1)^(x+y));
        gp3b(x,y) = gp3b(x,y) *((-1)^(x+y));
        gp4b(x,y) = gp4b(x,y) *((-1)^(x+y));
        gp5b(x,y) = gp5b(x,y) *((-1)^(x+y));
    end
end

%crop gps to quadrant 2
rect = [0 0 M N];
gp1b = imcrop(gp1b, rect);
gp1b = im2uint8(gp1b);
gp2b = imcrop(gp2b, rect);
gp2b = im2uint8(gp2b);
gp3b = imcrop(gp3b, rect);
gp3b = im2uint8(gp3b);
gp4b = imcrop(gp4b, rect);
gp4b = im2uint8(gp4b);
gp5b = imcrop(gp5b, rect);
gp5b = im2uint8(gp5b);

%display original and padded image
figure(4)
subplot(1,2,1); imshow(test); title({'Part A - Section 2','Original Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,2,2); imshow(test_pad); title({'Part A - Section 2','Zero Padded Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display G (H * F)
figure(5);
subplot(3,2,1); imshow(G1b); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 10, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,2); imshow(G2b); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 30, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,3); imshow(G3b); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 60, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,4); imshow(G4b); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 160, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,5); imshow(G5b); title({'Part A - Section 2, BLPF','Filtered FT (G), D0 = 460, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display final, cropped, output images
figure(6)
subplot(3,2,1); imshow(gp1b); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 10, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,2); imshow(gp2b); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 30, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,3); imshow(gp3b); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 60, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,4); imshow(gp4b); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 160, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(3,2,5); imshow(gp5b); title({'Part A - Section 2, BLPF','Smoothed Image (gp), D0 = 460, n = 20'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');


