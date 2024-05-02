%% Step1 : Take 3 sets of 2 photographs to be stitched together to create a panorama
S1_m1_origin = imread('S1-im1-origin.png');
S1_m2_origin = imread('S1-im2-origin.png');
S1_im1 = rgb2gray(im2double(S1_m1_origin));
S1_im2 = rgb2gray(im2double(S1_m2_origin));
imshow([S1_im1 S1_im2]);
imwrite(S1_im1,'S1-im1.png');
imwrite(S1_im2,'S1-im2.png');

S2_m1_origin = imread('S2-im1-origin.png');
S2_m2_origin = imread('S2-im2-origin.png');
S2_im1 = rgb2gray(im2double(S2_m1_origin));
S2_im2 = rgb2gray(im2double(S2_m2_origin));
imshow([S2_im1 S2_im2]);
imwrite(S2_im1,'S2-im1.png');
imwrite(S2_im2,'S2-im2.png');

S3_m1_origin = imread('S3-im1-origin.png');
S3_m2_origin = imread('S3-im2-origin.png');
S3_im1 = rgb2gray(im2double(S3_m1_origin));
S3_im2 = rgb2gray(im2double(S3_m2_origin));
imshow([S3_im1 S3_im2]);
imwrite(S3_im1,'S3-im1.png');
imwrite(S3_im2,'S3-im2.png');

S4_m1_origin = imread('S4-im1-origin.png');
S4_m2_origin = imread('S4-im2-origin.png');
S4_im1 = rgb2gray(im2double(S4_m1_origin));
S4_im2 = rgb2gray(im2double(S4_m2_origin));
imwrite(S4_im1,'S4-im1.png');
imwrite(S4_im2,'S4-im2.png');


%% Step2: FAST feature detector
% Get corners by self define function my_fast_detector and record the time taken
tic;
fast_corners_S1_im1 = my_fast_detector(S1_im1, 0.1); 
fast_corners_S1_im2 = my_fast_detector(S1_im2, 0.1);
fast_corners_S2_im1 = my_fast_detector(S2_im1, 0.1);
fast_corners_S2_im2 = my_fast_detector(S2_im2, 0.1); 
fast_corners_S3_im1 = my_fast_detector(S3_im1, 0.1);
fast_corners_S3_im2 = my_fast_detector(S3_im2, 0.1); 
fast_corners_S4_im1 = my_fast_detector(S4_im1, 0.1);
fast_corners_S4_im2 = my_fast_detector(S4_im2, 0.1); 
fast = toc / 4;
fast;

[fast_cornerRows_S1_m1, fast_cornerCols_S1_m1] = find(fast_corners_S1_im1);
[fast_cornerRows_S1_m2, fast_cornerCols_S1_m2] = find(fast_corners_S1_im2);
S1_fast = S1_im1;
S1_fast(fast_corners_S1_im1 > 0) = 1; % Draw the feature points on the picture
imshow(S1_fast);
imwrite(S1_fast, 'S1-fast.png'); % Save the result picture

[fast_cornerRows_S2_m1, fast_cornerCols_S2_m1] = find(fast_corners_S2_im1);
[fast_cornerRows_S2_m2, fast_cornerCols_S2_m2] = find(fast_corners_S2_im2);
S2_fast = S2_im1;
S2_fast(fast_corners_S2_im1 > 0) = 1; % Draw the feature points on the picture
imshow(S2_fast);
imwrite(S2_fast, 'S2-fast.png'); % Save the result picture

[fast_cornerRows_S3_m1, fast_cornerCols_S3_m1] = find(fast_corners_S3_im1);
[fast_cornerRows_S3_m2, fast_cornerCols_S3_m2] = find(fast_corners_S3_im2);
S3_fast = S3_im1;
S3_fast(fast_corners_S3_im1 > 0) = 1; % Draw the feature points on the picture
imshow(S3_fast);
imwrite(S3_fast, 'S3-fast.png'); % Save the result picture

[fast_cornerRows_S4_m1, fast_cornerCols_S4_m1] = find(fast_corners_S4_im1);
[fast_cornerRows_S4_m2, fast_cornerCols_S4_m2] = find(fast_corners_S4_im2);
S4_fast = S4_im1;
S4_fast(fast_corners_S4_im1 > 0) = 1; % Draw the feature points on the picture
imshow(S4_fast);
imwrite(S4_fast, 'S4-fast.png'); % Save the result picture

