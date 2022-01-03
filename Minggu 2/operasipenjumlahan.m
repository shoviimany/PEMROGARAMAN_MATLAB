A = double(imread('cameraman.tif'));
B = double(imread('rice.png'));
[r1 c1] = size(A);
[r2 c2] = size(B);
if (r1 == r2) && (c1 == c2)
    for x = 1 : r1
        for y = 1 : c1
            C(x,y) = A(x,y) + B(x,y);
        end
    end
end
C = clipping(C);
C=uint8(C);
subplot (1,3,1), imshow(uint8(A)), title ('Citra 1');
subplot (1,3,2), imshow(uint8(B)), title ('Citra 2');
subplot (1,3,3), imshow(uint8(C)), title ('Citra Penjumlahan');