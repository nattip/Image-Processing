%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Pseudocolor Image Processing
% Filename: Tipton_EGR532_Lab6PartA.m
% Author: Natalie Tipton
% Date: 3/14/19
% Instructor: Dr. Rhodes
% Description: This xcript converts RGB planes of an image into CMY
%   and HSI planes. It also performs intesnity slicing to add pseudo
%   color to a black and white image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A %%%%%%%%%%

%read in image and find size
strawberries = imread('Strawberries.tif');
[row,col] = size(strawberries(:,:,1));
strawberries = im2double(strawberries);

%normalize RGB values
red_norm = mat2gray(strawberries(:,:,1));
green_norm = mat2gray(strawberries(:,:,2));
blue_norm = mat2gray(strawberries(:,:,3));

%convert to CMY using equations given
magenta = red_norm + blue_norm;
cyan = blue_norm + green_norm;
yellow = green_norm + red_norm;

%normalize CMY values
cyan_norm = mat2gray(cyan(:,:));
magenta_norm = mat2gray(magenta(:,:));
yellow_norm = mat2gray(yellow(:,:));

%combine normalized planes into one CMY image
cmy_norm(:,:,1) = cyan_norm;
cmy_norm(:,:,2) = magenta_norm;
cmy_norm(:,:,3) = yellow_norm;

%cycle through every pixel in image
for x = 1:row
    for y = 1:col
        %find theta using given equation
        theta(x,y) = acosd((0.5 * (red_norm(x,y)-green_norm(x,y)+red_norm(x,y)-blue_norm(x,y)))/...
            (sqrt((red_norm(x,y)-green_norm(x,y))*(red_norm(x,y)-green_norm(x,y))+(red_norm(x,y)-blue_norm(x,y))*(green_norm(x,y)-blue_norm(x,y)))));
      
        %find hue based on given conditions
        if(blue_norm(x,y) <= green_norm(x,y))
            h(x,y) = theta(x,y);
        else
            h(x,y) = 360 - theta(x,y);
        end
        
        %find saturation values using given equation
        if red_norm(x,y) < green_norm(x,y) && red_norm(x,y) < blue_norm(x,y)
            s(x,y) = 1 - (3/(red_norm(x,y) + green_norm(x,y) + blue_norm(x,y))*red_norm(x,y));
        elseif green_norm(x,y) < red_norm(x,y) && green_norm(x,y) < blue_norm(x,y)
            s(x,y) = 1 - (3/(red_norm(x,y) + green_norm(x,y) + blue_norm(x,y))*green_norm(x,y));
        elseif blue_norm(x,y) < green_norm(x,y) && blue_norm(x,y) < red_norm(x,y)
            s(x,y) = 1 - (3/(red_norm(x,y) + green_norm(x,y) + blue_norm(x,y))*blue_norm(x,y));
        end
        
        %find intensity using given equation
        i(x,y) = (1/3) * (red_norm(x,y) + green_norm(x,y) + blue_norm(x,y));

    end
end

%normalize HSI planes
h_norm = mat2gray(h(:,:));
s_norm = mat2gray(s(:,:));
i_norm = mat2gray(i(:,:));

%combine normalized HSI planes to get overall HSI image
hsi_total(:,:,1) = h_norm;
hsi_total(:,:,2) = s_norm;
hsi_total(:,:,3) = i_norm;

%plot original image with the RGB images displayed separately in subplots
figure(1)
subplot(2,2,1);
imshow(strawberries);
title('Original Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2);
imshow(strawberries(:,:,1));
title('Red Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3);
imshow(strawberries(:,:,2));
title('Green Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4);
imshow(strawberries(:,:,3));
title('Blue Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%in new figure plot the CMY images separately in subplots
figure(2)
subplot(2,2,1)
imshow(cmy_norm)
title('CMY Version of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
imshow(cyan_norm)
title('Cyan Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imshow(magenta_norm)
title('Magenta Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4)
imshow(yellow_norm)
title('Yellow Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;

%in new figure plot HSI images separately in subplots
figure(3)
subplot(2,2,1)
imshow(hsi_total)
title('HSI Version of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,2)
imshow(h_norm)
title('Hue Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,3)
imshow(s_norm)
title('Saturation Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
subplot(2,2,4)
imshow(i_norm)
title('Intensity Portion of Strawberries');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
colorbar;
