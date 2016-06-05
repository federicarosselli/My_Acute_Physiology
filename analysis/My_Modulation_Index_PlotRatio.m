close all
clear all
clc

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/AREAS'];
cd(my_folder)
load Coefficients_Ratio


a = gdivide (F1, F0);
% zmi = gsubtract(F1,Fmean);
% a = gdivide(zmi,Fstd);
b = a(~cellfun(@isempty,a));
c = cell2mat(b);
hist(c)
% colormap winter