%% Step3: Robust FAST using Harris Cornerness metric
tic;
fastR_corners_S1_im1 = HarrisCornerness(fast_corners_S1_im1, S1_im1, 0.0001); % Using harris cornerness metric to eliminate the weak FAST points.
fastR_corners_S1_im2 = HarrisCornerness(fast_corners_S1_im2, S1_im2, 0.0001); 
fastR_corners_S2_im1 = HarrisCornerness(fast_corners_S2_im1, S2_im1, 0.0001);
fastR_corners_S2_im2 = HarrisCornerness(fast_corners_S2_im2, S2_im2, 0.0001); 
fastR_corners_S3_im1 = HarrisCornerness(fast_corners_S3_im1, S3_im1, 0.0001);
fastR_corners_S3_im2 = HarrisCornerness(fast_corners_S3_im2, S3_im2, 0.0001); 
fastR_corners_S4_im1 = HarrisCornerness(fast_corners_S4_im1, S4_im1, 0.0001);
fastR_corners_S4_im2 = HarrisCornerness(fast_corners_S4_im2, S4_im2, 0.0001); 
fastR = toc / 4;
fastR;

[fastR_cornerRows_S1_m1, fastR_cornerCols_S1_m1] = find(fastR_corners_S1_im1);
[fastR_cornerRows_S1_m2, fastR_cornerCols_S1_m2] = find(fastR_corners_S1_im2);
[fastR_cornerRows_S2_m1, fastR_cornerCols_S2_m1] = find(fastR_corners_S2_im1);
[fastR_cornerRows_S2_m2, fastR_cornerCols_S2_m2] = find(fastR_corners_S2_im2);
[fastR_cornerRows_S3_m1, fastR_cornerCols_S3_m1] = find(fastR_corners_S3_im1);
[fastR_cornerRows_S3_m2, fastR_cornerCols_S3_m2] = find(fastR_corners_S3_im2);
[fastR_cornerRows_S4_m1, fastR_cornerCols_S4_m1] = find(fastR_corners_S4_im1);
[fastR_cornerRows_S4_m2, fastR_cornerCols_S4_m2] = find(fastR_corners_S4_im2);

S1_fastR = S1_im1;
S1_fastR(fastR_corners_S1_im1 > 0) = 1; % Draw the feature points on the picture
imshow(S1_fastR);
imwrite(S1_fastR, 'S1-fastR.png');

S2_fastR = S2_im1;
S2_fastR(fastR_corners_S2_im1 > 0) = 1; % Draw the feature points on the picture
imshow(S2_fastR);
imwrite(S2_fastR, 'S2-fastR.png');

S3_fastR = S3_im1;
S3_fastR(fastR_corners_S3_im1 > 0) = 1; % Draw the feature points on the picture
imshow(S3_fastR);
imwrite(S3_fastR, 'S3-fastR.png');

S4_fastR = S4_im1;
S4_fastR(fastR_corners_S4_im1 > 0) = 1; % Draw the feature points on the picture
imshow(S4_fastR);
imwrite(S4_fastR, 'S4-fastR.png');

%% Step4: Point description and matching

% Get the coordinates of feature points at first
fast_pointsMatrix_SURF_S1_m1 = [fast_cornerCols_S1_m1, fast_cornerRows_S1_m1];
fast_pointsMatrix_SURF_S1_m2 = [fast_cornerCols_S1_m2, fast_cornerRows_S1_m2];
fastR_pointsMatrix_SURF_S1_m1 = [fastR_cornerCols_S1_m1, fastR_cornerRows_S1_m1];
fastR_pointsMatrix_SURF_S1_m2 = [fastR_cornerCols_S1_m2, fastR_cornerRows_S1_m2];

