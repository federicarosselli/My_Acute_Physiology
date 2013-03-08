function My_Deg2Pix (my_deg_h, my_deg_v)

%%remember: tan((screen_res(1)/d))=my_deg/2

%my_deg = 0.25; 
screen_res = [1920.0, 1080.0];  %% in pixels
%screen_res = [3840, 2160];
%screen_size = [47.7, 26.9];
screen_size = [103.8, 58.8]; %% in cm, accordin to the setup variable for tg screen
%screen_size = [207.6, 117.6];
d = 30; %% distance from screen in cm

my_rad_h =  my_deg_h*pi/180; %% converts my_degs to rads
my_rad_v =  my_deg_v*pi/180;

n_pix_h = screen_res(1)/screen_size(1); %% number of pixels x cm in the horiz dimension
n_pix_v = screen_res(2)/screen_size(2); %% number of pixels x cm in the vertic dimension

my_cm_h = 2*d*tan(my_rad_h/2)
my_cm_v = 2*d*tan(my_rad_v/2)

my_pix_h = (my_cm_h*n_pix_h)%/1000
my_pix_v = (my_cm_v*n_pix_v)%/1000


end



