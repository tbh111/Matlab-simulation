clc
close all
clear

[im1,key1] = LSB_encode('Parrot_Color.bmp','test1.bmp');
figure(1)
imshow(im1)
imwrite(im1,'im1.bmp')
im2 = LSB_decode(im1);
figure(2)
imshow(im2)
imwrite(im2,'im2.bmp')
load key
im3 = DES_dec(im2,DES_key);
figure(3)
imshow(im3)
imwrite(im3,'im3.bmp')