fast_pointsMatrix_SURF_S2_m1 = [fast_cornerCols_S2_m1, fast_cornerRows_S2_m1];
fast_pointsMatrix_SURF_S2_m2 = [fast_cornerCols_S2_m2, fast_cornerRows_S2_m2];
fastR_pointsMatrix_SURF_S2_m1 = [fastR_cornerCols_S2_m1, fastR_cornerRows_S2_m1];
fastR_pointsMatrix_SURF_S2_m2 = [fastR_cornerCols_S2_m2, fastR_cornerRows_S2_m2];

fast_pointsMatrix_SURF_S3_m1 = [fast_cornerCols_S3_m1, fast_cornerRows_S3_m1];
fast_pointsMatrix_SURF_S3_m2 = [fast_cornerCols_S3_m2, fast_cornerRows_S3_m2];
fastR_pointsMatrix_SURF_S3_m1 = [fastR_cornerCols_S3_m1, fastR_cornerRows_S3_m1];
fastR_pointsMatrix_SURF_S3_m2 = [fastR_cornerCols_S3_m2, fastR_cornerRows_S3_m2];

fast_pointsMatrix_SURF_S4_m1 = [fast_cornerCols_S4_m1, fast_cornerRows_S4_m1];
fast_pointsMatrix_SURF_S4_m2 = [fast_cornerCols_S4_m2, fast_cornerRows_S4_m2];
fastR_pointsMatrix_SURF_S4_m1 = [fastR_cornerCols_S4_m1, fastR_cornerRows_S4_m1];
fastR_pointsMatrix_SURF_S4_m2 = [fastR_cornerCols_S4_m2, fastR_cornerRows_S4_m2];

% Using extractFeatures function to extract the features and valid points
% features is a matrix in which each row represents a descriptor of a feature point.
% I use 'SURF' as the descriptor.
[fast_features_S1_m1, fast_validPoints_S1_m1] = extractFeatures(S1_im1, fast_pointsMatrix_SURF_S1_m1, 'Method', 'SURF');
[fast_features_S1_m2, fast_validPoints_S1_m2] = extractFeatures(S1_im2, fast_pointsMatrix_SURF_S1_m2, 'Method', 'SURF');
[fastR_features_S1_m1, fastR_validPoints_S1_m1] = extractFeatures(S1_im1, fastR_pointsMatrix_SURF_S1_m1, 'Method', 'SURF');
[fastR_features_S1_m2, fastR_validPoints_S1_m2] = extractFeatures(S1_im2, fastR_pointsMatrix_SURF_S1_m2, 'Method', 'SURF');

[fast_features_S2_m1, fast_validPoints_S2_m1] = extractFeatures(S2_im1, fast_pointsMatrix_SURF_S2_m1, 'Method', 'SURF');
[fast_features_S2_m2, fast_validPoints_S2_m2] = extractFeatures(S2_im2, fast_pointsMatrix_SURF_S2_m2, 'Method', 'SURF');
[fastR_features_S2_m1, fastR_validPoints_S2_m1] = extractFeatures(S2_im1, fastR_pointsMatrix_SURF_S2_m1, 'Method', 'SURF');
[fastR_features_S2_m2, fastR_validPoints_S2_m2] = extractFeatures(S2_im2, fastR_pointsMatrix_SURF_S2_m2, 'Method', 'SURF');

[fast_features_S3_m1, fast_validPoints_S3_m1] = extractFeatures(S3_im1, fast_pointsMatrix_SURF_S3_m1, 'Method', 'SURF');
[fast_features_S3_m2, fast_validPoints_S3_m2] = extractFeatures(S3_im2, fast_pointsMatrix_SURF_S3_m2, 'Method', 'SURF');
[fastR_features_S3_m1, fastR_validPoints_S3_m1] = extractFeatures(S3_im1, fastR_pointsMatrix_SURF_S3_m1, 'Method', 'SURF');
[fastR_features_S3_m2, fastR_validPoints_S3_m2] = extractFeatures(S3_im2, fastR_pointsMatrix_SURF_S3_m2, 'Method', 'SURF');

