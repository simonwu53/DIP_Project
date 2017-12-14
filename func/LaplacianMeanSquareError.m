% Program for Laplacian Mean Square Error Calculation

function LMSE = LaplacianMeanSquareError(origImg, distImg)
origImg = double(origImg);
distImg = double(distImg);

OP = 4*del2(origImg);
LMSE = sum(sum((OP-4*del2(distImg)).^2))/sum(sum(OP.^2));
end

