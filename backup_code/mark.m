colour = [255,0,0];
d = 2;
im = imread(image);
imsup = imread(image_sup);
for i=1:size(im,1)
    for j=1:size(im,2)
        if im(i,j,1) + im(i,j,2) + im(i,j,3) == 0
            for I = i-d:i+d
                if I < 1 || I > size(im,1)
                    continue;
                end
                for J = j-d:j+d
                   if J < 1 || J > size(im,2)
                       continue;
                   end
                   
                   if imsup(I,J,1) + imsup(I,J,2) + imsup(I,J,3) <50
                        imsup(I,J,:) = colour(:);
                   end
                   
                end
            end
        end
    end
end
imshow(im);
figure();
imshow(imsup);