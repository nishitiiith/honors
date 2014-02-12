% To construct graph where : nodes are the superpixel contors 

% junc1(count->pixel), junc2(pixel->count)
% G[i,j] = 1 if ith and jth junction share an edge AND 0 otherwise
% G_spix[i,j] = 1 if ith and jth superpixel contour share and edge AND 0
% otherwise
function [Gnew, G_spix,E] = construct_grpah(G,junc1,junc2)

% 1.
% Assign unique number to each supierpixel contor and map it as 
%               E(e) = [k,l] 
% where k and l are two junctions and e is a superpixel contour
Gnew = G;
E = containers.Map(-1,'0 0');
count = 1;
for i=1:size(G,1)
    for j=i+1:size(G,2)
        if G(i,j) == 1
            E(count) = sprintf('%d %d', i, j);
            Gnew(i,j) = count;
            Gnew(j,i) = count;
            count = count + 1;
        end
    end
end
% 2. 
% Construct the graph, where G_spix(i,j) = 1 if E(i) intersect E(j) has a
% junction.
G_spix = zeros(count,count);
for i=1:count-1
    for j=1+1:count-1
        p1 = sscanf(E(i),'%d');
        p2 = sscanf(E(j),'%d');
        p1=p1';
        p2=p2';
        if size(intersect(p1,p2),2) == 1
            G_spix(i,j) = 1;
        end
    end
end       