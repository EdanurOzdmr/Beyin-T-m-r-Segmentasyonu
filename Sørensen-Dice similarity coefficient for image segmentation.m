clc;
clear;close all;
load('11');
im=double(cjdata.image);
bw = double(cjdata.tumorMask);
fim=mat2gray(im);
level=graythresh(fim);
bwfim=im2bw(fim,level);
fim1=mat2gray(bw);
level2=graythresh(fim1);
[bwfim0,level0]=fcmthresh(fim,0);
[bwfim1,level1]=fcmthresh(fim,1);
BW2 = bwareafilt (bwfim1,2);
L = bwlabel(BW2); %where bw is your binary image
bw2 = BW2; %copy of binary image
bw2(L==bwareafilt (bwfim1,1)) = 0; %deletes the 5th object

if nargin<2
    error('The function requires two input-vectors')
end
if (sum(fim1==0) + sum(fim1==1)) < length(fim1)
    error('Input A must be binary (0,1) !!!')
end
  
if (sum(bw2==0) + sum(bw2==1)) < length(bw2)
    error('Input B must be binary (0,1) !!!')
end
 OverlapImage=fim1-bw2;      
DC = 2*(sum(fim1.*bw2))/sum(fim1 + bw2);
subplot(2,2,1);
imshow(bwfim1);title(sprintf('FCM1,level=%f',level1));
subplot(2,2,2);
imshow(bw2);title('tumor');
subplot(2,2,3);
imshow(bw);
subplot(2,2,4);
imshow(OverlapImage);colormap(gray);title(['Dice Index = ' num2str(DC)])
