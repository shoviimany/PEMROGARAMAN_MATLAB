huruf=imread('S.jpg');
gray=rgb2gray(huruf);
[M,N]=size(gray);
H_seg = zeros(M,N);
for k = 1 : M
for l = 1 : N
if gray(k,l)<20
H_seg(k,l)=1;
else
H_seg(k,l)=0;
end
end
end
%BW2 = bwmorph(BW,operation,n)
thinning=bwmorph(H_seg,'thin',25);
skeletoning=bwmorph(H_seg,'skel',70);
subplot(1,4,1),imshow(gray);
subplot(1,4,2),imshow(H_seg);
subplot(1,4,3),imshow(thinning);
subplot(1,4,4),imshow(skeletoning);