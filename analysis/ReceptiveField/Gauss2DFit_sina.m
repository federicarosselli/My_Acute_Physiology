function [fitresult, gof rsq] = Gauss2DFit_sina(im,varargin)
global NN
%gauss2DRotFit(im,fop,title)
%  Create a fit.
%  Input :
%   
%      im  : input image of 2D gaussian
%      fop : fitoptions - a structure with 3 fields : Lower,StartPoint and
%            Upper. Each of the fields is an array of 7 values : 
%            offset
%             amplitude of the 2D gaussian
%             centroid X of the 2D gaussian
%             centroid Y of the 2D gaussian
%             angle of rotation for the 2D gaussian
%             width X of the 2D gaussian
%             width Y of the 2D gaussian
%
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%

if nargin==0
    errordlg('gauss2DRotFit has to be called with at least 1 argument');
    return;
end
[sx,sy,sz]=size(im);
if sz==3
    im=rgb2gray(im);
end
[X,Y]=meshgrid(1:sy,1:sx);
 

mystr='Untitled fit';
 
[xData, yData, zData] = prepareSurfaceData( X,Y, im );

% Set up fittype and options.
ft = fittype( 'a*exp(-((x-x0).^2/2/sigmax^2+(y-y0).^2/2/sigmay^2)) + b', 'independent', {'x', 'y'}, 'dependent', 'z','coefficients',{'b','a','x0','y0','sigmax','sigmay'});


opts = fitoptions(ft);
if numel(varargin)>0
    s=varargin{1};
    if isfield(s,'Lower')
        opts.Lower=s.Lower;
    end
    if isfield(s,'StartPoint')
        opts.StartPoint=s.StartPoint;
    end
    if isfield(s,'Upper')
        opts.Upper=s.Upper;
    end
end
if numel(varargin)==2
    mystr=varargin{2};
end
    
opts.Display = 'Off';
 

% Fit model to data.
[fitresult, gof,fout] = fit( [xData, yData], zData, ft, opts );
fitresult
opts.StartPoint
%gof

yresid=fout.residuals;
SSresid = sum(yresid.^2);
SStotal = (length(zData)-1) * var(zData);
rsq = 1 - SSresid/SStotal   %% measure of goodness of the fit %%% important


% Create a figure for the plots.
% if (exist('hNN','var'))
%     close(hNN)
% end
close(gcf)
figure(NN);

subplot(121)
set(gcf,'Name', '2D Gaussian fit 1' );
set(gcf,'Position',[10,10,900,600]);

% Plot fit with data.

h = plot( fitresult, [xData, yData], zData);
legend( h, mystr, 'im vs. X, Y',  'Location', 'NorthEast' );
% Label axes
xlabel( 'X' );
ylabel( 'Y' );
zlabel( 'im' );
title(['Neuron ', num2str(NN)])        
grid on
colormap(jet);
subplot(122)
imagesc(im)
set(gca,'YDir','normal')
hold on
%circle([fitresult.x0 fitresult.y0],mean([fitresult.sigmax fitresult.sigmay]),1000,'--')
ellipse(fitresult.sigmax,fitresult.sigmay,0,fitresult.x0,fitresult.y0,'b',1000)
xlim([1 11])   
ylim([1 6])
axis equal 
axis off
colorbar
drawnow
 
