gambar = imread('apel.jpg');
gray = rgb2gray(gambar)
fitur = [gray];
xlswrite('fiturwarna1.xls',fitur);

subplot(1,2,1),imshow(gambar),title('Gambar Asli');
subplot(1,2,2),imshow(gray),title('Gambar Grayscale');
