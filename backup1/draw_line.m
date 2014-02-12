function I = draw_line(I,p1,p2,color)
dx = abs(p2(1)-p1(1));
dy = abs(p2(2)-p1(2));
if p1(1) < p2(1) 
    sx = 1;
else
    sx = -1;
end
if p1(2) < p2(2) 
    sy = 1;
else 
    sy = -1;
end
err = dx-dy;
while 1
%     p1
%     p2
    I(p1(1),p1(2),:) = color;
    if p1(1) == p2(1) & p1(2) == p2(2)
        break;
    end
    e2 = 2*err;
    if e2 > -dy
        err = err - dy;
        p1(1) = p1(1) + sx;
    end
    if p1(1) == p2(1) & p1(2) == p2(2)
        I(p1(1),p1(2),:) = color;
        break;
    end
    if e2 < dx
        err = err + dx;
        p1(2) = p1(2) + sy;
    end   
end


% Algorithm : http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
