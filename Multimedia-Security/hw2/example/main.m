%------------------------------------------------------------------%
%     ����DCT�任����Ϣ����(����ˮӡ)     %%                                                                %%                                                                %
%-----------------------------------------------------------=------%
clear ;
clc;
      
%-----------------------����ͼ��-------------------------------------%
markbefore=imread('dlut.bmp');
markbefore2=rgb2gray(markbefore);
mark=im2bw(markbefore2);    %ʹˮӡͼ���Ϊ��ֵͼ
figure(1);      %�򿪴���
subplot(2,3,1);    %�ô����ڵ�ͼ���������������
imshow(mark),title('ˮӡͼ��');   %��ʾˮӡͼ��
[rm,cm]=size(mark);   %����ˮӡͼ��ĳ���
 
cover_image=imread('Parrot.bmp');
[height,length,colorcnt] = size(cover_image);
if (colorcnt == 3)
    cover_image=rgb2gray(cover_image);
end
subplot(2,3,2),imshow(cover_image,[]),title('����ͼ��'); %[]��ʾ��ʾʱ�Ҷȷ�ΧΪimage�ϵĻҶ���Сֵ�����ֵ
 
before=blkproc(cover_image,[8 8],'dct2');   %������ͼ��ĻҶȲ��Ϊ8��8��С�飬ÿһ��������άDCT�任������������before
 
I=mark;
alpha=10;     %�߶�����,����ˮӡ��ӵ�ǿ��,������Ƶ��ϵ�����޸ĵķ���
k1=randn(1,8);  %����������ͬ���������
k2=randn(1,8);
after=before;   %��ʼ������ˮӡ�Ľ������
for i=1:rm          %����Ƶ��Ƕ��ˮӡ
    for j=1:cm
        x=(i-1)*8;
        y=(j-1)*8;
        if mark(i,j)==1
            k=k1;
        else
            k=k2;
        end
        after(x+1,y+8)=before(x+1,y+8)+alpha*k(1);
        after(x+2,y+7)=before(x+2,y+7)+alpha*k(2);
        after(x+3,y+6)=before(x+3,y+6)+alpha*k(3);
        after(x+4,y+5)=before(x+4,y+5)+alpha*k(4);
        after(x+5,y+4)=before(x+5,y+4)+alpha*k(5);
        after(x+6,y+3)=before(x+6,y+3)+alpha*k(6);
        after(x+7,y+2)=before(x+7,y+2)+alpha*k(7);
        after(x+8,y+1)=before(x+8,y+1)+alpha*k(8);
    end
end
result=blkproc(after,[8 8],'idct2');    %���������ͼ���Ϊ8��8��С�飬ÿһ��������άDCT��任
result = uint8(result);
imwrite(result,'Watermarked.bmp','bmp');      %�洢���ˮӡ���ͼ��
subplot(2,3,3),imshow(result,[]),title('Ƕ��ˮӡ��ͼ��');    %��ʾ���ˮӡ���ͼ��
 
