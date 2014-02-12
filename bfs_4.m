function done = bfs2(segments)
s = size(segments);
done = zeros(s);
count = 1;
for i=1:s(1)
    for j=1:s(2)
        if done(i,j) == 0 & segments(i,j) ~= -1
            neigh = [i,j];
            done(i,j) = count;
            while size(neigh,1) > 0
                p = neigh(1,:);
                neigh(1,:) = [];
                flag = 0;
                for k=p(1)-1:p(1)+1
                    for l=p(2)-1:p(2)+1
                        if k < 1 | k > s(1) | l < 1 | l > s(2)
                            continue;
                        end
                        if segments(k,l) == -1
                            flag = 1;
                            break;
                        end
                    end
                    if flag == 1
                        break;
                    end
                end
                if flag == 1
                    for k=p(1)-1:p(1)+1
                        for l=p(2)-1:p(2)+1
                            if k < 1 | k > s(1) | l < 1 | l > s(2)
                                continue;
                            end
                            done(k,l) = -1;
%                             segments(k,l) = -1;
                        end
                        
                    end
                    continue;
                end
                for k=p(1)-1:p(1)+1
                    for l=p(2)-1:p(2)+1
                        if k < 1 | k > s(1) | l < 1 | l > s(2)
                            continue;
                        end
                        if done(k,l) == 0 & segments(k,l) == 0
                            done(k,l) = count;
                            neigh=[neigh;k,l];
                        end
                    end
                end
            end
            count = count+1;
        end
    end
end
count