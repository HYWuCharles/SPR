function reshape_image(R,G,B)

image(:,:,1) = R;
image(:,:,2) = G;
image(:,:,3) = B;
image_show(image,'reshaped image')
end