[fast_features_S4_m1, fast_validPoints_S4_m1] = extractFeatures(S4_im1, fast_pointsMatrix_SURF_S4_m1, 'Method', 'SURF');
[fast_features_S4_m2, fast_validPoints_S4_m2] = extractFeatures(S4_im2, fast_pointsMatrix_SURF_S4_m2, 'Method', 'SURF');
[fastR_features_S4_m1, fastR_validPoints_S4_m1] = extractFeatures(S4_im1, fastR_pointsMatrix_SURF_S4_m1, 'Method', 'SURF');
[fastR_features_S4_m2, fastR_validPoints_S4_m2] = extractFeatures(S4_im2, fastR_pointsMatrix_SURF_S4_m2, 'Method', 'SURF');

% Use the matchFeatures function to match the feature points of two images.
[fast_indexPairs_S1, fast_matchMetric_S1] = matchFeatures(fast_features_S1_m1, fast_features_S1_m2);
[fastR_indexPairs_S1, fastR_matchMetric_S1] = matchFeatures(fastR_features_S1_m1, fastR_features_S1_m2);

[fast_indexPairs_S2, fast_matchMetric_S2] = matchFeatures(fast_features_S2_m1, fast_features_S2_m2);
[fastR_indexPairs_S2, fastR_matchMetric_S2] = matchFeatures(fastR_features_S2_m1, fastR_features_S2_m2);

[fast_indexPairs_S3, fast_matchMetric_S3] = matchFeatures(fast_features_S3_m1, fast_features_S3_m2);
[fastR_indexPairs_S3, fastR_matchMetric_S3] = matchFeatures(fastR_features_S3_m1, fastR_features_S3_m2);

[fast_indexPairs_S4, fast_matchMetric_S4] = matchFeatures(fast_features_S4_m1, fast_features_S4_m2);
[fastR_indexPairs_S4, fastR_matchMetric_S4] = matchFeatures(fastR_features_S4_m1, fastR_features_S4_m2);


fast_matchedPointS1_m1 = fast_validPoints_S1_m1(fast_indexPairs_S1(:, 1), :);
fast_matchedPointS1_m2 = fast_validPoints_S1_m2(fast_indexPairs_S1(:, 2), :);
showMatchedFeatures(S1_im1, S1_im2, fast_matchedPointS1_m1, fast_matchedPointS1_m2, 'montage');
saveas(gcf, 'S1-fastMatch.png');

fast_matchedPointS2_m1 = fast_validPoints_S2_m1(fast_indexPairs_S2(:, 1), :);
fast_matchedPointS2_m2 = fast_validPoints_S2_m2(fast_indexPairs_S2(:, 2), :);
showMatchedFeatures(S2_im1, S2_im2, fast_matchedPointS2_m1, fast_matchedPointS2_m2, 'montage');
saveas(gcf, 'S2-fastMatch.png');

fast_matchedPointS3_m1 = fast_validPoints_S3_m1(fast_indexPairs_S3(:, 1), :);
fast_matchedPointS3_m2 = fast_validPoints_S3_m2(fast_indexPairs_S3(:, 2), :);
showMatchedFeatures(S3_im1, S3_im2, fast_matchedPointS3_m1, fast_matchedPointS3_m2, 'montage');
saveas(gcf, 'S3-fastMatch.png');

fast_matchedPointS4_m1 = fast_validPoints_S4_m1(fast_indexPairs_S4(:, 1), :);
fast_matchedPointS4_m2 = fast_validPoints_S4_m2(fast_indexPairs_S4(:, 2), :);
showMatchedFeatures(S4_im1, S4_im2, fast_matchedPointS4_m1, fast_matchedPointS4_m2, 'montage');
saveas(gcf, 'S4-fastMatch.png');



fastR_matchedPointS1_m1 = fastR_validPoints_S1_m1(fastR_indexPairs_S1(:, 1), :);
fastR_matchedPointS1_m2 = fastR_validPoints_S1_m2(fastR_indexPairs_S1(:, 2), :);
showMatchedFeatures(S1_im1, S1_im2, fastR_matchedPointS1_m1, fastR_matchedPointS1_m2, 'montage');
saveas(gcf, 'S1-fastRMatch.png');

fastR_matchedPointS2_m1 = fastR_validPoints_S2_m1(fastR_indexPairs_S2(:, 1), :);
fastR_matchedPointS2_m2 = fastR_validPoints_S2_m2(fastR_indexPairs_S2(:, 2), :);
showMatchedFeatures(S2_im1, S2_im2, fastR_matchedPointS2_m1, fastR_matchedPointS2_m2, 'montage');
saveas(gcf, 'S2-fastRMatch.png');

