citra=imread('citra.jpg');
filter=medfilt3(citra);
subplot(1,2,1),imshow(citra);
subplot(1,2,2),imshow(filter);