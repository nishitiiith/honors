load filename
im = segments;
final = imread(image);
boundary = zeros(size(im,1),size(im,2));
for i=1:size(im,1)
    for j=1:size(im,2)
        value = im(i,j);
        found = 0;
        for I=i-1:i+1
            if I < 1 || I > size(im,1)
                continue;
            end
            for J=j-1:j+1
                if J < 1 || J > size(im,2)
                    continue;
                end
                if im(I,J) == value
                    value = value;
                else
                    boundary(i,j) = value+im(I,J);
                    final(i,j,:) = [0,0,0];
                    found = 1;
                end
                if found == 1
                    break;
                end
            end
            if found == 1
                break;
            end
        end
        found = 0;
    end
end
imshow(boundary,[]);
figure;
imshow(im);
