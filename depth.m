function ans = depth
% close all;
ans = 0;
load('result/result_3.mat');
load('depth/depth_1.mat');
im = imread('semantic segmentation/image1.bmp');
d = containers.Map(-1,[-1.1,-1.1,-1.1]);
newcount = 0;
% see = [];
for i=1:size(im,1)
    for j=1:size(im,2)        
        if segments(i,j) == 0 | depthI(i,j) == 0
            continue;
        end
        if isKey(d,segments(i,j)) == 0
            d(segments(i,j)) = [depthI(i,j),i,j];
        else
            d(segments(i,j)) = [d(segments(i,j));depthI(i,j),i,j];
        end
        if segments(i,j) > newcount
            newcount = segments(i,j);
        end        
    end
end

th = 5;
th_visible = 2;
meanD = zeros(1,newcount);
I = imread('result/result_3.jpg');
segI = zeros(size(segments));
segN = zeros(size(segments,1),size(segments,2),3);
'k means..'
save('depths','d');
for i=1:total_spix   
    if isKey(d,i) == 0
        continue;
    end
    D = d(i);
    D = D(:,1);
    Dpos = d(i);
    Dpos = Dpos(:,2:3);
    %     Max = max(D);
    cut = max(D)-min(D);
%     [max(D),min(D)]
%     cut = cut/2;
    for j=1:size(D,1)
%         
        if D(j) <= min(D)+cut/2 
            segI(Dpos(j,1),Dpos(j,2)) = D(j);
            segN(Dpos(j,1),Dpos(j,2),:) = normI(Dpos(j,1),Dpos(j,2),:);
        end
    end
    %     if min(D) == max(D)
    %         continue;
    %     end
    %     while 1
    %         try
    %             [IDX, c] = kmeans(D,2);
    %             break;
    %         catch
    %             %         Dpos = d(i);
    %             %         Dpos = Dpos(:,2:3);
    %             %         for j=1:size(D,1)
    %             %             if IDX(j) == minj
    %             %                 segI(Dpos(j,1),Dpos(j,2)) = D(j);
    %             %             end
    %             %         end
    %             %         continue;
    %         end
    %     end
    %     %     if abs(max(D)-min(D)) > th
    %     cmin = min(c);
    %     for j=1:size(c,1)
    %         if c(j) == cmin
    %             minj = j;
    %             break;
    %         end
    %     end
    %     Dpos = d(i);
    %     Dpos = Dpos(:,2:3);
    %     for j=1:size(IDX,1)
    %         if IDX(j) == minj
    %             segI(Dpos(j,1),Dpos(j,2)) = D(j);
    %         end
    %     end
    %     %     end
    
end
% imshow(segI);
% figure;
imshow(segN);
% figure;
% imshow(depthI);
figure;
imshow(normI);
figure;
im = imread('result/result_3_final.jpg');
imshow(im);
