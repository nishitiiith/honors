function ans = occluding

ans = 0;
load('result/result_3.mat');
T = zeros(1,total_spix);
S = zeros(1,total_spix);
im = imread('semantic segmentation/10.bmp');
for i=1:size(im,1)
    for j=1:size(im,2)
        if segments(i,j) == 0
            continue;
        end
        T(segments(i,j)) = T(segments(i,j)) + 1;
        if im(i,j,1) == 0 & im(i,j,2) == 0 & im(i,j,3) == 128
            S(segments(i,j)) = S(segments(i,j)) + 1;
        end
    end
end
F=S./T;
save('fraction','F');
count = newcount;
I = imread('images/10.jpg');
for i=1:newcount
    p1 = sscanf(pixel_pos(i),'%d');
    I = draw_dot(I,p1,[255,0,0],2);
    for j=i+1:newcount
        if G(i,j) ~= 0
            %             'ye le'
            
            p2 = sscanf(pixel_pos(j),'%d');
            I = draw_line(I,p1,p2,[255,0,0]);
            
            
        end
    end
end

for i=1:count
    for j=i+1:count
        if G(i,j) ~= 0
            flag = 0;
            if i == 370 & j == 392
                flag = 1;
                'okay..'
            end
            
            neigh1=extract_neigh(junc_neigh(i));
            neigh2=extract_neigh(junc_neigh(j));
            if flag == 1
                [neigh1]
                'and'
                [neigh2]
            end
            two_spix = intersect(neigh1,neigh2);
            if size(two_spix,1) ~= 2
                continue;
            end
            d = abs(F(two_spix(1))-F(two_spix(2)));
            
            if flag == 1
                d
            end
            if d > 0.2
                p1 = sscanf(pixel_pos(i),'%d');
                p2 = sscanf(pixel_pos(j),'%d');
                I = draw_line(I,p1,p2,[255,255,0]);
                I = draw_dot(I,p1,[0,255,0],2);
                I = draw_dot(I,p2,[0,255,0],2);
            end
        end
    end
end
imshow(I);
ans=1;
function neigh = extract_neigh(Neigh)
neigh = [];
for i=1:4
    if Neigh(i) == 0
        break;
    end
    neigh = [neigh;Neigh(i)];
end