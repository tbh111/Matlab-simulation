clc
close all
clear

carrier = imread('Parrot_Color.bmp');
carrier_gray = rgb2gray(carrier);
[rows1,cols1,dims1] = size(carrier);

info = imread('dlut.bmp');
[rows2,cols2,dims2] = size(info);
if(dims2 == 3)
    info_gray = rgb2gray(info);
else
    info_gray = info;
end

if (rows2>rows1) || (cols2>cols1)
    info_gray = imresize(info_gray,[rows1,cols1]);
    rows2 = rows1;
    cols2 = cols1;
end

info_gray = im2double(info_gray);
info_bin = imbinarize(info_gray);
[a,b] = DES_enc(info_bin);

LSB_encode = carrier_gray;
for i=1:rows2
    for j=1:cols2
        if a(i,j) == bitget(carrier_gray(i,j),1)
            continue
        elseif a(i,j) == 0 && bitget(carrier_gray(i,j),1) == 1
            LSB_encode(i,j) = carrier_gray(i,j) - 1;
        elseif a(i,j) == 1 && bitget(carrier_gray(i,j),1) == 0
            LSB_encode(i,j) = carrier_gray(i,j) + 1;
        end
    end
end
LSB_decode = zeros(rows2,cols2);
for i=1:rows2
    for j=1:cols2
        if bitget(LSB_encode(i,j),1) == 1
            LSB_decode(i,j) = 1;
        else
            continue;
        end
    end
end
figure(1)
imshow(LSB_encode)
figure(2)
imshow(LSB_decode)