function [LSB_result,DES_key] = LSB_encode(carrier,info,mode)

[rows1,cols1,dim1] = size(carrier);
[rows2,cols2,dim2] = size(info);


% if dim1 == 1 && dim2 == 1
if (rows2>rows1) || (cols2>cols1) %信息比原图片大，将信息缩放至原图片大小
    info = imresize(info,[rows1,cols1]);
elseif (rows2<rows1) || (cols2<cols1) %信息比原图片小，将信息外的区域补1
    for i=1:rows1
        for j=1:cols1
            for k=1:dim2
                if (i<rows2) && (j<cols2)
                    continue
                else
                    info(i,j,k) = 255;
                end
            end
        end
    end
end

if mode == 0
    disp('processing')
    info = im2double(info);
    info_bin = imbinarize(info);
    DES_key = [];
    LSB_result = carrier;
    for i=1:rows1
        for j=1:cols1
            if info_bin(i,j) == bitget(carrier(i,j),1)
                continue
            elseif info_bin(i,j) == 0 && bitget(carrier(i,j),1) == 1
                LSB_result(i,j) = carrier(i,j) - 1;
            elseif info_bin(i,j) == 1 && bitget(carrier(i,j),1) == 0
                LSB_result(i,j) = carrier(i,j) + 1;
            end
        end
    end
    disp('none pwd success')
else
    disp('processing')
    info = im2double(info);
    info_bin = imbinarize(info);
    DES_text = reshape(info_bin,1,[]);
    [DES_result,DES_key] = DES_enc(DES_text);
    DES_result = reshape(DES_result,cols1,[]);
    
    LSB_result = carrier;
    for i=1:rows1
        for j=1:cols1
            if DES_result(i,j) == bitget(carrier(i,j),1)
                continue
            elseif DES_result(i,j) == 0 && bitget(carrier(i,j),1) == 1
                LSB_result(i,j) = carrier(i,j) - 1;
            elseif DES_result(i,j) == 1 && bitget(carrier(i,j),1) == 0
                LSB_result(i,j) = carrier(i,j) + 1;
            end
        end
    end
    disp('pwd success');
    save('key.mat','DES_key');
end



