function My_Gaussian %(n)

n = 101; % size of the nxn image of a Gaussian

Gaussian = zeros(n);  % define a n x n matrix of zeros

x = linspace(-2,2,n); % define the values for x and y axes

y = linspace(-2,2,n);

for j=1:n % columns

    for i=1:n % rows

        % as i and j range from 1 to n,

        % x(i) and y(j) will range from -2 to 2.

        % We can then do math on x(i) and y(j) for each pixel:

        Gaussian(i,j) = exp(-x(i).^2-y(j).^2);

    end

end  

figure(1)

clf

image((255*Gaussian)+1);

colormap(gray);

axis equal

axis off  

end

