%generates random disks in two dimensions
clear all
close all
clc

%%
%fundamental parameters
size=[2160 3840];
%size=[452 1206]; %size of the frame
n_dots=800; %n. of dots
%true_r_dots=10; %true size of the dots in pixels
true_r_dots=10;

factor=3; %
r_dots=factor*true_r_dots;
%other parameters
max_iterations = 1e5; %number of trials for the random sampling
%your directory here
mkdir='/Users/davidezoccolan/Desktop/Dots_Acute';
%directory='C:\Users\ansuin\Dropbox\scientific software\python\workspace\Random_Dots\postprocessing';
%destfile=strcat(directory,'Dots_1.png');
%%


%define the matrix image
M=factor*size(1);
N=factor*size(2);
A=zeros(M,N);


X=zeros(1,n_dots);
Y=zeros(1,n_dots);

%%
%generates a random configuration of couples (x,y)
i=0;
added=0;
while(i < max_iterations && added < n_dots)
    i/max_iterations
    %generates random couple
    x = 2*r_dots + (N-4*r_dots)*rand(1,1);
    y = 2*r_dots + (M-4*r_dots)*rand(1,1);

    flag=0; 
    for k=1:added+1
        dist= sqrt((X(k)-x)^2 + (Y(k)-y)^2);
        if dist < 2*r_dots
            flag=1;
        end;
    end;
    
    if (flag == 0)
        X(added+1)=x;
        Y(added+1)=y;
        added=added+1;
        
    end
    i=i+1;
end
%%
%build up the image
[rr cc] = meshgrid(1:N,1:M);

for i=1:n_dots
    A(sqrt((rr-X(i)).^2+(cc-Y(i)).^2)<=r_dots) = 1;
end

if(added < n_dots)
    print('failed ! maybe you should add iterations ...');
end

%%
%show the image and makes a little bit of make up 
figure(1)
imshow(A,[]); 


A2 = imresize(A, [size(1) size(2) ]);
figure(2)
imshow(A2,[]); 


G = fspecial('gaussian',[3 3],3);
A3 = imfilter(A2,G,'same');

figure(3)
imshow(A3,[]); 

%%
%save image

imwrite(A3,['/Users/davidezoccolan/Desktop/Dots_Acute/', 'Dots_3.png']);

close all
