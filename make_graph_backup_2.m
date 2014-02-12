function G = make_graph(result_i)
load('vars');
% junc1(count->pixel), junc2(pixel->count), spix(label->[[x,y];]),
% junc(count) = list of labels
done = containers.Map(-1,1);
Max = -1;
im = imread(sprintf('result/junction_%d.jpg',result_i));
Angle = containers.Map(-1,[2,2,2]);
junc_im = zeros(size(im,1),size(im,2));
G = zeros(count,count);
Neigh = zeros(count,count);
newNeigh = zeros(count,count);
for i=1:count
    labels = junc(i); % can add up in val the nearyby junction's neighbour labels to decrease the red dots !!!!!!!
    neigh = [];
    neigh_expected = 0;
    for j=1:4
        if labels(j) == -1
            break;
        end
        neigh_expected = neigh_expected + 1;
        n = spix(labels(j));
        two = 0;
        for k=j+1:4
            if labels(k) == -1
                break;
            end
            n2 = intersect(n, spix(labels(k)),'rows');
            for l=1:size(n2,1)
                if junc2(sprintf('%d %d',n2(l,1),n2(l,2))) ~= i
                    neigh = [neigh;n2(l,:)];
                    break;
                    
                end
            end
        end
    end
    p1 = sscanf(junc1(i),'%d');
    p1 = p1';
    
    neigh=unique(neigh,'rows');
    if Dead_end(i) == 0 & size(neigh,1) ~= neigh_expected % PROBLEM TO BE ADDRESSED !!
        continue;
    end
    if size(neigh,1) == 0
        continue;
    end
    %     'start'
    %     size(neigh)
    for j=1:size(neigh,1)
        Neigh(i,j) = junc2(sprintf('%d %d',neigh(j,1),neigh(j,2)));
    end
    
    %     'end'
    
    %     Neigh(i,1:10)
    %     Neigh(count) = neigh;
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
    %     if size(neigh,1) == 2 | size(neigh,1) == 1
    %         junc_im(p1(1),p1(2)) = 1;
    %         im = draw_dot(im,p1,[255,0,0]);
    %     else if size(neigh,1) == 3
    %             a = neigh(1,:);
    %             b = neigh(2,:);
    %             c = neigh(3,:);
    %             A = ones(1,12);
    %             A(1) = my_angle(a,b,base);
    %             A(2) = my_angle(a,c,base);
    %             A(3) = my_angle(b,c,base);
    %             A(4) = my_angle(b,a,base);
    %             A(5) = my_angle(c,b,base);
    %             A(6) = my_angle(c,a,base);
    %             for j=7:12
    %                 A(j) = 360-A(j-6);
    %             end
    %             mind = 1000;
    %             for j=1:12
    %                 for k=j+1:12
    %                     for l=k+1:12
    %                         if abs(sum([A(j),A(k),A(l)])-360.0) < mind
    %                             angle = [A(j),A(k),A(l)];
    %                             mind=abs(sum(angle)-360.0);
    %                         end
    %                     end
    %                 end
    %             end
    %             if mind > Max
    %                 Max = mind;
    %             end
    %             angle = sort((angle));
    %             Angle(i) = angle;
    %             if angle(3) > 200
    %                 junc_im(p1(1),p1(2)) = 2;
    %                 im = draw_dot(im,p1,[0,255,255]); % W (cyan)
    %             else if angle(3) > 150
    %                     junc_im(p1(1),p1(2)) = 3;
    %                     im = draw_dot(im,p1,[0,0,255]); % T (blue)
    %                 else
    %                     junc_im(p1(1),p1(2)) = 4;
    %                     im = draw_dot(im,p1,[0,255,0]); % Y (green)
    %                 end
    %             end
    %         else if size(neigh,1) == 4
    %                 junc_im(p1(1),p1(2)) = 5;
    %                 im = draw_dot(im,p1,[255,0,255]); % X (magenta)
    %             end
    %         end
    %     end
    done(i) = 1;
