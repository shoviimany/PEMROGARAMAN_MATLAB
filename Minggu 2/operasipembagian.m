A = double(imread('cameraman.tif'));
[r c] = size(A);
for x = 1 : r
    for y = 1 :c
        B(x,y) = A(x,y) / 2;
    end
end
B = clipping(B);
subplot (1,2,1), imshow(uint8(A)),title ('Citra 1');
subplot (1,2,2), imshow(uint8(B)),title ('Citra Pembagian');