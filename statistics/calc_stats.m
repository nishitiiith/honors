function calc_stats(mat_file,base_file,vars_file)
load(mat_file); % numJ,stats,structA
load(base_file); % im,junc_im
load(vars_file); % junc,junc1,junc2,G
% size(G)
for i=1:size(structA,2)
    
    Y = round(structA(i).pX);
    X = round(structA(i).pY);
    type = structA(i).Type;
    if type == 'r' % concave
        edge = 2;
    else if type == 'g' % convex
            edge = 3;
        else if type == 'b' % occluding
                edge = 4;
            end
        end
    end
    %     X
    %     Y
    %     for j=1:size(X,1)
    %         junc_im(X(j),Y(j))
    %     end
    %     break;
    for j=1:size(X,1)-1
        
        key1=sprintf('%d %d', X(j), Y(j));
        key2=sprintf('%d %d', X(j+1), Y(j+1));
        if isKey(junc2,key1) + isKey(junc2,key2) < 2
            'haha';
            continue;
            %         else
            
        end
        p = junc2(key1);
        q = junc2(key2);
        if G(p,q) == 0
            continue;% 'yahooo'
        end
        G(p,q) = edge;G(q,p) = edge;
        sprintf('G(%d,%d) = %d',p,q,edge);
    end
end
catalogw = containers.Map('-1 -1 -1 -1',-1);
catalogt = containers.Map('-1 -1 -1 -1',-1);
catalogy = containers.Map('-1 -1 -1 -1',-1);
catalogx = containers.Map('-1 -1 -1 -1',-1);
% concave,convex,occluding

for i=1:size(G,1)
    cat = [0,0,0,0];
    p = sscanf(junc1(i),'%d');
    p = p';
    if junc_im(p(1),p(2)) < 2
        continue;
    end
    total_neigh = 0;
    for j=1:size(G,1)
        if j == i
            continue;
        end
        if G(i,j) == 0
            continue;
        end
        total_neigh = total_neigh + 1;
        if G(i,j) == 2 % concave
            cat(1) = cat(1)+1;
        else if G(i,j) == 3 % convex
                cat(2) = cat(2) + 1;
            else if G(i,j) == 4 % occluding
                    cat(3) = cat(3) + 1;
                else %if G(i,j) == 1
                    cat(4) = cat(4) + 1;
                    %                     end
                end
            end
        end
    end
    Ind = junc_im(p(1),p(2));
    
    Key = sprintf('%d %d %d %d',cat(1),cat(2),cat(3),cat(4));
    if Ind == 2 % w
        if total_neigh ~= 3
            'blah'
        end
        if isKey(catalogw,Key) == 1
            catalogw(Key) = catalogw(Key) + 1;
        else
            catalogw(Key) = 1;
        end
    else if Ind == 3 %t
            if total_neigh ~= 3
                'blah'
            end
            if isKey(catalogt,Key) == 1
                catalogt(Key) = catalogt(Key) + 1;
            else
                catalogt(Key) = 1;
            end
        else if Ind == 4 %y
                if isKey(catalogy,Key) == 1
                    catalogy(Key) = catalogy(Key) + 1;
                else
                    catalogy(Key) = 1;
                end
            else if Ind == 5%x
                    
                    if isKey(catalogx,Key) == 1
                        catalogx(Key) = catalogx(Key) + 1;
                    else
                        catalogx(Key) = 1;
                    end
                end
            end
        end
    end
end
save('catalog','catalogw','catalogt','catalogy','catalogx');
