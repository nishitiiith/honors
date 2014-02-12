load('result/result_3.mat');
% imshow(newim)
im = imread('images/10.jpg');
I = im;
for i=1:newcount
    for j=i+1:newcount
        if G(i,j) ~= 0
%             'ye le'
            p1 = sscanf(pixel_pos(i),'%d');
            p2 = sscanf(pixel_pos(j),'%d');
            I = draw_line(I,p1,p2,[255,0,0]);
        end
    end
end
imshow(I);