%����һ���տռ����洢��ȡ��ˮӡ
while(1)
disp('��ѡ���ͼ��Ĺ�����ʽ��');
disp('0.�˳�');
disp('1.��Ӱ�����');
disp('2.��˹��ͨ�˲�����');
disp('3.��ͼ����в��ּ���');
disp('4.��ͼ����תʮ��');
disp('5.��ͼ��ѹ������');
disp('6.��ӽ�������');
disp('7.������ͼ��ֱ����ʾ��ȡˮӡ');
disp('��������������ֱ����ʾ��ȡˮӡ');
choice=input('������ѡ��');
figure(1);
subplot(2,3,1),imshow(mark),title('ˮӡͼ��');
subplot(2,3,2),imshow(cover_image,[]),title('����ͼ��');
subplot(2,3,3),imshow(result,[]),title('Ƕ��ˮӡ��ͼ��'); 
switch choice        %���������ѡ��  withmarkΪ�ȴ���ȡˮӡ��ͼ��
    case 0 
        break;
    case 1
        result_1=result;
        withmark=imnoise(result_1,'gaussian',0.0001); %�����˹������
        subplot(2,3,4);
        imshow(withmark,[]);
        title('�����˹���������ͼ��');     %��ʾ���˸�˹������������ͼ��
    case 2
         result_2=result;
         H=fspecial('gaussian',[4,4],0.2); 
         result_2=imfilter(result_2,H); 
         subplot(2,3,4); 
         imshow(result_2,[]); 
         title('��˹��ͨ�˲���ͼ��'); 
         withmark=result_2;
    case 3
        result_3=result;
        result_3(1:64,1:400)=512;   %ʹͼ���Ϸ�������
        subplot(2,3,4);
        imshow(result_3);
        title('�Ϸ����к�ͼ��');
        withmark=result_3;
    case 4
        result_4=imrotate(result,10,'bilinear','crop');   %���ڽ����Բ�ֵ�㷨��ת10��
        subplot(2,3,4);
        imshow(result_4);
        title('��ת10�Ⱥ�ͼ��');
        withmark=result_4;
    case 5
        result_5 = result; 
        result_5=im2double(result_5); 
        cnum=10; 
        dctm=dctmtx(8); 
        P1=dctm; 
        P2=dctm.'; 
        imageDCT=blkproc(result_5,[8,8],'P1*x*P2',dctm,dctm.'); 
        DCTvar=im2col(imageDCT,[8,8],'distinct').'; 
        n=size(DCTvar,1); 
        DCTvar=(sum(DCTvar.*DCTvar)-(sum(DCTvar)/n).^2)/n; 
        [dum,order]=sort(DCTvar); 
        cnum=64-cnum; 
        mask=ones(8,8); 
        mask(order(1:cnum))=zeros(1,cnum); 
        im88=zeros(9,9); 
        im88(1:8,1:8)=mask; 
        im128128=kron(im88(1:8,1:8),ones(16)); 
        dctm=dctmtx(8); 
        P1=dctm.'; 
        P2=mask(1:8,1:8); 
        P3=dctm; 
        result_5=blkproc(imageDCT,[8,8],'P1*(x.*P2)*P3',dctm.',mask(1:8,1:8),dctm); 
        WImage5cl=mat2gray(result_5); 
        subplot(2,3,4); 
        imshow(WImage5cl); 
        title('��JPEGѹ����ͼ��'); 
        withmark=WImage5cl;
    case 6
        result_6=result;
        withmark=imnoise(result_6,'salt & pepper',0.02); %���뽷������
        subplot(2,3,4);
        imshow(withmark,[]);
        title('���뽷���������ͼ��');     %��ʾ���˽���������ͼ��
    case 7
        subplot(2,3,4);
        imshow(result,[]);
        title('δ�ܹ�����ˮӡͼ��');
        withmark=result;
    otherwise
        disp('��������ѡ����Ч��ͼ��δ�ܹ�����ֱ����ȡˮӡ');
        subplot(2,3,4);
        imshow(result,[]);
        title('δ�ܹ�����ˮӡͼ��');
        withmark=result;
end

%------------------------ˮӡ��ȡ-----------------------------%
%
after_2=blkproc(withmark,[8,8],'dct2');   %�˲���ʼ��ȡˮӡ�����ҶȲ�ֿ����DCT�任
p=zeros(1,8);        %��ʼ����ȡ��ֵ�õľ���
mark_2 = zeros(rm,cm);
for i=1:rm
    for j=1:cm
        x=(i-1)*8;y=(j-1)*8;
        p(1)=after_2(x+1,y+8);         %��֮ǰ�ı����ֵ�ĵ����ֵ��ȡ����
        p(2)=after_2(x+2,y+7);
        p(3)=after_2(x+3,y+6);
        p(4)=after_2(x+4,y+5);
        p(5)=after_2(x+5,y+4);
        p(6)=after_2(x+6,y+3);
        p(7)=after_2(x+7,y+2);
        p(8)=after_2(x+8,y+1);
        if corr2(p,k1)>corr2(p,k2)  %corr2����������������ƶȣ�Խ�ӽ�1���ƶ�Խ��
            mark_2(i,j)=1;              %�Ƚ���ȡ��������ֵ�����Ƶ��k1��k2�����ƶȣ���ԭˮӡͼ��
        else
            mark_2(i,j)=0;
        end
    end
end
subplot(2,3,5);
mark_2 = uint8(mark_2);
imshow(mark_2,[]),title('��ȡ����ˮӡ');
subplot(2,3,6);
imshow(mark),title('ԭǶ��ˮӡ');
NC=correlation(mark_2,mark);  
disp('ԭˮӡͼ������ȡˮӡͼ�����ϵ��:')
disp(NC);
end