function mw_size2 = My_MWSize2 (my_size)

%e.g. my_size = 30; MW size in deg

mw_size2 = (8.4e-05*(my_size.^3)) - (0.01*(my_size.^2)) + (1.1*my_size - 6.9)


end