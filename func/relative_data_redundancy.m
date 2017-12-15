



function rd = relative_data_redundancy(input1, input2)

info1 = imfinfo(input1);
info2 = imfinfo(input2);

size1 = info1.FileSize;
size2 = info2.FileSize;

cr = size1/size2;

rd=1-1/cr;

