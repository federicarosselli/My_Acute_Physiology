 Image=H;
 R=30;
 x0=0;
 y0=0;
 

 
 
%  Xp_MIN=tan(alpha_X-2*asin(Lx/(4*R)))*R;
%  Xp_MAX=tan(alpha_X+2*asin(Lx/(4*R)))*R;
% 
%  Yp_MIN=tan(alpha_Y-2*asin(Ly/(4*R)))*R;
%  Yp_MAX=tan(alpha_Y+2*asin(Ly/(4*R)))*R;
 
 Xp_MIN=-103.8/2;
 Xp_MAX=103.8/2;
 Yp_MIN=-57.8/2;
 Yp_MAX=57.8/2;
 
 Lx=R*sin(atan(Xp_MIN/sqrt(R^2)))*2;
 Ly=R*sin(atan(Yp_MIN/sqrt(R^2)))*2;
 
 [Nx Ny]=size(Image);
 alpha_X=atan(x0/R);
 alpha_Y=atan(y0/R);

 X=linspace(-Lx/2,Lx/2,round(Nx));
 Y=linspace(-Ly/2,Ly/2,round(Ny));

YP=linspace(Yp_MIN,Yp_MAX,round(3*size(H,1)/5));
XP=linspace(Xp_MIN,Xp_MAX,round(3*size(H,2)/5));
IM=zeros(Nx,Ny);
% tic;
n=0;
 for ix=1:Nx
     for iy=1:Ny
% n=n+1;
% if rem(n,2)==0
% tii(1)=toc;
% else
% tii(2)=toc;
% end
% if n>2 & rem(n,2)~=0
% ttii=diff(tii);
% disp([num2str((Nx*Ny-n)*(ttii)/60),' mins remain'])
% end

Xx=X(ix);
Yy=Y(iy);
Ry=sqrt(R^2-Yy^2);
Rx=sqrt(R^2-Xx^2);
LLXX=2*asin(Xx/(2*Ry));
LLYY=2*asin(Yy/(2*Rx));

xx=tan(alpha_X+LLXX)*R;
yy=tan(alpha_Y+LLYY)*R;

xxyy=sqrt(xx^2+yy^2);

[iix nx]=min(abs(XP-xx));
[iiy ny]=min(abs(YP-yy));

% nx=round((xx-Xp_MIN)*100/(Xp_MAX-Xp_MIN))+1;
% ny=round((yy-Yp_MIN)*100/(Yp_MAX-Yp_MIN))+1;

IM(nx,ny)=Image(ix,iy);
     end
 end

% IM=Gnomonic(H,0,0,3,4,4);

% h=pcolor(IM);
% colormap(gray)
% axis image
% set(h,'EdgeColor','none')
% set(gca,'xtick',[],'ytick',[])
% set(gca,'TickLength',[0 0])
% %whitebg([0 0 0]);
% set(gcf,'Color',[0,0,0])
% set(gcf, 'InvertHardCopy', 'off');
