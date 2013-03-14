clear all
close all
clc


%%
%creates a frame of random dots with an anular distribution.
%the average radius is (r_in + r_out)/2
%and the dispersion is controlled by st_deviation_r

%%
%fundamental parameters
size=[2160 3840];
%size=[1080 1920]; %size of the frame
n_dots=600; %n. of dots
r_dots=10; %true size of the dots in pixels

r_in = 1000; %inner radius of the annulus
r_out = 1000; %outer radius of the annulus
st_deviation_r = 200; %standard deviation of the radius

%other parameters
center = size/2;
max_iterations = 1e5; %number of trials for the random sampling
%your directory here
directory='/Users/labuser/Desktop/Dots_Acute';
destfile=strcat(directory,'/','starwars.png');
%%
%clear directory content
files=dir(directory);
files=files(3:end);
for i=1:length(files)
    filename = strcat(directory,'/',files(i).name);
    delete(filename);
end

%%

%data structures needed
M=size(1);
N=size(2);
A=zeros(M,N);

X=zeros(1,n_dots);
Y=zeros(1,n_dots);

%%
%generates anular distribution
i=0;
added=0;
while(i < max_iterations && added < n_dots)
    i/max_iterations
    %generates random distance and angle
    
    dist=(r_in+r_out)/2 + st_deviation_r*randn(1,1); %random number in [r_in,r_out]
    %dist=r_in+ (r_out-r_in)*rand(1,1); %random number in [r_in,r_out]
    
    angle=2*pi*rand(1,1); %random number in [0,2*pi]
    
    
    
    
    
    %convert in x,y coordinates
    
    x = center(2) + dist*cos(angle);
    y = center(1) + dist*sin(angle);

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


    
%%
%build up the image

A=zeros(M,N);
[rr cc] = meshgrid(1:N,1:M);
G = fspecial('gaussian',[3 3],3);

    
for k=1:n_dots
    A(sqrt((rr-X(k)).^2+(cc-Y(k)).^2)<=r_dots) = 1;
end

%A2 = imresize(A, [size(1) size(2) ]);
    

A3 = imfilter(A,G,'same');
    
imwrite(A3,destfile);


imshow(A3)



