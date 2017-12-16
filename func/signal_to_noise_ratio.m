

function SNR = signal_to_noise_ratio(image1, image2)

image1_t = double(image1); % original
image2_t = double(image2); % assessed

Avg = mean2(image1_t);

Ps = sum(sum((image1_t-Avg).^2)); % signal power
Pn = sum(sum((image1_t-image2_t).^2)); % noise power

SNR = 10*log10(Ps/Pn);


