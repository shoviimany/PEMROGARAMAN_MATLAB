I=imread('ijazah.jpeg');
lpf1=[1/16 1/8 1/16;1/8 1/4 1/8;1/16 1/8 1/16];
lpf2=[1/10 1/10 1/10;1/10 1/5 1/10;1/10 1/10 1/10];
lpf3=[1 1 1;1 1 1;1 1 1]/9;
J1=uint8(convn(double(I),lpf1,'same'));
J2=uint8(convn(double(I),lpf2,'same'));
J3=uint8(convn(double(I),lpf3,'same'));

subplot(1,4,1),imshow(I),title('Citra Asli');
subplot(1,4,2),imshow(J1),title('Citra LPF1');
subplot(1,4,3),imshow(J2),title('Citra LPF2');
subplot(1,4,4),imshow(J3),title('Citra LPF3');