function [ciphertext,key] = DES_enc(src)
[w,h,d] = size(src);
src = src(:)';
ciphertext = zeros(1,64*ceil(w*h*d/64));
key = zeros(1,64*ceil(w*h*d/64));
src_add_zero = [src,zeros(1,64*ceil(w*h*d/64)-w*h*d)];
for i=1:ceil(w*h*d/64)
   [ciphertext(64*(i-1)+1:64*i),key(64*(i-1)+1:64*i)] = DES(src_add_zero((i-1)*64+1:i*64),'ENC');
end