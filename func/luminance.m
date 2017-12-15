

function lum = luminance(image1)

image1_double = double(image1);

R=image1(:,:,1) ;
G=image1(:,:,2) ;
B=image1(:,:,3) ;

luminance = 0.299 * R + 0.587 * G + 0.114 * B;

lum=mean2(luminance);
