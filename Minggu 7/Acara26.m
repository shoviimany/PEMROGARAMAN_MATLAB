I=imread('ijazah.jpeg');
hpf1=[-1 -1 -1;-1 8 -1;-1 -1 -1];
hpf2=[0 -1 0;-1 5 -1; 0 -1 0];
hpf3=[1 -2 1;-2 5 -2; 1 -2 1];
J1=uint8(convn(double(I),hpf1,'same'));
J2=uint8(convn(double(I),hpf2,'same'));
J3=uint8(convn(double(I),hpf3,'same'));

subplot(1,4,1),imshow(I),title('Citra Asli');
subplot(1,4,2),imshow(J1),title('Citra HPF1');
subplot(1,4,3),imshow(J2),title('Citra HPF2');
subplot(1,4,4),imshow(J3),title('Citra HPF3');