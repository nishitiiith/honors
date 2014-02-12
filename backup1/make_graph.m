function G = make_graph(result_i)
load('vars');
% junc1(count->pixel), junc2(pixel->count), spix(label->[[x,y];]),
% junc(count) = list of labels
done = containers.Map(-1,1);
Max = -1;
im = imread('result.bmp');
Angle = containers.Map(-1,[2,2,2]);
junc_im = zeros(size(im,1),size(im,2));
G = zeros(count,count);
for i=1:count
    labels = junc(i);
    neigh = [];
    neigh_expected = 0;
    for j=1:4
        if labels(j) == -1
            break;
        end
        neigh_expected = neigh_expected + 1;
        n = spix(labels(j));
        for k=j+1:4
            if labels(k) == -1
                break;
            end
            n2 = intersect(n, spix(labels(k)),'rows');
            for l=1:size(n2,1)
                if junc2(sprintf('%d %d',n2(l,1),n2(l,2))) ~= i
                    neigh = [neigh;n2(l,:)];
                end
            end
        end
    end
    neigh=unique(neigh,'rows');
    if Dead_end(i) == 0 & size(neigh,1) ~= neigh_expected % PROBLEM TO BE ADDRESSED !!
        continue;
    end
    if size(neigh,1) == 0
        continue;
    end
    p1 = sscanf(junc1(i),'%d');
    p1 = p1';
    
    for j=1:size(neigh,1)
        p2=neigh(j,:);
        if isKey(done,junc2(sprintf('%d %d',p2(1),p2(2)))) ~= 1
            im = draw_dot(im,p2,[255,0,0]);
            junc_im(p2(1),p2(2)) = 1;
        end        
        G(i,junc2(sprintf('%d %d', neigh(j,1),neigh(j,2)))) = 1;
        G(junc2(sprintf('%d %d', neigh(j,1),neigh(j,2))),i) = 1;        
        im = draw_line(im,p1,p2,[255,255,0]);
    end
    base = p1;
    if size(neigh,1) == 2 | size(neigh,1) == 1
        junc_im(p1(1),p1(2)) = 1;
        im = draw_dot(im,p1,[255,0,0]);
    else if size(neigh,1) == 3
            a = neigh(1,:);
            b = neigh(2,:);
            c = neigh(3,:);
            A = ones(1,12);
            A(1) = my_angle(a,b,base);
            A(2) = my_angle(a,c,base);
            A(3) = my_angle(b,c,base);
            A(4) = my_angle(b,a,base);
            A(5) = my_angle(c,b,base);
            A(6) = my_angle(c,a,base);
            for j=7:12
                A(j) = 360-A(j-6);
            end
            mind = 1000;
            for j=1:12
                for k=j+1:12
                    for l=k+1:12
                        if abs(sum([A(j),A(k),A(l)])-360.0) < mind
                            angle = [A(j),A(k),A(l)];
                            mind=abs(sum(angle)-360.0);
                        end
                    end
                end
            end
            if mind > Max
                Max = mind;
            end
            angle = sort((angle));
            Angle(i) = angle;
            if angle(3) > 200
                junc_im(p1(1),p1(2)) = 2;
                im = draw_dot(im,p1,[0,255,255]); % W (cyan)
            else if angle(3) > 150
                    junc_im(p1(1),p1(2)) = 3;
                    im = draw_dot(im,p1,[0,0,255]); % T (blue)
                else
                    junc_im(p1(1),p1(2)) = 4;
                    im = draw_dot(im,p1,[0,255,0]); % Y (green)
                end
            end
        else if size(neigh,1) == 4
                junc_im(p1(1),p1(2)) = 5;
                im = draw_dot(im,p1,[255,0,255]); % X (magenta)
            end
        end
    end
    done(i) = 1;
end
% I=draw_groundtruth(sprintf('images/%d.jpg',result_i),sprintf('groundtruth/%d.mat',result_i));
% 
% 'marking edges'
% 
% for i=1:count
%     for j=1:count
%         if G(i,j) == 1% & isKey(G, [i,j]) ~= 1
%             p1 = sscanf(junc1(i),'%d');
%             p1 = p1';
%             p2 = sscanf(junc1(j),'%d');
%             p2 = p2';
%             color = [[255,0,0];[0,255,0];[0,0,255];[0,255,255]];
%             for colr=1:4
%                 P = ones(25,2);
%                 total_P = 0;
%                 for k=min(p1(1),p2(1)):max(p1(1),p2(1))
%                     for l=min(p1(2),p2(2)):max(p1(2),p2(2))
%                         if(I(k,l,1) == color(colr,1) & I(k,l,2) == color(colr,2) & I(k,l,3) == color(colr,3))
%                             total_P = total_P+1;
%                             P(total_P,1) = k;
%                             P(total_P,2) = l;
%                         end
%                     end
%                 end
%                 if total_P == 0
%                     continue;
%                 end                
%                 
%                 if color(colr,2) == 255 & color(colr,3) == 255
%                     im = draw_line(im,p1,p2,[0,255,255]);
%                 else if color(colr,2) == 255
%                         im = draw_line(im,p1,p2,[0,255,0]);
%                     else if color(colr,1) == 255
%                             im = draw_line(im,p1,p2,[255,0,0]);
%                         else if color(colr,3) == 255
%                                 im = draw_line(im,p1,p2,[0,0,255]);
%                             end
%                         end
%                     end
%                 end
%                 break;
%                 slope1 = (p2(2)-p1(2))/(p2(1)-p1(1));
%                 slope_diff = 0;
%                 inf_total = 0;
%                 for k = 1:total_P
%                     for l=k+1:total_P
%                         Y = P(l,2)-P(k,2);
%                         X = P(l,1)-P(k,1);
%                         if X == 0
%                             inf_total = inf_total + 1;%re_total_P = re_total_P-1;
%                             continue;
%                         end
%                         slope2 = Y/X;
%                         slope_diff = slope_diff + abs(slope2-slope1);
%                     end
%                 end
%                 slope_diff = slope_diff/(total_P-inf_total);
%                 
%                 
%                 %             [slope1,slope2]
%                 if slope_diff < 0.5
%                     if color(colr,2) == 255 & color(colr,3) == 255
%                         im = draw_line(im,p1,p2,[0,255,255]);
%                     else if color(colr,2) == 255
%                             im = draw_line(im,p1,p2,[0,255,0]);
%                         else if color(colr,1) == 255
%                                 im = draw_line(im,p1,p2,[255,0,0]);
%                             else if color(colr,3) == 255
%                                     im = draw_line(im,p1,p2,[0,0,255]);
%                                 end
%                             end
%                         end
%                     end                    
%                 end
%             end            
%         end
%     end
% end
'saving'
imwrite(junc_im,sprintf('result/base_%d.jpg',result_i));
imwrite(im,sprintf('result/result_%d.jpg',result_i));
save(sprintf('result/base_%d.mat',result_i),'junc_im','im');
save(sprintf('result/vars_%d.mat',result_i),'junc','junc1','junc2','G');