gambar = imread('kopi.jpg');
kopi = rgb2gray(gambar);
contrast = imadjust(kopi);
subplot(1,6,1),imshow(gambar),title('Citra Asli');
subplot(1,6,2),imshow(kopi),title('Citra Grayscale');
subplot(1,6,3),imshow(contrast),title('Citra Contrast Stretching');
subplot(1,6,4),imhist(gambar),title('Histogram Asli');
subplot(1,6,5),imhist(kopi),title('Histogram Grayscale');
subplot(1,6,6),imhist(contrast),title('Histogram  Contrast Stretching');
