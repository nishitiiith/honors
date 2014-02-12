function new = bfs(p,q,I,new,val,replace_value,done)
[I(p,q),val]
[p,q]
if I(p,q) ~= val
    return;
end
if done(p,q) == 1
    'done return'
    return;
end
done(p,q) = 1;
s = size(I);
new(p,q) = replace_value;
for i=p-1:p+1
    if i < 1
        continue;
    end
    if i > s(1)
        return;
    end
    for j=q-1:q+1
        if j < 1
            continue;
        end
        if j > s(2)
            break;
        end
        new = bfs(i,j,I,new,val,replace_value,done);        
    end
end