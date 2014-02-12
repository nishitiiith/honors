function [val,total_values] = check_edge(i,j,segments,limit,s)
val = [segments(i,j),-1,-1,-1];
found = 0;
total_values = 1;
val(1) = segments(i,j);
for l=i-limit:i+limit
    for k=j-limit:j+limit
        if l < 1 | l > s(1) | k < 1 | k > s(2)
            continue;
        end
        found=0;
        for p=1:total_values
            if segments(l,k) == val(p)
                found=1;
                break;
            end
        end
        if found == 0
            total_values = total_values + 1;
            val(total_values) = segments(l,k);
        end
    end
end