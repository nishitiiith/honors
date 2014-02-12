function im = draw_dot(im,p,color)
for k=p(1)-2:p(1)+2
    for l=p(2)-2:p(2)+2
        if k < 1 | k > size(im,1) | l < 1 | l > size(im,2)
            continue;
        end
        im(k,l,:) = color;
    end
end