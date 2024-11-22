clc
clearvars
close all

A = imread("bots.jpg");
imshow(A);

R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);

Eg=rgb2gray(A);
figure
imshow(R);


ByN=Eg <= 127;
figure
imshow(ByN);

figure
for i=1:255
    ByN = Eg <= 255-i;
    pause(0.1);
    imshow(ByN)
end




