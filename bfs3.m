function [done,real_count] = bfs2(segments)
s = size(segments);
done = zeros(s);
count = 1;
real_count = [1];
for i=1:s(1)
    for j=1:s(2)
        if done(i,j) == 0 & segments(i,j) == 0
            neigh = [i,j];
            done(i,j) = count;
            sflag = 0;
            while size(neigh,1) > 0
                p = neigh(1,:);
                neigh(1,:) = [];
                flag = 0;
                for k=p(1)-1:p(1)+1
                    for l=p(2)-1:p(2)+1
                        if k < 1 | k > s(1) | l < 1 | l > s(2)
                            continue;
                        end
                        if segments(k,l) == -1 %| (done(k,l) ~= 0 & done(k,l) ~= count)
                            flag = 1;
                        end
                    end
                end
                if flag == 1
%                     count = count + 1;
                    continue;
                end
                if count ~= 1
                    sflag = 1;
%                     count
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
            if sflag 
                real_count = [real_count;count];
                count = count + 1;
            else
                done(i,j) = 0;
            end                
            count = count+1;
        end
%         break;
    end
%     break;
end
count