end
'saving'
% imwrite(junc_im,sprintf('result/base_%d.jpg',result_i));
imwrite(im,sprintf('result/result_%d.jpg',result_i));
save(sprintf('result/base_%d.mat',result_i),'junc_im','im');
save(sprintf('result/vars_%d.mat',result_i),'junc1','junc2','G');
save('lodapa', 'Neigh');
win = 10; % 2n+1x2n+1


New_id = containers.Map(-1,-1);
for i=1:count
    p = sscanf(junc1(i),'%d');
    p=p';
    if isKey(New_id,i) ~= 0
        continue;
    end
    for j=p(1)-win:p(1)+win
        for k=p(2)-win:p(2)+win
            if j < 1 | j > s(1) | k < 1 | k > s(2)
                continue;
            end
            if isKey(junc2,sprintf('%d %d',j,k)) == 0
                continue;
            end
            
            id = junc2(sprintf('%d %d', j,k));
            if isKey(New_id,id) == 0
                New_id(id) = i;
            end
            i2 = id;
            ki = 1;
            for z=1:count
                if Neigh(i,z) == 0
                    break;
                end
                
                newNeigh(i,ki) = Neigh(i,z);
                ki = z+1;
            end
            
            for z=1:count
                if Neigh(i2,z) == 0
                    break;
                end
                newNeigh(i,ki) = Neigh(i2,z);
                ki = ki+1;
            end
        end
    end
end
newim = imread(strcat(folder,'/',files(result_i).name));
for i=1:count
    for j=i+1:count
        if G(i,j) == 1
            i2 = New_id(i);
            j2 = New_id(j);
            p1 = sscanf(junc1(i2),'%d');
            p2 = sscanf(junc1(j2),'%d');
            newim = draw_line(newim,p1,p2,[255,0,0]);
        end
    end
end

Neigh = newNeigh;
for lol=1:count
    i = New_id(lol);
    i=lol;
    p1 = sscanf(junc1(i),'%d');
    p1=p1';
    neigh=[];
    for j=1:count
        if Neigh(i,j) == 0
            break;
        end
        neigh = [neigh;Neigh(i,j)];
    end
    for j=1:size(neigh,2)
        neigh(j) = New_id(neigh(j));
    end
    %     neigh
    newim = draw_dot(newim,p1,[255,0,0]);
    for j=1:size(neigh,1)
        p1=sscanf(junc1(neigh(j)),'%d');
        p1=p1';
        newim = draw_dot(newim,p1,[255,255,0]);
    end
    continue;
    if size(neigh,1) == 2 | size(neigh,1) == 1
        %         junc_im(p1(1),p1(2)) = 1;
        newim = draw_dot(newim,p1,[255,0,0]);
    else if size(neigh,1) == 3
            a = sscanf(junc1(neigh(1)),'%d');
            a=a';
            if a(1) == p1(1) & a(2) == p1(2)
                continue;
            end
            b = sscanf(junc1(neigh(2)),'%d');
            b=b';
            %             b = neigh(2,:);
            if b(1) == p1(1) & b(2) == p1(2)
                continue;
            end
            c = sscanf(junc1(neigh(3)),'%d');
            c=c';
            %             c = neigh(3,:);
            if c(1) == p1(1) & c(2) == p1(2)
                continue;
            end
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
                %                 junc_im(p1(1),p1(2)) = 2;
                newim = draw_dot(newim,p1,[0,255,255]); % W (cyan)
            else if angle(3) > 150
                    %                     junc_im(p1(1),p1(2)) = 3;
                    newim = draw_dot(newim,p1,[0,0,255]); % T (blue)
                else
                    %                     junc_im(p1(1),p1(2)) = 4;
                    newim = draw_dot(newim,p1,[0,255,0]); % Y (green)
                end
            end
        else if size(neigh,1) == 4
                %                 junc_im(p1(1),p1(2)) = 5;
                newim = draw_dot(newim,p1,[255,0,255]); % X (magenta)
            end
        end
    end
end
% figure;
% imshow(newim);
imwrite(newim,sprintf('result/lol_%d.jpg',result_i));

% save(sprintf('result/result_%d.mat',result_i),);
% G_spix = construct_graph(G,junc1,junc2);