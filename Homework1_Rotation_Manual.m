%==========================================================
% SIMPLE IMAGE ROTATION WITH INTERPOLATION METHODS
%==========================================================
clear; close all; clc;

%----------------------------------------------------------
% STEP 1: Load Image
%----------------------------------------------------------
img = imread('test.jpg');   % Input image (color supported)
img = double(img);          % Convert to double for calculations

[rows, cols, ch] = size(img);   % Get image dimensions
angle = 300;                     % Rotation angle (degrees)
theta = deg2rad(angle);         % Convert to radians

% Initialize output images for each method
result_nearest   = zeros(rows, cols, ch);
result_bilinear  = zeros(rows, cols, ch);
result_bicubic   = zeros(rows, cols, ch);

% Center coordinates of the image
cx = cols / 2;
cy = rows / 2;

fprintf('Starting rotation with interpolation methods...\n');

%==========================================================
% METHOD 1: NEAREST NEIGHBOR INTERPOLATION
%==========================================================
fprintf('Method 1: Nearest Neighbor\n');

for c = 1:ch
    for i = 1:rows
        for j = 1:cols
            % Backward mapping: find original coordinates
            old_x = (j-cx)*cos(theta) + (i-cy)*sin(theta) + cx;
            old_y = -(j-cx)*sin(theta) + (i-cy)*cos(theta) + cy;

            % Nearest neighbor (rounding)
            old_x = round(old_x);
            old_y = round(old_y);

            % Assign pixel if inside bounds
            if old_x >= 1 && old_x <= cols && old_y >= 1 && old_y <= rows
                result_nearest(i,j,c) = img(old_y, old_x, c);
            end
        end
    end
end

%==========================================================
% METHOD 2: BILINEAR INTERPOLATION
%==========================================================
fprintf('Method 2: Bilinear\n');

for c = 1:ch
    for i = 1:rows
        for j = 1:cols
            % Backward mapping
            old_x = (j-cx)*cos(theta) + (i-cy)*sin(theta) + cx;
            old_y = -(j-cx)*sin(theta) + (i-cy)*cos(theta) + cy;

            % Nearest integer coordinates around point
            x1 = floor(old_x); x2 = x1 + 1;
            y1 = floor(old_y); y2 = y1 + 1;

            % Check bounds
            if x1 >= 1 && x2 <= cols && y1 >= 1 && y2 <= rows
                % Distances
                dx = old_x - x1;
                dy = old_y - y1;

                % Four neighboring pixels
                p1 = img(y1, x1, c);  % top-left
                p2 = img(y1, x2, c);  % top-right
                p3 = img(y2, x1, c);  % bottom-left
                p4 = img(y2, x2, c);  % bottom-right

                % Interpolation
                top    = p1*(1-dx) + p2*dx;
                bottom = p3*(1-dx) + p4*dx;
                result_bilinear(i,j,c) = top*(1-dy) + bottom*dy;
            end
        end
    end
end

%==========================================================
% METHOD 3: SIMPLE BICUBIC (APPROXIMATION)
%==========================================================
fprintf('Method 3: Bicubic (Simplified)\n');

for c = 1:ch
    for i = 1:rows
        for j = 1:cols
            % Backward mapping
            old_x = (j-cx)*cos(theta) + (i-cy)*sin(theta) + cx;
            old_y = -(j-cx)*sin(theta) + (i-cy)*cos(theta) + cy;

            % Center pixel
            x_center = round(old_x);
            y_center = round(old_y);

            % Take 4x4 neighborhood (simplified average)
            if x_center >= 2 && x_center <= cols-1 && ...
               y_center >= 2 && y_center <= rows-1
                total = 0; count = 0;
                for dy = -1:2
                    for dx = -1:2
                        xx = x_center + dx;
                        yy = y_center + dy;
                        if xx >= 1 && xx <= cols && yy >= 1 && yy <= rows
                            total = total + img(yy, xx, c);
                            count = count + 1;
                        end
                    end
                end
                if count > 0
                    result_bicubic(i,j,c) = total / count;
                end
            end
        end
    end
end

%==========================================================
% STEP 4: Convert Results for Display
%==========================================================
result_nearest  = uint8(result_nearest);
result_bilinear = uint8(result_bilinear);
result_bicubic  = uint8(result_bicubic);

%==========================================================
% STEP 5: Display Results
%==========================================================
figure;
subplot(2,2,1); imshow(uint8(img));            title('Original Image');
subplot(2,2,2); imshow(result_nearest);        title('Nearest Neighbor');
subplot(2,2,3); imshow(result_bilinear);       title('Bilinear');
subplot(2,2,4); imshow(result_bicubic);        title('Bicubic (Simple)');

fprintf('Rotation completed!\n');
