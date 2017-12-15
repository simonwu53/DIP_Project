

function ms_snr = ms_snr(image1, image2)

image1_t = double(image1);
image2_t = double(image2);

[M N] = size(image1_t);
[K L] = size(image2_t);

MS0 = mean2(image1_t(1:M, 1:N))^2;
MS1 = mean2(image2_t(1:K, 1:L))^2;

ms_snr = (MS1/MS0)^2;

