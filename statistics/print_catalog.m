fileID = fopen('final_catalog_x','w');
k=final_stats_x.keys;
fprintf(fileID,'X\n');
fprintf(fileID,'concave convex occluding rest -> count\n');
for i=2:size(k,2)
    ks = char(k(i));
    fprintf(fileID, '%s : %d\n', ks, final_stats_x(ks));
end

fclose(fileID);


fileID = fopen('final_catalog_y','w');
fprintf(fileID,'Y\n');
fprintf(fileID,'concave convex occluding rest -> count\n');
k=final_stats_y.keys;
for i=2:size(k,2)
    ks = char(k(i));
    fprintf(fileID, '%s : %d\n', ks, final_stats_y(ks));
end
fclose(fileID);

fileID = fopen('final_catalog_t','w');
fprintf(fileID,'T\n');
fprintf(fileID,'concave convex occluding rest -> count\n');
k=final_stats_t.keys;
for i=2:size(k,2)
    ks = char(k(i));
    fprintf(fileID, '%s : %d\n', ks, final_stats_t(ks));
end
fclose(fileID);

fileID = fopen('final_catalog_w','w');
fprintf(fileID,'W\n');
fprintf(fileID,'concave convex occluding rest -> count\n');
k=final_stats_w.keys;
for i=2:size(k,2)
    ks = char(k(i));
    fprintf(fileID, '%s : %d\n', ks, final_stats_w(ks));
end
fclose(fileID);