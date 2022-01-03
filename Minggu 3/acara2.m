gambar = imread('ikan.jpg');
ikan = gambar (:,:,3);
negasi = 255-ikan;

subplot(1,6,1),imshow(gambar),title('Citra Asli');
subplot(1,6,2),imshow(ikan),title('Citra Grayscale');
subplot(1,6,3),imshow(negasi),title('Citra Negasi');
subplot(1,6,4),imhist(gambar),title('Histogram Citra Asli');
subplot(1,6,5),imhist(ikan),title('Histogram Citra Grayscale');
subplot(1,6,6),imhist(negasi),title('Histogram Citra Negasi');
