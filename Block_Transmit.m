%该文件为成块传输系统
%对于非常大的文件，其整体运算速度很慢，故将图片分快处理
close all;
clear;
clc;
tic
img = trans('/Users/ComingWind/Desktop/关爱码农.jpg');
toc