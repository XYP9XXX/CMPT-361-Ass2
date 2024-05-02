function cornerMap = my_fast_detector(image, threshold)
    [rows, cols] = size(image); % Get the size of the image

    cornerMap = false(rows, cols); % This is the whole picture map that feature points are set value true. Initial they are all false.

    shiftPixels = [-3 0; -3 -1; -2 -2; -1 -3; 0 -3; 1 -3; 2 -2; 3 -1; 3 0; 3 1; 2 2; 1 3; 0 3; -1 3; -2 2; -3 1]; % Define the relative coordinates of 16 neighboring pixels

    for k = 1:16
        shiftedImage = circshift(image, shiftPixels(k, :)); % Shift the image for every pixel

        diffImage = abs(image - shiftedImage) > threshold; % Compare each neighbor with the original pixel

        cornerMap = cornerMap | diffImage; % Mark the possible corner points
    end

    % Check if potential corner points are continuous with 12 neighbor
    for i = 1:rows
        for j = 1:cols
            if cornerMap(i, j)
                % Check if it is on the border
                if i < 4 || j < 4 || i > rows - 3 || j > cols - 3
                    cornerMap(i, j) = false;
                end

                % Check continuous
                if is_continuous(image, i, j, threshold) == false
                    cornerMap(i, j) = false;
                end
            end
        end
    end
    
    % Non-maximal Suppression
    for i = 2:rows-1
        for j = 2:cols-1
            if cornerMap(i, j)
                % Check if the feature point is the maximum around 3 * 3 area to avoid continuous feature points
                localMax = max(max(image(i-1:i+1, j-1:j+1)));
                if image(i, j) < localMax
                    cornerMap(i, j) = false;
                end
            end
        end
    end
end

function continuous = is_continuous(image, row, col, threshold)
    shiftPixels = [-3 0; -3 -1; -2 -2; -1 -3; 0 -3; 1 -3; 2 -2; 3 -1; 3 0; 3 1; 2 2; 1 3; 0 3; -1 3; -2 2; -3 1];
    
    p = image(row, col); % Get the coordinates of potential corner point.
   
    values = zeros(1, 16); % Create an array to store the values of the brightness of the neighbor pixel

    for k = 1:16
        rowOffset = shiftPixels(k, 2);
        colOffset = shiftPixels(k, 1);
        neighborRow = row + rowOffset;
        neighborCol = col + colOffset;
    
        if neighborRow > 0 && neighborRow <= size(image, 1) && neighborCol > 0 && neighborCol <= size(image, 2) % Make sure coordinate is in range
            values(k) = image(neighborRow, neighborCol); % Get the brightness value
        else
            values(k) = 0; % Otherwise (out of boundry) just set 0.
        end
    end
    
    continuous = false; % Set continuous false at first
    for startIdx = 1:16
        endIdx = mod(startIdx + 11, 16); % Set start index and end index at first
        if endIdx == 0
            endIdx = 16;
        end
        
        % Check the continuous
        if endIdx > startIdx
            if all(abs(values(startIdx:endIdx) - p) > threshold)
                continuous = true;
                break;
            end
        else
            if all(abs(values(endIdx:startIdx) - p) > threshold)
                continuous = true;
                break;
            end
        end
    
    end
end