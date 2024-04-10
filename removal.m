img = imread('apple.jpeg');
if size(img, 3) == 3
    img = rgb2gray(img);
end
F = fft2(double(img));
F_shifted = fftshift(F);
[m, n] = size(img);
radius = 50; 
center = [m/2, n/2];
[x, y] = meshgrid(1:n, 1:m);
mask = sqrt((x - center(2)).^2 + (y - center(1)).^2) > radius;
F_shifted_filtered = F_shifted .* mask;
F_filtered = ifftshift(F_shifted_filtered);
img_filtered = uint8(abs(ifft2(F_filtered)));
imshow(img_filtered);
img = imread('apple.jpeg');
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end
img = imread('apple.jpeg');
img_double = im2double(img);
image = imread('apple.jpeg');
if size(image, 3) == 3
    grayImage = rgb2gray(image);
else
    grayImage = image;
end
numClusters = 2; % Assuming the background and foreground are the two main clusters
pixelLabels = imsegkmeans(grayImage, numClusters);
backgroundLabel = mode(pixelLabels(:));
binaryImage = pixelLabels == backgroundLabel;
foregroundImage = imcomplement(binaryImage);
outputImage = bsxfun(@times, image, cast(foregroundImage, 'like', image));
figure;
imshow(outputImage);
title('Image with Background Removed');