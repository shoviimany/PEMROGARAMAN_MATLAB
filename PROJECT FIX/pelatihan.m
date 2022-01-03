clc; clear; close all; warning off all;

%%% cabai matang
% membaca file citra
nama_folder = 'DATA LATIH/MATANG';
nama_file = dir(fullfile(nama_folder,'*.jpg'));
jumlah_file = numel(nama_file);

%menginisialisasi variabel ciri_matang dan target_matang
ciri_matang = zeros(jumlah_file,3);
target_matang = cell(jumlah_file,1);

% melakukan pengolahan citra terhadap seluruh file
for n = 1:jumlah_file
    %membaca file RGB
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    %figure, imshow(Img)
    
    %konfersi RGB ke grayscale
    Img_gray = rgb2gray(Img);
    %figure, imshow(rgb2gray)
    
    %konfersi grayscale ke biner
    bw = imbinarize(Img_gray);
    %figure, imshow(bw)
    
    %melakukan operasi komplemen
    bw = imcomplement(bw);
    %figure, imshow(bw)
    
    %melakukan operasi morfologi dari hasil segmentasi
    %filling holes
    bw = imfill(bw,'holes');
    %figure, imshow(bw)
    
    %area opening
    bw = bwareaopen(bw, 1000);
    %figure, imshow (bw)
    
    %ekstraksi ciri RGB
    R = Img(:,:,1);
    G = Img(:,:,2);
    B = Img(:,:,2);
    R(~bw) = 0;
    G(~bw) = 0;
    B(~bw) = 0;
    %RGB = cat(3,R,G,B);
    %figure, imshow(RGB)
    
    Red = sum(sum(R))/sum(sum(bw));
    Green = sum(sum(G))/sum(sum(bw));
    Blue = sum(sum(B))/sum(sum(bw));
    
    %ekstraksi ciri HSV
    HSV = rgb2hsv(Img);
    %figure, imshow(HSV)
    
    H = HSV(:,:,1);
    S = HSV(:,:,2);
    V = HSV(:,:,3);
    H(~bw) = 0;
    S(~bw) = 0;
    V(~bw) = 0;
    Hue = sum(sum(H))/sum(sum(bw));
    Saturation = sum(sum(S))/sum(sum(bw));
    Value = sum(sum(V))/sum(sum(bw));
    
    %ciri_matang dengan ciri hasil ekstraksi
    ciri_matang(n,1) = Hue;
    ciri_matang(n,2) = Saturation;
    ciri_matang(n,3) = Value;
    
    %target_matang
    target_matang{n} = 'Cabai Matang';
end


%%% cabai mentah
% membaca file citra
nama_folder = 'DATA LATIH/MENTAH';
nama_file = dir(fullfile(nama_folder,'*.jpg'));
jumlah_file = numel(nama_file);

%menginisialisasi variabel ciri_mentah dan target_mentah
ciri_mentah = zeros(jumlah_file,3);
target_mentah = cell(jumlah_file,1);

% melakukan pengolahan citra terhadap seluruh file
for n = 1:jumlah_file
    %membaca file RGB
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
    %figure, imshow(Img)
    
    %konfersi RGB ke grayscale
    Img_gray = rgb2gray(Img);
    %figure, imshow(rgb2gray)
    
    %konfersi grayscale ke biner
    bw = imbinarize(Img_gray);
    %figure, imshow(bw)
    
    %melakukan operasi komplemen
    bw = imcomplement(bw);
    %figure, imshow(bw)
    
    %melakukan operasi morfologi dari hasil segmentasi
    %filling holes
    bw = imfill(bw,'holes');
    %figure, imshow(bw)
    
    %area opening
    bw = bwareaopen(bw, 1000);
    %figure, imshow (bw)
    
    %ekstraksi ciri RGB
    R = Img(:,:,1);
    G = Img(:,:,2);
    B = Img(:,:,2);
    R(~bw) = 0;
    G(~bw) = 0;
    B(~bw) = 0;
    %RGB = cat(3,R,G,B);
    %figure, imshow(RGB)
    
    Red = sum(sum(R))/sum(sum(bw));
    Green = sum(sum(G))/sum(sum(bw));
    Blue = sum(sum(B))/sum(sum(bw));
    
    %ekstraksi ciri HSV
    HSV = rgb2hsv(Img);
    %figure, imshow(HSV)
    
    H = HSV(:,:,1);
    S = HSV(:,:,2);
    V = HSV(:,:,3);
    H(~bw) = 0;
    S(~bw) = 0;
    V(~bw) = 0;
    Hue = sum(sum(H))/sum(sum(bw));
    Saturation = sum(sum(S))/sum(sum(bw));
    Value = sum(sum(V))/sum(sum(bw));
    
    %ciri_mentah dengan ciri hasil ekstraksi
    ciri_mentah(n,1) = Hue;
    ciri_mentah(n,2) = Saturation;
    ciri_mentah(n,3) = Value;
    
    %target_mentah
    target_mentah{n} = 'Cabai Mentah';
end

%menyusun variabel ciri_latih dan target_latih
ciri_latih = [ciri_matang;ciri_mentah];
target_latih = [target_matang;target_mentah];

%melakukan pelatihan menggunakan algoritma k-nn
Mdl = fitcknn(ciri_latih,target_latih,'NumNeighbors',3);


%menyimpan variaben Mdl hasil pelatihan
save Mdl Mdl