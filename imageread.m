function [R, G, B] = imageread(path)

figure
imshow(path)
title('Encoded Image');

image = imread(path);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

end