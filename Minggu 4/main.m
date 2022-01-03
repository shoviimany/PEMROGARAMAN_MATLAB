x=imread('stiker.jpg');
xg=rgb2gray(x);

xd=double(xg);
h=[1 1 1;1 1 1;1 1 1]/9;

yd=konvolusi(h,xd);
y=uint8(yd);

subplot(1,2,1), imshow(x), title('Gambar Asli');
subplot(1,2,2), imshow(y), title('Smooth Filter');
