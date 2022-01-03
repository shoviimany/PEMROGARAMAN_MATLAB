citra=imread('citra.jpg');
filter1=imgaussfilt(citra);
filter2=imgaussfilt(citra,2);
subplot(1,3,1),imshow(citra);
subplot(1,3,2),imshow(filter1);
subplot(1,3,3),imshow(filter2);