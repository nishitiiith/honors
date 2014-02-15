function threshold(th,fileno);
% close all;
load(sprintf('depth/depth_%d.mat',fileno));
im = zeros(size(depthI));
n = zeros(size(normI));
for i=1:size(depthI,1)
    for j=1:size(depthI,2)
        if depthI(i,j) < th
            im(i,j) = depthI(i,j);
            n(i,j,:) = normI(i,j,:);
        end
    end
end
imshow(im,[]);
figure;
imshow(n);
figure;
imshow(depthI,[]);
%%