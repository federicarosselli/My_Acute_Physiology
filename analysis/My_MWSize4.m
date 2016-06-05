function mw_size4 = My_MWSize4 (my_size)

%e.g. my_size = 30; MW size in deg

mw_size4 = 0.00038*(my_size.^5) - (0.3*(my_size.^4)) + (94*(my_size.^3)) - (1.5e+04*(my_size.^2)) + (1.1e+06*(my_size)) - 3.6e+07

end

