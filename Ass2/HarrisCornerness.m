function FASTR = HarrisCornerness(binaryMap, image, harrisThreshold)
    % binaryMap: Input binary image, in which feature points are marked as 1
    % image: The original image
    % harrisThreshold: Harris cornerness threshold
    
    % step1: Compute the gradient of the image
    sobel = [-1 0 1; -2 0 2; -1 0 1]; %create sobel kernel
    gaus = fspecial('gaussian', 5, 1);
    dog = conv2(gaus, sobel);
    ix = imfilter(image, dog); %x gradient
    iy = imfilter(image, dog'); %y gradient

    % step2 & 3: compute square of derivatives and using gaussian filter
    ix2g = imfilter(ix .* ix, gaus); %ix square
    iy2g = imfilter(iy .* iy, gaus); %iy square
    ixiyg = imfilter(ix .* iy, gaus); %ixiy
    
    % step4: compute harris corner detector
    harcor = ix2g .* iy2g - ixiyg .* ixiyg - 0.05 * (ix2g + iy2g).^2;
    
    % Get the coordinates of the feature points
    [featureRows, featureCols] = find(binaryMap);

    % Create the FASTR binary map
    FASTR = false(size(binaryMap));

    % Get the harris cornerness score for each feature points and test if they are greater than threshold
    for i = 1:length(featureRows)
        if harcor(featureRows(i), featureCols(i)) > harrisThreshold
            FASTR(featureRows(i), featureCols(i)) = true;
        end
    end
end