fastR_matchedPointS3_m1 = fastR_validPoints_S3_m1(fastR_indexPairs_S3(:, 1), :);
fastR_matchedPointS3_m2 = fastR_validPoints_S3_m2(fastR_indexPairs_S3(:, 2), :);
showMatchedFeatures(S3_im1, S3_im2, fastR_matchedPointS3_m1, fastR_matchedPointS3_m2, 'montage');
saveas(gcf, 'S3-fastRMatch.png');

fastR_matchedPointS4_m1 = fastR_validPoints_S4_m1(fastR_indexPairs_S4(:, 1), :);
fastR_matchedPointS4_m2 = fastR_validPoints_S4_m2(fastR_indexPairs_S4(:, 2), :);
showMatchedFeatures(S4_im1, S4_im2, fastR_matchedPointS4_m1, fastR_matchedPointS4_m2, 'montage');
saveas(gcf, 'S4-fastRMatch.png');

%% Step5: RANSAC and Panoramas
%1. Get the translation matrix
fastR_S1_tform = estgeotform2d(fastR_matchedPointS1_m2, fastR_matchedPointS1_m1, 'projective','Confidence', 99, 'MaxNumTrials', 2500, 'MaxDistance', 2);
fastR_S2_tform = estgeotform2d(fastR_matchedPointS2_m2, fastR_matchedPointS2_m1, 'projective','Confidence', 99, 'MaxNumTrials', 2500, 'MaxDistance', 2);
fastR_S3_tform = estgeotform2d(fastR_matchedPointS3_m2, fastR_matchedPointS3_m1, 'projective','Confidence', 99, 'MaxNumTrials', 2500, 'MaxDistance', 2);
fastR_S4_tform = estgeotform2d(fastR_matchedPointS4_m2, fastR_matchedPointS4_m1, 'projective','Confidence', 99, 'MaxNumTrials', 2500, 'MaxDistance', 2);


fast_S1_tform = estgeotform2d(fast_matchedPointS1_m2, fast_matchedPointS1_m1, 'projective','Confidence', 99, 'MaxNumTrials', 5000, 'MaxDistance', 4);
fast_S2_tform = estgeotform2d(fast_matchedPointS2_m2, fast_matchedPointS2_m1, 'projective','Confidence', 99, 'MaxNumTrials', 5000, 'MaxDistance', 4);
fast_S3_tform = estgeotform2d(fast_matchedPointS3_m2, fast_matchedPointS3_m1, 'projective','Confidence', 99, 'MaxNumTrials', 5000, 'MaxDistance', 4);
fast_S4_tform = estgeotform2d(fast_matchedPointS4_m2, fast_matchedPointS4_m1, 'projective','Confidence', 99, 'MaxNumTrials', 5000, 'MaxDistance', 4);



[fastR_S1_xlim, fastR_S1_ylim] = outputLimits(fastR_S1_tform, [1 size(S1_m2_origin, 2)], [1 size(S1_m2_origin, 1)]);
[fastR_S2_xlim, fastR_S2_ylim] = outputLimits(fastR_S2_tform, [1 size(S2_m2_origin, 2)], [1 size(S2_m2_origin, 1)]);
[fastR_S3_xlim, fastR_S3_ylim] = outputLimits(fastR_S3_tform, [1 size(S3_m2_origin, 2)], [1 size(S3_m2_origin, 1)]);
[fastR_S4_xlim, fastR_S4_ylim] = outputLimits(fastR_S4_tform, [1 size(S4_m2_origin, 2)], [1 size(S4_m2_origin, 1)]);

[fast_S1_xlim, fast_S1_ylim] = outputLimits(fast_S1_tform, [1 size(S1_m2_origin, 2)], [1 size(S1_m2_origin, 1)]);
[fast_S2_xlim, fast_S2_ylim] = outputLimits(fast_S2_tform, [1 size(S2_m2_origin, 2)], [1 size(S2_m2_origin, 1)]);
[fast_S3_xlim, fast_S3_ylim] = outputLimits(fast_S3_tform, [1 size(S3_m2_origin, 2)], [1 size(S3_m2_origin, 1)]);
[fast_S4_xlim, fast_S4_ylim] = outputLimits(fast_S4_tform, [1 size(S4_m2_origin, 2)], [1 size(S4_m2_origin, 1)]);

