

function lum = luminance(image1)

%image1 = double(image1);

hsv = rgb2hsv(image1);

v = hsv(:,:,3);

lum = mean2(v)*255;
