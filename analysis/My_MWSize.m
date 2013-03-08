function My_MWSize (my_size)

%%remember: tan((screen_res(1)/d))=my_deg/2

%my_size = 30; MW size in deg
screen_res = [1920.0, 1080.0];  %% in pixels
%screen_size = [47.7, 26.9];
screen_size = [103.8, 58.8]; %% in cm, accordin to the setup variable for tg screen
d = 30; %% distance from screen in cm

my_size_rad = my_size*pi/180;
mw_size = 1.1*(2*d*(tan(my_size_rad)/2))



end