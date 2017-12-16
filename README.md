# DIP_Project
Digital Image Processing Course Project

-----

### Kadir
* ~~Compression ratio~~
* ~~Relative data redundancy (1-1/Cr)~~
* ~~Signal to Noise Ratio (SNR)~~
* ~~Mean-Square Signal to Noise Ratio (MS-SNR)~~
* ~~Entropy~~
* histogram, sharpness, luminance
* niqe, BRISQUE(add ui to display these)

### How to use
* ImageAssessment.fig -> UI file
* ImageAssessment.m   -> UI functions
* ./func              -> functions folder(add to path first)
* ./src               -> resources(include test img)
* Open application:
    - load image want to be assessed and original image(assessed image necessary, original image optional)
    - show or hide image display
    - assess

### References
> quick review of the functions, what it processes and how to understand result. add later

* Mean Squared Error(MSE)
    - the difference between the estimator and what is estimated
* RMSE
    - represents the sample standard deviation of the differences between predicted values and observed values
* Signal-to-noise ratio(SNR)
    - compares the level of a desired signal to the level of background noise.
    - In image processing: the ratio of the mean pixel value to the standard deviation of the pixel values over a given neighborhood
* PSNR
    - used to measure the quality of reconstruction of lossy compression codecs (e.g., for image compression)
    - The signal in this case is the original data, and the noise is the error introduced by compression
    - When comparing compression codecs, PSNR is an approximation to human perception of reconstruction quality
    - <25 bad quality; 25-35 can see differences; >37 differences can hardly distinguish
* MS-SNR
    - any meaning?
* Entropy
    - 

* Normalized Cross-Correlation
* Average Difference
* Structural Content
* Maximum Difference
* Laplacian Mean Square Error
* Normalized Absolute Error

[![Reference](src/Reference.PNG)](src/Reference.PNG)

* Structural Similarity Index (SSIM)
    - Computation of three terms: luminance, contrast, structural
    - The overall index is a multiplicative combination of the three terms

[![SSIM](src/SSIM.png)](src/SSIM.png)

