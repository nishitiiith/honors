function new = distinct_segments(segment)
new = zeros(size(segment));
done = zeros(size(segment));
count=1;
% done=containers.Map(0,1);
for i=1:size(segment,1)
    for j=1:size(segment,2)
        val = segment(i,j);        
        if done(i,j) == 1
            continue;
        end
%         done(i,j) = 1;
        new = bfs(i,j,segment,new,val,count,done);
        count = count + 1;        
        break;
    end
    break;
end