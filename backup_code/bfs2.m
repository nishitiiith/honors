function done = bfs2(segments)
s = size(segments);
done = zeros(s);
count = 1;
for i=1:s(1)
    for j=1:s(2)
        if done(i,j) == 0    
            neigh = [i,j];
            done(i,j) = count;
            val = segments(i,j);
            while size(neigh,1) > 0
                p = neigh(1,:);
                neigh(1,:) = [];
                for k=p(1)-1:p(1)+1
                    for l=p(2)-1:p(2)+1
                        if k < 1 | k > s(1) | l < 1 | l > s(2)
                            continue;
                        end
                        if done(k,l) == 0 & segments(k,l) == val
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
