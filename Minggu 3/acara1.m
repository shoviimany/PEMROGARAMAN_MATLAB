gambar = imread('mawar.jpg');
mawar = rgb2gray(gambar);
subplot(1,2,1),imshow(mawar),title('Citra Grayscale');
subplot(1,2,2),imhist(mawar),title('Histogram Citra');