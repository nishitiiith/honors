% load('vars');
% junc1(count->pixel), junc2(pixel->count), spix(label->[[x,y];]),
% junc(count) = list of labels
done = containers.Map(-1,1);

im = imread('result.bmp');
% imshow(im);
figure; imshow(im);
hold on;
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
    neigh_error=0;
    if size(neigh,1) ~= neigh_expected % PROBLEM TO BE ADDRESSED !!
     
        neigh_error = 1;
%         break;
        %         'ye le !'
        %         i
%         continue;
        %         break;
    end
    p1 = sscanf(junc1(i),'%d');
    p1 = p1';
    
    for j=1:size(neigh,1)
        if neigh_error ~= 1
            break;
        end
        p2=neigh(j,:);
        m=p2(1);
        n=p2(2);
        if isKey(done,junc2(sprintf('%d %d',p2(1),p2(2)))) ~= 1
            plot(p2(2),p2(1),'r.','MarkerSize',5)
        end
        %          plot(p2(1),p2(2),5)
        %         plot([p2(2),p2(2)],[p2(1),p2(1)],'Color','g','LineWidth',1)
        plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','y','LineWidth',1)
        
    end
    
    base = p1;
    if neigh_error ~= 1
            done(i) = 1;  
            continue;
    end
    if size(neigh,1) == 3
        a = neigh(1,:);
        b = neigh(2,:);
        c = neigh(3,:);
        A = my_angle(a,b,base);
        B = my_angle(b,c,base);
        C = my_angle(c,a,base);
        angle = [A,B,C];
        if A+B+C < 358
            A = 360-A;
            if A+B+C < 358
                A = 360-A;
                B = 360-B;
                if A+B+C < 358
                    B = 360-B;
                    C = 360-C;
                    if A+B+C < 358
                        angle
                        'we have an angle problem on line 74'
                        break;
                    end
                end
            end
        end
        angle = [A,B,C];
        angle = sort((angle));
        if sum(angle) < 358.0
            angle
            sum(angle)
        end
            
        if angle(3) > 220
            plot(p1(2),p1(1),'y.','MarkerSize',5) % W
        else if angle(3) > 150
                plot(p1(2),p1(1),'b.','MarkerSize',5) % T                
            else
                plot(p1(2),p1(1),'g.','MarkerSize',5) % Y
            end
        end        
    else if size(neigh,1) == 4
            plot(p1(2),p1(1),'b.','MarkerSize',5)
        end
    end
    done(i) = 1;    
end