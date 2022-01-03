gambar = imread('mangga.jpg');
blue = gambar(:,:,3);
[M,N] = size(blue);
B_seg = zeros(M,N);
for k = 1 : M
    for l = 1 : N
        if blue(k,l)>120
            B_seg(k,l)=0;
        else
            B_seg(k,l)=1;
        end
    end
end
B_seg2=imfill(B_seg);

subplot(1,4,1),imshow(gambar);
subplot(1,4,2),imshow(blue);
subplot(1,4,3),imhist(blue);
subplot(1,4,4),imshow(B_seg2);