%%
%creates a video of the radial motion of dots from a source
%centered in the middle of the frame


%%
%fundamental parameters
size=[1080 1920]; %size of the frame
n_dots=300; %n. of dots
true_r_dots=5; %true size of the dots in pixels
center = size/2;
scale=10;



factor=1; %
r_dots=factor*true_r_dots;
%other parameters
max_iterations = 1e5; %number of trials for the random sampling
max_it=100;
%your directory here
directory='D:\source_radial_matlab';
%%
files=dir(directory);
files=files(3:end);
for i=1:length(files)
    filename = strcat(directory,'\\',files(i).name);
    delete(filename);
end

%%





%define the matrix image
M=factor*size(1);
N=factor*size(2);
A=zeros(M,N);


X=zeros(1,2*n_dots);
Y=zeros(1,2*n_dots);

%%
%generates initial configuration
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


Xt=X;
Yt=Y;
dX2=zeros(1,2*n_dots);
dY2=zeros(1,2*n_dots);
dP = sqrt(dX2+dY2);

dimXt = n_dots;
dimYt = n_dots;

[rr cc] = meshgrid(1:N,1:M);
G = fspecial('gaussian',[3 3],3);

for i=1:max_it
    
    i/max_it
    
    dX2=(Xt - center(2)).^2;
    dY2=(Yt - center(1)).^2;
    dP = sqrt(dX2+dY2);
    
    
    %recalculate position and add a new dot near the center
    Dx = (Xt - center(2))./dP;
    Dy = (Yt - center(1))./dP;
    
    Xt = Xt + Dx;
    Yt = Yt + Dy;
    
    
    %adds a new dot
    dimXt=dimXt+1;
    dimYt=dimYt+1;
    Xt(dimXt) = center(2) + scale*randn(1,1);    
    Yt(dimYt) = center(1) + scale*randn(1,1);
    
    %%
    %build up the image
    
    A=zeros(M,N);
    
    if(i < 10 )
        num_string=strcat('00',num2str(i));
    end
    if( (i >= 10) && (i < 100) )
        num_string=strcat('0',num2str(i));
    end;
    if(i >= 100 )
        num_string=num2str(i);
    end;
    
    
    destfile=strcat(directory,'\\',num_string,'.png');
    
    
    
    for k=1:dimXt
        A(sqrt((rr-Xt(k)).^2+(cc-Yt(k)).^2)<=r_dots) = 1;
    end
    %A2 = imresize(A, [size(1) size(2) ]);
    A3 = imfilter(A,G,'same');
    imwrite(A3,destfile);

end




