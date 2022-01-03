F = imread('hijab.jpeg');
F = rgb2gray(F);
J = clipping(F);
subplot (1,2,1), imshow(F),title('Citra Asli');
subplot (1,2,2), imshow(J),title('Citra Clipping');