% Combine the sizes of two images to determine the size of the panorama
fastR_S1_xLimits = [min(0, fastR_S1_xlim(1)) max(size(S1_m1_origin, 2), fastR_S1_xlim(2))];
fastR_S1_yLimits = [min(0, fastR_S1_ylim(1)) max(size(S1_m1_origin, 1), fastR_S1_ylim(2))];
fastR_S2_xLimits = [min(0, fastR_S2_xlim(1)) max(size(S2_m1_origin, 2), fastR_S2_xlim(2))];
fastR_S2_yLimits = [min(0, fastR_S2_ylim(1)) max(size(S2_m1_origin, 1), fastR_S2_ylim(2))];
fastR_S3_xLimits = [min(0, fastR_S3_xlim(1)) max(size(S3_m1_origin, 2), fastR_S3_xlim(2))];
fastR_S3_yLimits = [min(0, fastR_S3_ylim(1)) max(size(S3_m1_origin, 1), fastR_S3_ylim(2))];
fastR_S4_xLimits = [min(0, fastR_S4_xlim(1)) max(size(S4_m1_origin, 2), fastR_S4_xlim(2))];
fastR_S4_yLimits = [min(0, fastR_S4_ylim(1)) max(size(S4_m1_origin, 1), fastR_S4_ylim(2))];

fast_S1_xLimits = [min(0, fast_S1_xlim(1)) max(size(S1_m1_origin, 2), fast_S1_xlim(2))];
fast_S1_yLimits = [min(0, fast_S1_ylim(1)) max(size(S1_m1_origin, 1), fast_S1_ylim(2))];
fast_S2_xLimits = [min(0, fast_S2_xlim(1)) max(size(S2_m1_origin, 2), fast_S2_xlim(2))];
fast_S2_yLimits = [min(0, fast_S2_ylim(1)) max(size(S2_m1_origin, 1), fast_S2_ylim(2))];
fast_S3_xLimits = [min(0, fast_S3_xlim(1)) max(size(S3_m1_origin, 2), fast_S3_xlim(2))];
fast_S3_yLimits = [min(0, fast_S3_ylim(1)) max(size(S3_m1_origin, 1), fast_S3_ylim(2))];
fast_S4_xLimits = [min(0, fast_S4_xlim(1)) max(size(S4_m1_origin, 2), fast_S4_xlim(2))];
fast_S4_yLimits = [min(0, fast_S4_ylim(1)) max(size(S4_m1_origin, 1), fast_S4_ylim(2))];

% Create the panorama view
S1_width = round(fastR_S1_xLimits(2) - fastR_S1_xLimits(1));
S1_height = round(fastR_S1_yLimits(2) - fastR_S1_yLimits(1));
S2_width = round(fastR_S2_xLimits(2) - fastR_S2_xLimits(1));
S2_height = round(fastR_S2_yLimits(2) - fastR_S2_yLimits(1));
S3_width = round(fastR_S3_xLimits(2) - fastR_S3_xLimits(1));
S3_height = round(fastR_S3_yLimits(2) - fastR_S3_yLimits(1));
S4_width = round(fastR_S4_xLimits(2) - fastR_S4_xLimits(1));
S4_height = round(fastR_S4_yLimits(2) - fastR_S4_yLimits(1));

fastR_S1_panoramaView = imref2d([S1_height, S1_width], fastR_S1_xLimits, fastR_S1_yLimits);
fastR_S2_panoramaView = imref2d([S2_height, S2_width], fastR_S2_xLimits, fastR_S2_yLimits);
fastR_S3_panoramaView = imref2d([S3_height, S3_width], fastR_S3_xLimits, fastR_S3_yLimits);
fastR_S4_panoramaView = imref2d([S4_height, S4_width], fastR_S4_xLimits, fastR_S4_yLimits);

