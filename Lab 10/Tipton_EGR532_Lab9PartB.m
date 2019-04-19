%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Filtering in the Frequency Domain
% Filename: Tipton_EGR532_Lab9PartB.m
% Author: Natalie Tipton
% Date: 4/9/19
% Instructor: Dr. Rhodes
% Description: This script performs inverse radon transform to 
%   obtain the original image from a sinogramusing backprojection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part B %%%%%%%%%%
clear; clc

circle = imread('CirclePhantom.tif');
circle_doub = im2double(circle);
[row_cir, col_cir] = size(circle_doub);

%create incrementation for theta values
theta0 = 0:0.5:180;
angles0 = length(theta0);

%preallocate space for sinogram
g = zeros([col_cir angles0]);

%calculate sinogram
for i = 1:angles0
    %rotate image through 0 to 180 degrees
    f = imrotate(circle_doub, theta0(i), 'bicubic', 'crop');
    for x = 1:row_cir
        for y = 1:col_cir
            g(y,i) = g(y,i) + f(x,y);
        end
    end
end

%angles for backprojection 1
theta1 = [0];
f1 = zeros([row_cir col_cir]);

for i = 1:length(theta1)
    %rotate image through 0 to 180 degrees
    f1 = imrotate(f1, theta1(i), 'bicubic', 'crop');
    for x = 1:row_cir
        for y = 1:col_cir
            %smear g up each column
            f1(:,y) = f1(:,y) + g(y,i*2);
        end
    end
end

%angles for backprojection 2
theta2 = [0 45];
f2 = zeros([row_cir col_cir]);

for i = 1:length(theta2)
    %rotate image through 0 to 180 degrees
    f2 = imrotate(f2, theta2(i), 'bicubic', 'crop');
    for x = 1:row_cir
        for y = 1:col_cir
            f2(:,y) = f2(:,y) + g(y,i*2);
        end
    end
end

%angles for backprojection 3
theta3 = [0 45 90 135];
f3 = zeros([row_cir col_cir]);

for i = 1:length(theta3)
    %rotate image through 0 to 180 degrees
    f3 = imrotate(f3, theta3(i), 'bicubic', 'crop');
    for y = 1:col_cir
        f3(:,y) = f3(:,y) + g(y,i*2);
    end
end

%create incrementation 0f 5.625 degrees for theta values
theta4 = linspace(0,180,32);
angles4 = length(theta4);

%preallocate space for sinogram
g4 = zeros([col_cir angles4]);

%calculate sinogram
for i = 1:angles4
    %rotate image through 0 to 180 degrees
    f = imrotate(circle_doub, theta4(i), 'bicubic', 'crop');
    for x = 1:row_cir
        for y = 1:col_cir
            g4(y,i) = g4(y,i) + f(x,y);
        end
    end
end

f4 = zeros([row_cir col_cir]);

for i = 1:length(theta4)
    %rotate image through 0 to 180 degrees
    f4 = imrotate(f4, theta4(i), 'bicubic', 'crop');
    for x = 1:row_cir
        for y = 1:col_cir
            %smear g up through each column at given angle
            f4(:,y) = f4(:,y) + g4(y,i);
        end
    end
end

%create incrementation of 2.8125 degrees for theta values
theta5 = linspace(0,180,64);
angles5 = length(theta5);

%preallocate space for sinogram
g5 = zeros([col_cir angles5]);

%calculate sinogram
for i = 1:angles5
    %rotate image through 0 to 180 degrees
    f = imrotate(circle_doub, theta5(i), 'bicubic', 'crop');
    for x = 1:row_cir
        for y = 1:col_cir
            g5(y,i) = g5(y,i) + f(x,y);
        end
    end
end

f5 = zeros([row_cir col_cir]);

for i = 1:length(theta5)
    %rotate image through 0 to 180 degrees
    f5 = imrotate(f5, theta5(i), 'bicubic', 'crop');
    for x = 1:row_cir
        for y = 1:col_cir
            %smear g up through each column at given angle
            f5(:,y) = f5(:,y) + g5(y,i);
        end
    end
end

circle_rad = radon(circle,0:179);
circle_back_fil = iradon(circle_rad, 0:179);
circle_back = iradon(circle_rad, 0:179,'linear','none');

