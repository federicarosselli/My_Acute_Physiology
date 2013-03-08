function My_Noise

A = imread('1.png');
B = rgb2gray(A);
figure;
imshow(B);

C = imnoise(B, 'gaussian', .02);
imshow(c)

end
