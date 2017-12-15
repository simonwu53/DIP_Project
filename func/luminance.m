

function lum = luminance(image1)

image1_double = double(image1);
[M N] = size(image1_double);

lum = mean2(image1_double(1:M, 1:N));