%plot original image with each backprojection
figure(1)
colormap gray;
subplot(3,2,1)
imagesc(circle)
title('Part B - Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,2)
imagesc(f1)
title({'Part B, 1 backprojection','Theta = 0'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,3)
imagesc(f2)
title({'Part B, 2 backprojections','Theta = 0, 45'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,4)
imagesc(f3)
title({'Part B, 4 backprojections','Theta = 0, 45, 90, 135'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,5)
imagesc(f4)
title({'Part B, 32 backprojections','5.625 degrees apart'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,6)
imagesc(f5)
title({'Part B, 64 backprojections','2.8125 degrees apart'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

%plot matlab created transform for comparison
figure(2)
colormap gray;
subplot(2,2,1)
imagesc(g)
title('Part B - Manually Created Sinogram');
xlabel('l');
ylabel('theta (0.5 degrees)');
subplot(2,2,2)
imagesc(circle_rad)
title('Part B - radon Function Created Sinogram');
xlabel('l');
ylabel('theta (0.5 degrees)');
subplot(2,2,3)
imagesc(circle_back_fil)
title({'Part B - iradon Function Created Image','Filtered'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imagesc(circle_back)
title({'Part B - iradon Function Created Image','Un-filtered'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

elipse = imread('EllipseCirclePhantom.tif');
elipse_doub = im2double(elipse);
[row_eli, col_eli] = size(elipse_doub);

%create incrementation for theta values
theta0 = 0:0.5:180;
angles0 = length(theta0);

%preallocate space for sinogram
gb = zeros([col_eli angles0]);

%calculate sinogram
for i = 1:angles0
    %rotate image through 0 to 180 degrees
    fb = imrotate(elipse_doub, theta0(i), 'bicubic', 'crop');
    for x = 1:row_eli
        for y = 1:col_eli
            gb(y,i) = gb(y,i) + fb(x,y);
        end
    end
end

%angles for backprojection 1
theta1 = [0];
f1b = zeros([row_eli col_eli]);

for i = 1:length(theta1)
    %rotate image through 0 to 180 degrees
    f1b = imrotate(f1b, theta1(i), 'bicubic', 'crop');
    for x = 1:row_eli
        for y = 1:col_eli
            %smear g up each column
            f1b(:,y) = f1b(:,y) + gb(y,i*2);
        end
    end
end

%angles for backprojection 2
theta2 = [0 45];
f2b = zeros([row_eli col_eli]);

for i = 1:length(theta2)
    %rotate image through 0 to 180 degrees
    f2b = imrotate(f2b, theta2(i), 'bicubic', 'crop');
    for x = 1:row_eli
        for y = 1:col_eli
            f2b(:,y) = f2b(:,y) + gb(y,i*2);
        end
    end
end

%angles for backprojection 3
theta3 = [0 45 90 135];
f3b = zeros([row_eli col_eli]);

for i = 1:length(theta3)
    %rotate image through 0 to 180 degrees
    f3b = imrotate(f3b, theta3(i), 'bicubic', 'crop');
    for x = 1:row_eli
        for y = 1:col_eli
            f3b(:,y) = f3b(:,y) + gb(y,i*2);
        end
    end
end

%create incrementation 0f 5.625 degrees for theta values
theta4 = linspace(0,180,32);
angles4 = length(theta4);

%preallocate space for sinogram
g4b = zeros([col_eli angles4]);

%calculate sinogram
for i = 1:angles4
    %rotate image through 0 to 180 degrees
    fb = imrotate(elipse_doub, theta4(i), 'bicubic', 'crop');
    for x = 1:row_eli
        for y = 1:col_eli
            g4b(y,i) = g4b(y,i) + fb(x,y);
        end
    end
end

f4b = zeros([row_eli col_eli]);

for i = 1:length(theta4)
    %rotate image through 0 to 180 degrees
    f4b = imrotate(f4b, theta4(i), 'bicubic', 'crop');
    for x = 1:row_eli
        for y = 1:col_eli
            %smear g up through each column at given angle
            f4b(:,y) = f4b(:,y) + g4b(y,i);
        end
    end
end

%create incrementation of 2.8125 degrees for theta values
theta5 = linspace(0,180,64);
angles5 = length(theta5);

%preallocate space for sinogram
g5b = zeros([col_eli angles5]);

%calculate sinogram
for i = 1:angles5
    %rotate image through 0 to 180 degrees
    fb = imrotate(elipse_doub, theta5(i), 'bicubic', 'crop');
    for x = 1:row_eli
        for y = 1:col_eli
            g5b(y,i) = g5b(y,i) + fb(x,y);
        end
    end
end

f5b = zeros([row_eli col_eli]);

for i = 1:length(theta5)
    %rotate image through 0 to 180 degrees
    f5b = imrotate(f5b, theta5(i), 'bicubic', 'crop');
    for x = 1:row_eli
        for y = 1:col_eli
            %smear g up through each column at given angle
            f5b(:,y) = f5b(:,y) + g5b(y,i);
        end
    end
end

ellipse_rad = radon(elipse,0:179);
ellipse_back_fil = iradon(ellipse_rad, 0:179);
ellipse_back = iradon(ellipse_rad, 0:179,'linear','none');

%plot original image with each backprojection
figure(3)
colormap gray;
subplot(3,2,1)
imagesc(elipse)
title('Part B - Original Image');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,2)
imagesc(f1b)
title({'Part B, 1 backprojection','Theta = 0'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,3)
imagesc(f2b)
title({'Part B, 2 backprojections','Theta = 0, 45'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,4)
imagesc(f3b)
title({'Part B, 4 backprojections','Theta = 0, 45, 90, 135'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,5)
imagesc(f4b)
title({'Part B, 32 backprojections','5.625 degrees apart'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(3,2,6)
imagesc(f5b)
title({'Part B, 64 backprojections','2.8125 degrees apart'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

figure(4)
colormap gray;
subplot(2,2,1)
imagesc(gb)
title('Part B - Manually Created Sinogram');
xlabel('l');
ylabel('theta (0.5 degrees)');
subplot(2,2,2)
imagesc(ellipse_rad)
title('Part B - radon Function Created Sinogram');
xlabel('l');
ylabel('theta (0.5 degrees)');
subplot(2,2,3)
imagesc(ellipse_back_fil)
title({'Part B - iradon Function Created Image','Un-filtered'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,2,4)
imagesc(ellipse_back)
title({'Part B - iradon Function Created Image','Un-filtered'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');