fast_S1_panoramaView = imref2d([S1_height, S1_width], fast_S1_xLimits, fast_S1_yLimits);
fast_S2_panoramaView = imref2d([S2_height, S2_width], fast_S2_xLimits, fast_S2_yLimits);
fast_S3_panoramaView = imref2d([S3_height, S3_width], fast_S3_xLimits, fast_S3_yLimits);
fast_S4_panoramaView = imref2d([S4_height, S4_width], fast_S4_xLimits, fast_S4_yLimits);

% Warp the second image using the tform matrix.
fastR_warpedS1_im2 = imwarp(S1_m2_origin, fastR_S1_tform, 'OutputView', fastR_S1_panoramaView);
fastR_warpedS2_im2 = imwarp(S2_m2_origin, fastR_S2_tform, 'OutputView', fastR_S2_panoramaView);
fastR_warpedS3_im2 = imwarp(S3_m2_origin, fastR_S3_tform, 'OutputView', fastR_S3_panoramaView);
fastR_warpedS4_im2 = imwarp(S4_m2_origin, fastR_S4_tform, 'OutputView', fastR_S4_panoramaView);

fast_warpedS1_im2 = imwarp(S1_m2_origin, fast_S1_tform, 'OutputView', fast_S1_panoramaView);
fast_warpedS2_im2 = imwarp(S2_m2_origin, fast_S2_tform, 'OutputView', fast_S2_panoramaView);
fast_warpedS3_im2 = imwarp(S3_m2_origin, fast_S3_tform, 'OutputView', fast_S3_panoramaView);
fast_warpedS4_im2 = imwarp(S4_m2_origin, fast_S4_tform, 'OutputView', fast_S4_panoramaView);

% Create a blank image to hold the final panorama
% 'like', image1 indicates that the newly created array will be of the same data type as image1
fasrR_S1_panorama = zeros([fastR_S1_panoramaView.ImageSize, 3], 'like', S1_m1_origin);
fasrR_S2_panorama = zeros([fastR_S2_panoramaView.ImageSize, 3], 'like', S2_m1_origin);
fasrR_S3_panorama = zeros([fastR_S3_panoramaView.ImageSize, 3], 'like', S3_m1_origin);
fasrR_S4_panorama = zeros([fastR_S4_panoramaView.ImageSize, 3], 'like', S4_m1_origin);

fast_S1_panorama = zeros([fast_S1_panoramaView.ImageSize, 3], 'like', S1_m1_origin);
fast_S2_panorama = zeros([fast_S2_panoramaView.ImageSize, 3], 'like', S2_m1_origin);
fast_S3_panorama = zeros([fast_S3_panoramaView.ImageSize, 3], 'like', S3_m1_origin);
fast_S4_panorama = zeros([fast_S4_panoramaView.ImageSize, 3], 'like', S4_m1_origin);

% Create an AlphaBlender object, using vision.AlphaBlender Stacks images together
blender = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');

% No need to warp the first image, just put it on the left of the panorama
S1_imageSize = size(S1_m1_origin);
S2_imageSize = size(S2_m1_origin);
S3_imageSize = size(S3_m1_origin);
S4_imageSize = size(S4_m1_origin);

% Adjust the coordinates of the left image
fasrR_S1_panorama(round(-fastR_S1_yLimits(1) + 1):round(-fastR_S1_yLimits(1) + S1_imageSize(1)), 1:S1_imageSize(2), :) = S1_m1_origin;
fasrR_S2_panorama(round(-fastR_S2_yLimits(1) + 1):round(-fastR_S2_yLimits(1) + S2_imageSize(1)), 1:S2_imageSize(2), :) = S2_m1_origin;
fasrR_S3_panorama(round(-fastR_S3_yLimits(1) + 1):round(-fastR_S3_yLimits(1) + S3_imageSize(1)), 1:S3_imageSize(2), :) = S3_m1_origin;
fasrR_S4_panorama(round(-fastR_S4_yLimits(1) + 1):round(-fastR_S4_yLimits(1) + S4_imageSize(1)), 1:S4_imageSize(2), :) = S4_m1_origin;

