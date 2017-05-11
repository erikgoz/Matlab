function [pixel_labels] = Lab3_KMeans( image, nColors, iterations)
%image, nColors, iterations
%outputs matrix of mapped colors

%Convert to L*a*b* Color Space
cform = makecform('srgb2lab');
lab_he = applycform(image,cform);  %converted image

%classify colors
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

color

% repeat the clustering 10 times to avoid local minima
[cluster_idx, colorMap] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',iterations);
%colorMap = lab2rgb(colorMap)

%label pixels
pixel_labels = reshape(cluster_idx,nrows,ncols);

imshow(pixel_labels,[])


end

