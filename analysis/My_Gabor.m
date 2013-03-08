function My_Gabor %(n)

clear all;

close all;

 

% define the Gabor's parameters:

n = 201; %resolution of the image

width = 1;  %1/e half width of Gaussian

spatialFrequency = 3; 

%spatial frequency of the sinewave carrier (cycles/image)

 

% Use meshgrid to create matrices X and Y that range from -pi to pi;

[X,Y] = meshgrid(linspace(-pi,pi,n));

 

% Sinusoid on the matrix X makes a vertical grating.

sinusoid = sin(spatialFrequency*X);

 

% Gaussian aperture:

Gaussian = exp( -(X.^2+Y.^2)/width^2);

 

% A Gabor is the product of the sinusoid and the Gaussian

Gabor = sinusoid.*Gaussian;

 

% Show the image using the usual commands:

figure(1)

image( (Gabor+1)*127.5);  %scale Gabor between 0 and 255

axis equal

axis off

colormap(gray(256))  


% Creates a grating windowed by a Gaussian where the following

% parameters can vary:

% size

% contrast

% spatial frequency

% orientation

% phase

 

% define the Gabor's parameters:

 

center = [1,1]; %[0,0] is the middle of the image, [pi,pi] is the lower right

orientation = pi/4; %radians (pi/4 = 45 degrees)

width = .5;  %1/e half width of Gaussian

spatialFrequency = 6;  %spatial frequency of Sinewave carrier (cycles/image)

phase = -pi/2; %spatial phase of sinewave carrier (radians)

contrast = 0.75;  %contrast ranges from 0 to 1;

 

n = 201; %resolution of the image  

 

% Use meshgrid to define matrices X and Y that range from -pi to pi;

[X,Y] = meshgrid(linspace(-pi,pi,n));

 

%Create an oriented 'ramp' matrix as a linear combination of X and Y. For

%example, when orientation = 0, cos = 1 and sin = 0 so ramp = X.  When

%orientation is pi/2 then cos = 0; sin = 1 and ramp = Y. 

 

ramp = cos(orientation)*(X-center(1)) + sin(orientation)*(Y-center(2));

 

% let's take a quick look at ramp

figure(1)

imagesc(ramp)

colormap(gray(256))

axis off

axis equal  

end