fast_S1_panorama(round(-fast_S1_yLimits(1) + 1):round(-fast_S1_yLimits(1) + S1_imageSize(1)), 1:S1_imageSize(2), :) = S1_m1_origin;
fast_S2_panorama(round(-fast_S2_yLimits(1) + 1):round(-fast_S2_yLimits(1) + S2_imageSize(1)), 1:S2_imageSize(2), :) = S2_m1_origin;
fast_S3_panorama(round(-fast_S3_yLimits(1) + 1):round(-fast_S3_yLimits(1) + S3_imageSize(1)), 1:S3_imageSize(2), :) = S3_m1_origin;
fast_S4_panorama(round(-fast_S4_yLimits(1) + 1):round(-fast_S4_yLimits(1) + S4_imageSize(1)), 1:S4_imageSize(2), :) = S4_m1_origin;

% Create the binary mask of the second image
fasrR_S1_mask = imwarp(true(size(S1_m2_origin,1), size(S1_m1_origin,2)), fastR_S1_tform, 'OutputView', fastR_S1_panoramaView);
fastR_S2_mask = imwarp(true(size(S2_m2_origin,1), size(S2_m1_origin,2)), fastR_S2_tform, 'OutputView', fastR_S2_panoramaView);
fastR_S3_mask = imwarp(true(size(S3_m2_origin,1), size(S3_m1_origin,2)), fastR_S3_tform, 'OutputView', fastR_S3_panoramaView);
fastR_S4_mask = imwarp(true(size(S4_m2_origin,1), size(S4_m1_origin,2)), fastR_S4_tform, 'OutputView', fastR_S4_panoramaView);

fast_S1_mask = imwarp(true(size(S1_m2_origin,1), size(S1_m1_origin,2)), fast_S1_tform, 'OutputView', fast_S1_panoramaView);
fast_S2_mask = imwarp(true(size(S2_m2_origin,1), size(S2_m1_origin,2)), fast_S2_tform, 'OutputView', fast_S2_panoramaView);
fast_S3_mask = imwarp(true(size(S3_m2_origin,1), size(S3_m1_origin,2)), fast_S3_tform, 'OutputView', fast_S3_panoramaView);
fast_S4_mask = imwarp(true(size(S4_m2_origin,1), size(S4_m1_origin,2)), fast_S4_tform, 'OutputView', fast_S4_panoramaView);

% Overlay the warpedImage onto the panorama.
fasrR_S1_panorama = step(blender, fasrR_S1_panorama, fastR_warpedS1_im2, fasrR_S1_mask);
fasrR_S2_panorama = step(blender, fasrR_S2_panorama, fastR_warpedS2_im2, fastR_S2_mask);
fasrR_S3_panorama = step(blender, fasrR_S3_panorama, fastR_warpedS3_im2, fastR_S3_mask);
fasrR_S4_panorama = step(blender, fasrR_S4_panorama, fastR_warpedS4_im2, fastR_S4_mask);

fast_S1_panorama = step(blender, fast_S1_panorama, fast_warpedS1_im2, fast_S1_mask);
fast_S2_panorama = step(blender, fast_S2_panorama, fast_warpedS2_im2, fast_S2_mask);
fast_S3_panorama = step(blender, fast_S3_panorama, fast_warpedS3_im2, fast_S3_mask);
fast_S4_panorama = step(blender, fast_S4_panorama, fast_warpedS4_im2, fast_S4_mask);

% show the final panorama
imshow(fasrR_S1_panorama);
imshow(fasrR_S2_panorama);
imshow(fasrR_S3_panorama);
imshow(fasrR_S4_panorama);

imshow(fast_S1_panorama);
imshow(fast_S2_panorama);
imshow(fast_S3_panorama);
imshow(fast_S4_panorama);

% Save the panorama
imwrite(fasrR_S1_panorama, 'S1-panorama.png');
imwrite(fasrR_S2_panorama, 'S2-panorama.png');
imwrite(fasrR_S3_panorama, 'S3-panorama.png');
imwrite(fasrR_S4_panorama, 'S4-panorama.png');

imwrite(fast_S1_panorama, 'S1-panorama-fast.png');
imwrite(fast_S2_panorama, 'S2-panorama-fast.png');
imwrite(fast_S3_panorama, 'S3-panorama-fast.png');
imwrite(fast_S4_panorama, 'S4-panorama-fast.png');