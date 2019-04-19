%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Filtering in the Frequency Domain
% Filename: Tipton_EGR532_Lab8PartB.m
% Author: Natalie Tipton
% Date: 4/2/19
% Instructor: Dr. Rhodes
% Description: This script applies an Ideal, Butterworth, and 
%   Gaussian High Pass filter to an image, respectively.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B - Section 1 %%%%%%%%%%

%%%%%% Ideal %%%%%%

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
D01 = 20;
D02 = 60;
D03 = 160;

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
            H1(i,j) = 0;
        else
            H1(i,j) = 1;
        end
    end
end

%D0 2
for i = 1:P
    for j = 1:Q
        if D(i,j) <= D02
            H2(i,j) = 0;
        else
            H2(i,j) = 1;
        end
    end
end

%D0 3
for i = 1:P
    for j = 1:Q
        if D(i,j) <= D03
            H3(i,j) = 0;
        else
            H3(i,j) = 1;
        end
    end
end

%calculate G for all D0
G1 = H1 .* F;
G2 = H2 .* F;
G3 = H3 .* F;

%Find gp for all D0 
gp1 = real(ifft2(G1));
gp2 = real(ifft2(G2));
gp3 = real(ifft2(G3));
for x = 1:P
    for y = 1:Q
        gp1(x,y) = gp1(x,y)*((-1)^(x+y));
        gp2(x,y) = gp2(x,y)*((-1)^(x+y));
        gp3(x,y) = gp3(x,y)*((-1)^(x+y));
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

%display original and padded image
figure(1)
subplot(1,2,1); imshow(test); title({'Part B - Section 1','Original Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,2,2); imshow(test_pad); title({'Part B - Section 1','Zero Padded Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display G (H * F)
figure(2);
subplot(1,3,1); imshow(G1); title({'Part B - Section 1, IHPF','Filtered FT (G), D0 = 30'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,2); imshow(G2); title({'Part B - Section 1, IHPF','Filtered FT (G), D0 = 60'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,3); imshow(G3); title({'Part B - Section 1, IHPF','Filtered FT (G), D0 = 160'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display final, cropped, output images
figure(3)
subplot(1,3,1); imshow(gp1); title({'Part B - Section 1, IHPF','Sharpened Image (gp), D0 = 30'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,2); imshow(gp2); title({'Part B - Section 1, IHPF','Sharpened Image (gp), D0 = 60'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,3); imshow(gp3); title({'Part B - Section 1, IHPF','Sharpened Image (gp), D0 = 160'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%%%%%% Butterworth %%%%%%

clear; 

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
D01 = 30;
D02 = 60;
D03 = 160;
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
        H1(u,v) = 1 / (1 + (D01/D(u,v)^n));
        H2(u,v) = 1 / (1 + (D02/D(u,v)^n));
        H3(u,v) = 1 / (1 + (D03/D(u,v)^n));
    end
end

%calculate G for all D0
G1 = H1 .* F;
G2 = H2 .* F;
G3 = H3 .* F;

%Find gp for all D0 
gp1 = real(ifft2(G1));
gp2 = real(ifft2(G2));
gp3 = real(ifft2(G3));
for x = 1:P
    for y = 1:Q
        gp1(x,y) = gp1(x,y)*((-1)^(x+y));
        gp2(x,y) = gp2(x,y)*((-1)^(x+y));
        gp3(x,y) = gp3(x,y)*((-1)^(x+y));
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

%display original and padded image
figure(4)
subplot(1,2,1); imshow(test); title({'Part B - Section 1','Original Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,2,2); imshow(test_pad); title({'Part B - Section 1','Zero Padded Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display G (H * F)
figure(5);
subplot(1,3,1); imshow(G1); title({'Part B - Section 1, BHPF','Filtered FT (G), D0 = 30'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,2); imshow(G2); title({'Part B - Section 1, BHPF','Filtered FT (G), D0 = 60'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,3); imshow(G3); title({'Part B - Section 1, BHPF','Filtered FT (G), D0 = 160'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display final, cropped, output images
figure(6)
subplot(1,3,1); imshow(gp1); title({'Part B - Section 1, BHPF','Sharpened Image (gp), D0 = 30'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,2); imshow(gp2); title({'Part B - Section 1, BHPF','Sharpened Image (gp), D0 = 60'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,3); imshow(gp3); title({'Part B - Section 1, BHPF','Sharpened Image (gp), D0 = 160'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%%%%%% Gaussian %%%%%%

clear; 

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
D01 = 30;
D02 = 60;
D03 = 160;

%calculate D
for u = 1:P
    for v = 1:Q
        D(u,v) = sqrt(((u - P/2)^2) + ((v - Q/2)^2));
    end
end

%determine filter by finding H for all D0s
for i = 1:P
    for j = 1:Q
        H1(i,j) = 1-exp((-D(i,j)^2)/(2*D01^2));
        H2(i,j) = 1-exp((-D(i,j)^2)/(2*D02^2));
        H3(i,j) = 1-exp((-D(i,j)^2)/(2*D03^2));
    end
end

%calculate G for all D0
G1 = H1 .* F;
G2 = H2 .* F;
G3 = H3 .* F;

%Find gp for all D0 
gp1 = real(ifft2(G1));
gp2 = real(ifft2(G2));
gp3 = real(ifft2(G3));
for x = 1:P
    for y = 1:Q
        gp1(x,y) = gp1(x,y)*((-1)^(x+y));
        gp2(x,y) = gp2(x,y)*((-1)^(x+y));
        gp3(x,y) = gp3(x,y)*((-1)^(x+y));
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

%display original and padded image
figure(7)
subplot(1,2,1); imshow(test); title({'Part B - Section 1','Original Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,2,2); imshow(test_pad); title({'Part B - Section 1','Zero Padded Image'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display G (H * F)
figure(7);
subplot(1,3,1); imshow(G1); title({'Part B - Section 1, GHPF','Filtered FT (G), D0 = 30'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,2); imshow(G2); title({'Part B - Section 1, GHPF','Filtered FT (G), D0 = 60'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,3); imshow(G3); title({'Part B - Section 1, GHPF','Filtered FT (G), D0 = 160'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');

%display final, cropped, output images
figure(9)
subplot(1,3,1); imshow(gp1); title({'Part B - Section 1, GHPF','Sharpened Image (gp), D0 = 30'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,2); imshow(gp2); title({'Part B - Section 1, GHPF','Sharpened Image (gp), D0 = 60'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');
subplot(1,3,3); imshow(gp3); title({'Part B - Section 1, GHPF','Sharpened Image (gp), D0 = 160'});
xlabel('X (spatial units)'); ylabel('Y (spatial units)');




