# Brain MRI Tumor Segmentation using MATLAB

This project demonstrates a beginner-friendly image processing pipeline to automatically segment and highlight a brain tumor from a 2D MRI scan using MATLAB. It introduces foundational skills in biomedical imaging and region-of-interest (ROI) extraction that are commonly used in healthcare AI, radiology, and medical research.

---

## 🎯 Project Objective

To segment the tumor region from a grayscale brain MRI image using thresholding and morphological operations. The output is a clear overlay that visually distinguishes the tumor for further analysis or documentation.

---

## 🧠 Why This Matters in Biomedical Engineering

Segmentation is a critical step in many biomedical applications:
- 🎯 Identifying tumor size for surgical planning
- 🧪 Isolating regions for AI model training
- 📊 Calculating tissue area in clinical research
- 🧠 Supporting diagnosis by guiding radiologists toward key regions

This project simulates real-world preprocessing used in diagnostic imaging, clinical support tools, and BME research.

---

## 🛠️ Tools Used

- MATLAB Online
- Image Processing Toolbox

Key functions: `imadjust`, `graythresh`, `imbinarize`, `imopen`, `imfill`, `bwlabel`, `regionprops`, `labeloverlay`, `imwrite`

---

## 🔍 Code Summary

```matlab
gray = imread('tumor_mri.png');                    % Load MRI image
enhanced = imadjust(gray);                         % Enhance contrast
bw = imbinarize(enhanced, graythresh(enhanced));   % Segment bright tumor area
bw_clean = imopen(bw, strel('disk', 3));           % Remove small noise
bw_clean = imfill(bw_clean, 'holes');              % Fill gaps
bw_label = bwlabel(bw_clean);                      % Label connected regions
stats = regionprops(bw_label, 'Area');             
[~, idx] = max([stats.Area]);                      % Keep only largest region
bw_tumor = ismember(bw_label, idx);                
overlay = labeloverlay(gray, bw_tumor);            % Overlay tumor on original
imshow(overlay); imwrite(overlay, 'tumor_segmented_output.png');
