function My_MWSize3 (my_size)

%e.g. my_size = 30; MW size in deg

mw_size3 = (7.2e-14*(my_size^7)) - (5.4e-11*(my_size^6)) + (1.6e-08*(my_size^5)) - (2.5e-06*(my_size^4)) + (0.00029*(my_size^3)) - (0.019*(my_size^2)) + (1.3*my_size - 8.5)

%mw_size3 = (1.1e-14*(my_size^9)) - (8.3e-12*(my_size^8)) + (2.8e-09*(my_size^7)) - (5.3e-07*(my_size^6)) + (6.1e-05*(my_size^5)) - (0.0045*(my_size^4)) + (0.21*(my_size^3)) - (5.7*(my_size^2)) + (86*my_size - 5.3e+02)

end

