

function cg = variance(image1)

%image1_temp = double(image1);
%Var1 = var(image1_temp(:));

%方法一：中心像素灰度值与周围4近邻像素灰度值之差的平方之和，除以以上平方项的个数。
%method1: calc the squared sum of center pixel value and four neighbor 
%         values, then divide by the number of squared terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function cg = duibidu4(image1) %f为输入图像，cg为输出的对比度数值，是英文contrast gradient的首字母组合
[m,n] = size(image1);%求原始图像的行数m和列数n
g = padarray(image1,[1 1],'symmetric','both');%对原始图像进行扩展，比如50*50的图像，扩展后变成52*52的图像，
%扩展只是对原始图像的周边像素进行复制的方法进行
[r,c] = size(g);%求扩展后图像的行数r和列数c
g = double(g);  %把扩展后图像转变成双精度浮点数
k = 0;  %定义一数值k，初始值为0
for i=2:r-1
    for j=2:c-1
        k = k+(g(i,j-1)-g(i,j))^2+(g(i-1,j)-g(i,j))^2+(g(i,j+1)-g(i,j))^2+(g(i+1,j)-g(i,j))^2;
    end
end

cg = k/(4*(m-2)*(n-2)+3*(2*(m-2)+2*(n-2))+4*2);%求原始图像对比度