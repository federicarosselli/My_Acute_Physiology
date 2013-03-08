function My_Image_Concatenation

%cd Dots_Behavior/right

% r_first = imread ('19.png');
% r_second = imread ('20.png');

%Dots_right = [r_first r_second];

%imwrite (Dots_right, ['d_right_1', '.png'])

% cd ..
% 
% cd left
% 
% l_first = imread ('123.png');
% l_second = imread ('124.png');
% 
% Dots_left = [l_first l_second];
% 
% imwrite (Dots_left, ['d_left_1', '.png'])
% 
% cd ..

cd REALLY_NO_SPH

% G_1_0_first = imread ('orientation0_spatial frequency_0.03_60.jpg');
% G_1_0_last = imread ('orientation0_spatial frequency_0.03_141.jpg');
% 
% G_1_0 = [G_1_0_first G_1_0_last];

G_2_0_first = imread ('orientation0_spatial frequency_0.05.jpg');

G_2_0 = [G_2_0_first G_2_0_first];

G_3_0_first = imread ('orientation0_spatial frequency_0.1.jpg');

G_3_0 = [G_3_0_first G_3_0_first];

G_4_0_first = imread ('orientation0_spatial frequency_0.4.jpg');

G_4_0 = [G_4_0_first G_4_0_first];

% imwrite (G_1_0, ['G_1_0', '.jpg'])

imwrite (G_2_0, ['G_2_0', '.jpg'])

imwrite (G_3_0, ['G_3_0', '.jpg'])

imwrite (G_4_0, ['G_4_0', '.jpg'])




cd ..


end
