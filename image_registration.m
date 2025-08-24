% =============================
% Image Registration Example
% =============================
clear; close all; clc;

% Load reference and input  3


refImg = imread('test1.jpg');   % Reference image
inputImg = imread('test2.jpg');     % Input image to register

% Convert to grayscale if needed
if size(refImg,3)==3
    refGray = rgb2gray(refImg);
else
    refGray = refImg;
end
if size(inputImg,3)==3
    inputGray = rgb2gray(inputImg);
else
    inputGray = inputImg;
end

% Detect SURF features
pointsRef = detectSURFFeatures(refGray);
pointsInput = detectSURFFeatures(inputGray);

% Extract features
[featuresRef, validPointsRef] = extractFeatures(refGray, pointsRef);
[featuresInput, validPointsInput] = extractFeatures(inputGray, pointsInput);

% Match features
indexPairs = matchFeatures(featuresRef, featuresInput);
matchedRef = validPointsRef(indexPairs(:,1));
matchedInput = validPointsInput(indexPairs(:,2));

% Estimate transform
[tform, inlierRef, inlierInput] = estimateGeometricTransform(...
    matchedInput, matchedRef, 'affine');

% Apply transform to input image
outputView = imref2d(size(refGray));
registered = imwarp(inputImg, tform, 'OutputView', outputView);

% Show results
figure;
subplot(1,3,1); imshow(refImg); title('Reference Image');
subplot(1,3,2); imshow(inputImg); title('Input Image');
subplot(1,3,3); imshow(registered); title('Registered Image');

% Optionally, show matched points
figure;
showMatchedFeatures(refGray, inputGray, inlierRef, inlierInput);
title('Matched Inlier Points');
