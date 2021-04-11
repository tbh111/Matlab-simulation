function deciphertext = DES_dec(src,key)
[w,h] = size(src);
% w1 = fix(w/(2*sqrt(2)));
% h1 = fix(h/(2*sqrt(2)));
src = src(:)';
deciphertext = zeros(1,w*h);
for i=1:ceil(w*h/64)
   if (i-1)*64+1 > length(key)
       break
   end
   deciphertext(64*(i-1)+1:64*i) = DES(src((i-1)*64+1:i*64),'DEC',key((i-1)*64+1:i*64));
end
deciphertext = reshape(deciphertext,w,[]);
% deciphertext = reshape(deciphertext,8,[]);
% 
% n=8;
% x=deciphertext'*(2.^(n-1:-1:0))';
% a = x(1:h1*w1);
% b=reshape(a',w1,[]);
% b=b/256;
% figure(4)
% imshow(b)
% size(x)
% size(zeros(length(x)-fix(length(x)/w1)*w1,1))
% x = x(1:w*h/8);
% % x = [x',zeros(1,1+length(x)-fix(length(x)/w1)*w1)];
% result=reshape(x,w,[]);
% for i=1:w1
%     for j=1:h1
%         result(i,j)=x(:,s);
%         s=s+1;
%     end
% end

