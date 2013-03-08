function My_Noise

cd RandomDots_1

mkdir ('gaussian')
for i=1 %:242
A = imread(num2str(i),'png');
B = rgb2gray(A);

%h = fspecial('disk', 10);
h = fspecial('gaussian', [452 603], 1);
C = imfilter(B,h);
%C = imnoise(B, 'speckle', .05);
%saveas(figure(nn),[ww,'/Results_Movies/PSTH_',num2str(nn),'.jpeg']) 

imwrite (C, [cd,'/gaussian/',num2str(i), '.png'])
end
