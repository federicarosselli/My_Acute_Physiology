function My_Pix2Deg (my_pix_h, my_pix_v)

%%remember: tan((screen_res(1)/d))=my_deg/2
%% atan (height/2)/d*2

%my_deg = 0.25; 
screen_res = [1920.0, 1080.0];  %% in pixels
% screen_size = [47.7, 26.9]; %% behavioral setup accordin to setup
% screen_size = [93, 52]; %% chronic setup
screen_size = [104.3, 58.8]; %% acute setup
%variables
%screen_size = [51.3, 32.6]; %% behavioral setup accordin to specs
% screen_size = [103.8, 58.8]; %% acute setup, in cm, accordin to the setup variable for tg screen
d = 30; %% distance from screen in cm

n_pix_h = screen_res(1)/screen_size(1); %% number of pixels x cm in the horiz dimension
n_pix_v = screen_res(2)/screen_size(2); %% number of pixels x cm in the vertic dimension

my_cm_h = my_pix_h/n_pix_h
my_cm_v = my_pix_v/n_pix_v

my_rad_h = 2*atan(my_cm_h/(2*d))
my_rad_v = 2*atan(my_cm_v/(2*d))


my_deg_h =  my_rad_h*180/pi %% converts my_rad to degs
my_deg_v =  my_rad_v*180/pi



end

