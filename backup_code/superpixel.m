regionSize = 50
regularizer = 0.5
I = imread(image);
im = im2single(I);
segments = vl_slic(single(I), regionSize, regularizer) ;
imshow(segments,[]);
save('filename.mat','segments')