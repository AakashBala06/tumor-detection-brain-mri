% segment_tumor.m
% Improved Brain Tumor Segmentation from MRI

clc; clear; close all;

% Step 1: Load grayscale image
gray = imread('tumor_mri.png');

% Step 2: Enhance contrast
enhanced = imadjust(gray);

% Step 3: Thresholding to segment brighter (tumor) area
level = graythresh(enhanced);
bw = imbinarize(enhanced, level);

% Step 4: Morphological cleaning
bw_clean = imopen(bw, strel('disk', 3));  % Remove small noise
bw_clean = imfill(bw_clean, 'holes');     % Fill holes

% Step 5: Keep only the largest connected component (likely the tumor)
bw_label = bwlabel(bw_clean);                     % Label connected regions
stats = regionprops(bw_label, 'Area');            % Measure area
[~, idx] = max([stats.Area]);                     % Find largest region
bw_tumor = ismember(bw_label, idx);               % Keep only the largest

% Step 6: Overlay the tumor mask on the original MRI
overlay = labeloverlay(gray, bw_tumor, 'Transparency', 0.5);

% Step 7: Display and save the result
imshow(overlay);
imwrite(overlay, 'tumor_segmented_output.png');