% LSB_result = carrier;
% for i=1:rows1
%     for j=1:cols1
%         if DES_result(i,j) == bitget(carrier(i,j),1)
%             continue
%         elseif DES_result(i,j) == 0 && bitget(carrier(i,j),1) == 1
%             LSB_result(i,j) = carrier(i,j) - 1;
%         elseif DES_result(i,j) == 1 && bitget(carrier(i,j),1) == 0
%             LSB_result(i,j) = carrier(i,j) + 1;
%         end
%     end
% end
% save('key.mat','DES_key');
% else
%     
% end
%     if (rows2>rows1/(2*sqrt(2))) || (cols2>cols1/(2*sqrt(2))) %信息比原图片大，将信息缩放至原图片大小
%         info = imresize(info,[fix(rows1/(2*sqrt(2))),fix(cols1/(2*sqrt(2)))]);
%     elseif (rows2<rows1/(2*sqrt(2))) || (cols2<cols1/(2*sqrt(2))) %信息比原图片小，将信息外的区域补1
%         for i=1:fix(rows1/(2*sqrt(2)))
%             for j=1:fix(cols1/(2*sqrt(2)))
%                 for k=1:dim2
%                     if (i<rows2) && (j<cols2)
%                         continue
%                     else
%                         info(i,j,k) = 255;
%                     end
%                 end
%             end
%         end
%     end
% %     DES_result = [];
% %     DES_key = [];
%     for count1=1:3
% %         info = im2double(info);
% %         info_bin = imbinarize(info);
%         info_dim = info(:,:,count1);
%         DES_text = reshape(info_dim,1,[]);
%         DES_text1 = [];
%         for i = 1:size(info_dim,1)*size(info_dim,2)
%             a = dec2bin(DES_text(i))-'0';
%             if length(a) <8
%                 a = [zeros(1,8-length(a)),a];
%             end
%             DES_text1 = [DES_text1,a];
%         end
%             
%         [DES_result_dim,DES_key_dim] = DES_enc(DES_text1);
% %         DES_result = [DES_result,DES_result_dim];
% %         DES_key = [DES_key,DES_key_dim];
%         if count1 == 1
%             DES_result1 = DES_result_dim;
%             DES_key1 = DES_key_dim;
%             LSB_result1 = carrier(:,:,1);
%             step1 = 0;
%             for i=1:rows1
%                 for j=1:cols1
%                     step1 = step1+1;
%                     if step1>length(DES_result1)
%                         continue
%                     elseif DES_result1(step1) == bitget(carrier(i,j,1),1)
%                         continue
%                     elseif DES_result1(step1) == 0 && bitget(carrier(i,j,1),1) == 1
%                         LSB_result1(i,j) = carrier(i,j,1) - 1;
%                     elseif DES_result1(step1) == 1 && bitget(carrier(i,j,1),1) == 0
%                         LSB_result1(i,j) = carrier(i,j,1) + 1;
%                     end
%                     
%                 end
%             end
%             
%         elseif count1 == 2
%             DES_result2 = DES_result_dim;
%             DES_key2 = DES_key_dim;
%             LSB_result2 = carrier(:,:,2);
%             step2 = 0;
%             for i=1:rows1
%                 for j=1:cols1
%                     step2 = step2+1;
%                     if step2>length(DES_result2)
%                         continue
%                     elseif DES_result2(step2) == bitget(carrier(i,j,2),1)
%                         continue
%                     elseif DES_result2(step2) == 0 && bitget(carrier(i,j,2),1) == 1
%                         LSB_result2(i,j) = carrier(i,j,2) - 1;
%                     elseif DES_result2(step2) == 1 && bitget(carrier(i,j,2),1) == 0
%                         LSB_result2(i,j) = carrier(i,j,2) + 1;
%                     end
%                 end
%             end
%             
%         else
%             DES_result3 = DES_result_dim;
%             DES_key3 = DES_key_dim;
%             LSB_result3 = carrier(:,:,3);
%             step3 = 0;
%             for i=1:rows1
%                 for j=1:cols1
%                     step3 = step3+1;
%                     if step3>length(DES_result3)
%                         continue
%                     elseif DES_result3(step3) == bitget(carrier(i,j,3),1)
%                         continue
%                     elseif DES_result3(step3) == 0 && bitget(carrier(i,j,3),1) == 1
%                         LSB_result3(i,j) = carrier(i,j,3) - 1;
%                     elseif DES_result3(step3) == 1 && bitget(carrier(i,j,3),1) == 0
%                         LSB_result3(i,j) = carrier(i,j,3) + 1;
%                     end
%                 end
%             end
%         end
% %         DES_result = reshape(DES_result,cols1,[]); 
%     end
%     LSB_result = cat(3,LSB_result1,LSB_result2,LSB_result3);
%     DES_key = [DES_key1,DES_key2,DES_key3];
%     save('key.mat','DES_key1','DES_key2','DES_key3');
% end

% if(dim2 == 3)
%     info_gray = rgb2gray(info);
% else
%     info_gray = info;
% end
 
% if (rows2>rows1) || (cols2>cols1) %信息比原图片大，将信息缩放至原图片大小
%     info = imresize(info,[rows1,cols1]);
% elseif (rows2<rows1) || (cols2<cols1) %信息比原图片小，将信息外的区域补1
%     for i=1:rows1
%         for j=1:cols1
%             for k=1:dim2
%                 if (i<rows2) && (j<cols2)
%                     continue
%                 else
%                     info(i,j,k) = 255;
%                 end
%             end
%         end
%     end
% end

% if(dim2 == 1)
%     if (rows2>rows1) || (cols2>cols1) %信息比原图片大，将信息缩放至原图片大小
%         info = imresize(info,[rows1,cols1]);
%     end
% else
%     if (rows2>rows1*2*sqrt(6)) || (cols2>cols1*2*sqrt(6))
%         info = imresize(info,[fix(rows1*2*sqrt(6)),fix(cols1*2*sqrt(6))]);
%     end
% end

