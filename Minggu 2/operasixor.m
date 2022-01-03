A = im2bw(imread('cameraman.tif'));
B = im2bw(imread('rice.png'));
C = xor(A,B);
subplot (1,3,1), imshow(A),title ('Citra 1');
subplot (1,3,2), imshow(B),title ('Citra 2');
subplot (1,3,3), imshow(C),title ('Citra XOR');