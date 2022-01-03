gambar = imread('hijab.jpeg')
gbr_gray = rgb2gray(gambar);
subplot (1,2,1), imshow(gambar),title('Citra Asli');
subplot (1,2,2), imshow(gbr_gray),title('Citra Grayscale');