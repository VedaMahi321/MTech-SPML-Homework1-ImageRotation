% Image Rotation using Built-in MATLAB Functions
clear all; close all; clc;

% Read the image
img = imread('test.jpg');

% Rotation angle
angle = 300;

% Apply rotations using built-in interpolation methods
rot_nearest = imrotate(img, angle, 'nearest', 'crop');
rot_bilinear = imrotate(img, angle, 'bilinear', 'crop');
rot_bicubic = imrotate(img, angle, 'bicubic', 'crop');

% Display results
figure('Name', 'Built-in Function Results');
subplot(2,2,1); imshow(img); title('Original Image');
subplot(2,2,2); imshow(rot_nearest); title('Nearest Neighbor');
subplot(2,2,3); imshow(rot_bilinear); title('Bilinear');
subplot(2,2,4); imshow(rot_bicubic); title('Bicubic');

fprintf('Built-in rotation completed successfully!\n');
