

function SNR = signal_to_noise_ratio(image1, image2)

image1_t = double(image1);
image2_t = double(image2);

[M N] = size(image1_t);
[K L] = size(image2_t);

Avg1 = mean2(image1_t(1:M, 1:N));
Avg2 = mean2(image2_t(1:K, 1:L));

RMS1 = sqrt(Avg1);
RMS2 = sqrt(Avg2);

SNR = RMS1/RMS2;