% if(dim1 == 1)
%     if(dim2 == 1) %原图像、信息为一维
%         [result,key] = process(carrier,info);
%     else
%         info = rgb2gray(info); %原图像一维，信息三维，取信息灰度值
%         [result,key] = process(carrier,info);
%     end
% else
%     if(dim2 == 1) % 原图像三维，信息一维，将信息嵌入原图像R通道中
%         result = carrier;
%         [result(:,:,1),key] = process(carrier(:,:,1),info);
%     else %原图像、信息为三维
%         result = carrier;
%         info = rgb2gray(info);
%         [result(:,:,1),key] = process(carrier(:,:,1),info);
%     end
% end
% save('key.mat','key');

% function [LSB_result,key] = process_1(carrier,info)
% [rows1,cols1,dim1] = size(carrier);
% [rows2,cols2,dim2] = size(info);



% DES_text = reshape(info_bin,1,[]);
% 
% [ciphertext,key] = DES_enc(DES_text);
% ciphertext = reshape(ciphertext,cols1,[]);
% 
% 
% result = carrier_gray;


% if dim1 == 1 && dim2 == 1
%     if (rows2>rows1) || (cols2>cols1) %信息比原图片大，将信息缩放至原图片大小
%         info = imresize(info,[rows1,cols1,dim1]);
%     elseif (rows2<rows1) || (cols2<cols1) %信息比原图片小，将信息外的区域补1
%         for i=1:rows1
%             for j=1:cols1
%                 for k=1:dim2
%                     if (i<rows2) && (j<cols2)
%                         continue
%                     else
%                         info(i,j,k) = 255;
%                     end
%                 end
%             end
%         end
%     end
% 
%     LSB_result = carrier;
%     info = im2double(info);
%     info_bin = imbinarize(info);
%     DES_text = reshape(info_bin,1,[]);
%     [DES_result,key] = DES_enc(DES_text);
%     DES_result = reshape(DES_result,cols1,[]);
% 
%     for i=1:rows1
%         for j=1:cols1
%             if DES_result(i,j) == bitget(carrier(i,j),1)
%                 continue
%             elseif DES_result(i,j) == 0 && bitget(carrier(i,j),1) == 1
%                 LSB_result(i,j) = carrier(i,j) - 1;
%             elseif DES_result(i,j) == 1 && bitget(carrier(i,j),1) == 0
%                 LSB_result(i,j) = carrier(i,j) + 1;
%             end
%         end
%     end
%     


% elseif dim1 == 3 && dim2 == 3
%     
%     if (rows2>rows1*2*sqrt(2)) || (cols2>cols1*2*sqrt(2)) %信息比原图片大，将信息缩放至原图片大小
%         info = imresize(info,[rows1*2*sqrt(2),cols1*2*sqrt(2),dim1]);
%     elseif (rows2<rows1*2*sqrt(2)) || (cols2<cols1*2*sqrt(2)) %信息比原图片小，将信息外的区域补1
%         for i=1:rows1
%             for j=1:cols1
%                 for k=1:dim2
%                     if (i<rows2) && (j<cols2)
%                         continue
%                     else
%                         info(i,j,k) = 255;
%                     end
%                 end
%             end
%         end
%     end
%     
%     result = [];
%     key = [];
%     for count = 1:3
%         DES_text = carrier(:,:,count);
%         info = info(:,:,count);
%         info = reshape(info,1,[]);
%         DES_text = reshape(DES_text,1,[]);
%         carrier_step = 0;
%         for i=0:fix(rows2*cols2/8)-1
%             for k = 1:8
%                 if info(8*i+k) == bitget(DES_text(carrier_step),k)
%                     continue
%                 elseif info(8*i+k) == 0 && bitget(DES_text(carrier_step),k) == 1
%                     DES_text(carrier_step) = DES_text(carrier_step) - 1;
%                 elseif info(8*i+k) == 1 && bitget(DES_text(carrier_step),k) == 0
%                     DES_text(carrier_step) = DES_text(carrier_step) + 1;
%                 end
%             end
%             carrier_step = carrier_step+1;
%         end
%         DES_text = reshape(DES_text,1,[]);
%         [DES_result,DES_key] = DES_enc(DES_text);
%         DES_result = reshape(DES_result,cols1,[]);
%         result = [result,DES_result];
%         key = [key,DES_key];
%     end
% end





