function [ ] = LandClassK( image, numColors, iterations)
%Description:
%LandClassK packages Matlab's example Land classification scripts into
%one convenient & dynamic tool

%Source: https://www.mathworks.com/help/images/land-classification-with-color-features-and-superpixels.html

%Input Parameters:
%'image' == image you would like to classify
%'numColors' == the number of different classes you'd like classified
%'iterations' == the number of iterations used in 'kmeans' 

%convert to Lab color space
imageLab = rgb2lab(image);

%Computes oversementation of image
[L,N] = superpixels(imageLab,20000,'isInputLab',true);
BW = boundarymask(L);
imshow(imoverlay(image,BW,'cyan'))  %image over

%Cell array of pixels in each region
pixelIdxList = label2idx(L);    

%Determine the median of each superpixel region
meanColor = zeros(N,3);
[m,n] = size(L);
for  i = 1:N
	   meanColor(i,1) = mean(imageLab(pixelIdxList{i}));
    meanColor(i,2) = mean(imageLab(pixelIdxList{i}+m*n));
    meanColor(i,3) = mean(imageLab(pixelIdxList{i}+2*m*n));
end

%create distinguishable colors
[idx,cmap] = kmeans(meanColor,numColors,'distance','sqEuclidean','Replicates',iterations);
cmap = lab2rgb(cmap);
Lout = zeros(size(image,1),size(image,2));
for i = 1:N
    Lout(pixelIdxList{i}) = idx(i);
end
figure
imshow(label2rgb(Lout))     %distinguished

figure
imshow(Lout,cmap)           %thematic

end

