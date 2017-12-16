

function ms_snr = ms_snr(image1, image2)

image1_t = double(image1); % origin
image2_t = double(image2); % assessed

MS0 = mean2((image1-image2).^2);
MS1 = mean2(image2.^2);

ms_snr = MS1/MS0;

