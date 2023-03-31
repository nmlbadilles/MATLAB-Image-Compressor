clear all, close all, clc

A=imread('C:\Users\nilgendary\Desktop\Scenery.jpg');     %select image to compress; input the file's path
B=rgb2gray(A);  %convert input image from rgb to grayscale for faster processing
figure(1);
imagesc(A);     %displays the input image
set(gcf,'Position',[1500 100 size(A,2) size(A,1)])  %sets the bounds and positioning of the displayed image

%% FFT 
Bt=fft2(B); %Fast Fourier Transform B
Blog=log(abs(fftshift(Bt))+1);  
%shifts the coefficients towards the origin, 
%take their absolute values, 
%adds 1 since most values are near zero, 
%take these values to logarithmic scale to make them more pronounced in the graph
figure(2);
imshow(mat2gray(Blog),[]); %displays the plot of the coefficients
set(gcf,'Position',[1500 100 size(A,2) size(A,1)]) %sets the bounds and positioning of the plot

%% Compression
Btsort=sort(abs(Bt(:)));    %sorts the absolute values of the coefficients in ascending order
figure(3);
keep = input('Threshold \n'); %inputs the value of the threshold, how much of the coefficients the program will keep
    
    th = Btsort(floor((1-keep)*length(Btsort)));    
    in = abs(Bt)>th; %index value, which coefficients the program will keep
    AL = Bt.*in; %deletes the other coefficients
    Al = uint8(ifft2(AL)); %inverse fft, reconstructs the image back
    imshow(Al) %displays the compressed image
    title(['',num2str(keep*100),'%'],'FontSize',36)
set(gcf,'Position',[1750 100 1750 2000])