%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Image Transformations - Image Manipulation
% Filename: Tipton_EGR532_Lab3PartC.m
% Author: Natalie Tipton
% Date: 2/14/19
% Instructor: Dr. Rhodes
% Description:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Part C %%%%%%%%%%

%read in image and find size
letterT = imread('Letter_T.tif');
[rows,cols] = size(letterT);

theta = 30;
rotateT = zeros(rows,cols);

%complete matrix calculations for rotations
for v = 1:rows
    for w = 1:cols
        
        x = ceil(abs((v * cosd(theta)) + (w * sind(theta))));
        y = ceil(abs((v * cosd(theta)) - (w  * sind(theta))));
        
        rotateT(x,y) = letterT(v,w);
    end
end

%find size of rotated image 
[rows_rot, cols_rot] = size(rotateT);
rotScale = zeros(rows_rot, cols_rot);

%complete matrix calculations for scaling
for v = 1:rows_rot
    for w = 1:cols_rot
        
        x = v;
        y = round(1.25*w);
        
        rotScale(x,y) = rotateT(v,w);
    end
end

%plot original image and matrix calc rotated/scaled image
figure(1)
colormap gray;
subplot(1,3,1)
imagesc(letterT);
title('Original Letter T');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(1,3,2)
imagesc(rotScale);
title('Rotated 30 deg and scaled 125%');
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

%use matlab functions to rotate and scale image
mlabrot = imrotate(letterT, 30, 'bicubic');
mlabrotScale = imresize(mlabrot, 1.25, 'bicubic');

%plot image rotated and scaled with matlab functions
subplot(1,3,3)
imagesc(mlabrot);
title({'Rotated 30 degrees and scaled 125%','using bicubic interpolation'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');

%Perform vertical shear using matrix multiplication
for v = 1:rows
    for w = 1:cols
        x_hor = 3*w + v;
        y_hor = w;
        
        shear_horiz(x_hor, y_hor) = letterT(v,w);
    end
end

%perform horizontal shear using matrix multiplication
for v = 1:rows
    for w = 1:cols
        x_ver = v;
        y_ver = 4*v + w;
        
        shear_vertic(x_ver, y_ver) = letterT(v,w);
    end
end

%perform vertical and horizontal shear using matrix mult
for v = 1:rows
    for w = 1:cols
        x_both = 2*w + v;
        y_both = 4*v + w;
        
        shear_both(x_both, y_both) = letterT(v,w);
    end
end

%perform vertical shear with matlab function
ver = maketform('affine', [1 0 0; 3 1 0; 0 0 1]);
mat_shearVertic = imtransform(letterT, ver, 'bicubic');

%perform horizontal shear with matlab function
hor = maketform('affine', [1 4 0; 0 1 0; 0 0 1]);
mat_shearHoriz = imtransform(letterT, hor, 'bicubic');

%perform vertical and horizontal shear with matlab function
both = maketform('affine', [1 4 0; 3 1 0; 0 0 1]);
mat_shearBoth = imtransform(letterT, both, 'bicubic');

%plot matrix multiplication affine transformations
figure(2)
colormap gray;
subplot(2,3,1)
imagesc(shear_vertic);
title({'Vertical Shear', 'Sv = 3'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,2)
imagesc(shear_horiz);
title({'Horizontal Shear', 'Sh = 4'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,3)
imagesc(shear_both);
title({'Horizontal and Vertical Shear', 'Sh = 4, Sv = 3'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,4)

%plot matlab function affine transformations
imagesc(mat_shearVertic);
title({'imtransform','Vertical Shear', 'Sv = 3'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,5)
imagesc(mat_shearHoriz)
title({'imtransform','Horizontal Shear', 'Sh = 4'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');
subplot(2,3,6)
imagesc(mat_shearBoth)
title({'imtransform','Horizontal and Vertical Shear', 'Sh = 4, Sv = 3'});
xlabel('X (spatial units)');
ylabel('Y (spatial units)');