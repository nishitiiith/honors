load('catalog.mat');
k=catalogx.keys;
for i=2:size(k,2)
    if isKey(final_stats_x,k(i)) == 1
        final_stats_x(char(k(i))) = final_stats_x(char(k(i))) + catalogx(char(k(i)));
    else 
        final_stats_x(char(k(i))) = catalogx(char(k(i)));
    end
end

k=catalogy.keys;
for i=2:size(k,2)
    if isKey(final_stats_y,k(i)) == 1
        final_stats_y(char(k(i))) = final_stats_y(char(k(i))) + catalogy(char(k(i)));
    else 
        final_stats_y(char(k(i))) = catalogy(char(k(i)));
    end
end


k=catalogt.keys;
for i=2:size(k,2)
    if isKey(final_stats_t,k(i)) == 1
        final_stats_t(char(k(i))) = final_stats_t(char(k(i))) + catalogt(char(k(i)));
    else 
        final_stats_t(char(k(i))) = catalogt(char(k(i)));
    end
end


k=catalogw.keys;
for i=2:size(k,2)
    if isKey(final_stats_w,k(i)) == 1
        final_stats_w(char(k(i))) = final_stats_w(char(k(i))) + catalogw(char(k(i)));
    else 
        final_stats_w(char(k(i))) = catalogw(char(k(i)));
    end
end

save('final_stats','final_stats_x','final_stats_y','final_stats_t','final_stats_w');
    