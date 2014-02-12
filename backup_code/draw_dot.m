function im = draw_dot(im,p,color,window)
% size=uint32(size);
% size
for k=p(1)-window:p(1)+window
    for l=p(2)-window:p(2)+window
%         [k,l]
        if k < 1 | k > size(im,1) | l < 1 | l > size(im,2)
            continue;
        end
        im(k,l,:) = color;
    end
end