%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Image Transformations - Resolution
% Filename: Tipton_EGR532_Lab1.m
% Author: Natalie Tipton
% Date: 1/22/18
% Instructor: Dr. Rhodes
% Description: This script has three parts. In the first part, the 
%   quantization level of an image is decreased from 8 to 1, decreasing
%   the level of distinction between intensities. In the second part,
%   the spatial resolution (dpi) is cut in half 5 times to. The final 
%   uses three different interpolation methods to increase the spatial
%   resolution of an image from 300 to 900 dpi.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part A %%%%%%%%%%

skull = imread('CTSkull.tif.tif');  %read in skull image

figure(1);   %create new figure
imagesc(skull); %plot image
title("CTSkull.tif");   %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar

%decreases bit size of images from 8bit by consolidating pixel intensities
%into a smaller range than 0-255(0-127, 0-63, etc)
skull7 = floor(skull ./(256/127));  
skull6 = floor(skull ./ (256/63));
skull5 = floor(skull ./ (256/31));
skull4 = floor(skull ./ (256/15));
skull3 = floor(skull ./ (256/7));
skull2 = floor(skull ./ (256/3));
skull1 = floor(skull ./ 256);

figure(2);   %create new figure
subplot(2,4,1);  %first subplot in 2 rows of 4 images
imagesc(skull7);    %plot 7 bit image
title("7 bit"); %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar
subplot(2,4,2)  %second subplot in 2 rows of 4 images
imagesc(skull6) %plot 6 bit image
title("6 bit"); %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar
subplot(2,4,3)  %third subplot in 2 rows of 4 images
imagesc(skull5) %plot 5 bit image
title("5 bit"); %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar
subplot(2,4,4)  %fourth subplot in 2 rows of 4 images
imagesc(skull4) %plot 4 bit image
title("4 bit"); %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add color bar
subplot(2,4,5) %fifth subplot in 2 rows of 4 images
imagesc(skull3) %plot 3 bit image
title("3 bit"); %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar
subplot(2,4,6)  %sixth subplot in 2 rows of 4 images
imagesc(skull2) %plot 2 bit image
title("2 bit"); %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar
subplot(2,4,7)  %seventh subplot in 2 rows of 4 images
imagesc(skull1) %plot 1 bit image
title("1 bit"); %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar


%%%%%%%% Part B %%%%%%%%%%

chronometer = imread('Chronometer.tif.tif');    %read in image

figure(3)   %create new figure
imagesc(chronometer);   %plot image
title("Chronometer.tif");   %lable plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add color bar

%the following lines creates an image exactly the same as the 
%previous image. Then, every other row and column are omitted
%from the image to cut the spatial resolution in half
chron600 = chronometer; 
chron600(2:2:end,:) = [];
chron600(:,2:2:end) = [];

chron300 = chron600;
chron300(2:2:end,:) = [];
chron300(:,2:2:end) = [];

chron150 = chron300;
chron150(2:2:end,:) = [];
chron150(:,2:2:end) = [];

chron72 = chron150;
chron72(2:2:end,:) = [];
chron72(:,2:2:end) = [];

%The following lines create a new figure and plots each of the images
%created above with decreasing spatial resolution onto 5 subplots.
%Those images are labeled and a color bar is added to each.
figure(4)  
subplot(2,3,1) 
imagesc(chronometer) 
title("1250 dpi");  
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;  
subplot(2,3,2)
imagesc(chron600)   
title("625 dpi");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;
subplot(2,3,3)
imagesc(chron300);
title("313 dpi");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;
subplot(2,3,4)
imagesc(chron150)
title("156 dpi");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;
subplot(2,3,5)
imagesc(chron72);
title("78 dpi");
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;

imwrite(chron300, 'Chronometer300.tif');    %write 300dpi img to new file


%%%%%%%% Part C %%%%%%%%%%

chronometer300 = imread('Chronometer300.tif');  %read in saved image

%%%%%%%% Nearest Neighbor %%%%%%%%%%

scale = [3, 3]; %scaling factor from 300 dpi to 900 dpi
[row300, col300] = size(chronometer300);    %Finds size of 300dpi image
size900 = scale.*[row300,col300];   %Finds new size for 900 dpi image

%Create index for new image calculation
%Use 0.5 to represent the center of the pixel
rowIndex = round(((1:size900(1))-0.5)./scale(1)+0.5);
colIndex = round(((1:size900(2))-0.5)./scale(2)+0.5);

nearestNeighbor = chron300(rowIndex,colIndex,:); %obtain 900 dpi image through indexing

figure(5)   %create new figure
imagesc(nearestNeighbor);   %plot interpolated image
title("Nearest Neighbor Method");   %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar

%%%%%%%% Bilinear %%%%%%%%%%

scalingFactor = 3;  %declares scaling factor of 3 to get from 300dpi to 900 dpi
doubleChron300 = im2double(chronometer300); %converts image to double format
for i = 1:row300    %iterate through the rows of 300 dpi image
    for j = 1:col300    %iterate through the columns of 300 dpi image
        
        %create new, enlarged matrix
        chron_enlarge(1+(i-1)*scalingFactor, 1+(j-1)*scalingFactor,:) = doubleChron300(i,j,:); 
    end     %end for loops
end

for i=1:1+(row300-2)*scalingFactor     %iterate through the rows in the enlarged matrix
    for j=1:1+(col300-2)*scalingFactor %iterate through the columns in the enlarged matrix
    
       if((rem(i-1,scalingFactor)==0) && (rem(j-1,scalingFactor)==0)) %if in the first row/column iterate to next one
           
       else     %if not in the first row/column calculate scaling for rows and columns
           scale0=chron_enlarge(ceil(i/scalingFactor)*scalingFactor-scalingFactor+1,ceil(j/scalingFactor)*scalingFactor-scalingFactor+1,:); 
           scale1=chron_enlarge(ceil(i/scalingFactor)*scalingFactor-scalingFactor+1,ceil(j/scalingFactor)*scalingFactor-scalingFactor+1+scalingFactor,:);
           scale2=chron_enlarge(ceil(i/scalingFactor)*scalingFactor-scalingFactor+1+scalingFactor,ceil(j/scalingFactor)*scalingFactor-scalingFactor+1,:);
           scale3=chron_enlarge(ceil(i/scalingFactor)*scalingFactor-scalingFactor+1+scalingFactor,ceil(j/scalingFactor)*scalingFactor-scalingFactor+1+scalingFactor,:);
           
           x=rem(i-1,scalingFactor); %find coordinates of pixel being calculated for
           y=rem(j-1,scalingFactor);  
          
           dx=x/scalingFactor; %Find the nearest 4 existing pixels to new pixel
           dy=y/scalingFactor;
          
           comp1=scale0;    %calculate for components of the equation for bilinear interpolation
           comp2=scale2-scale0;
           comp3=scale1-scale0;
           comp4=scale0-scale2-scale1+scale3;           
           chron_enlarge(i,j,:)=comp1+comp2*dx+comp3*dy+comp4*dx*dy; %final equation of bilinear interpolation
       end
    end
end

bilinear = im2uint8(chron_enlarge);

figure(6);  %create new figure
imagesc(bilinear); %plot enlarged image
title("Bilinear Interpolation Method");  %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar
%%%%%%%% Bicubic %%%%%%%%%%

bicubic = imresize(chronometer300, [2769, 2109]);   %by default, imresize uses bicubic interpolation

figure(7)   %create new figure
imagesc(bicubic);   %plot image
title("Bicubic Interpolation Method");  %label plot
xlabel("X (spatial units)");
ylabel("Y (spatial units)");
colorbar;   %add colorbar






