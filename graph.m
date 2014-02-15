regionSize = 20;%input('Enter regionsiz: ') ;
regularizer = 1.0;%input('Enter regualizer: ') ;
folder='images';
files = dir(folder);
for totalimages=3:size(files,1)
    if totalimages > 3
        break;
    end
    files(totalimages).name
    I = imread(strcat(folder,'/',files(totalimages).name));
    I2 = I;
    im = im2single(I);
    segments = bfs2(vl_slic(im, regionSize, regularizer)); % bfs2 is for avoiding duplicate superpixels
    'superpixel segmentaiton done..'
    s = size(segments);
    junc1 = containers.Map(-1,'0 0');
    junc2 = containers.Map('0 0',-1);
    spix = containers.Map(-1,[1,2]); % label -> list of vertice
    junc = containers.Map(-1,[1,2,3,4]);
    Dead_end = containers.Map(-1,-1);
    count = 0;
    j_removal=5; % 2n+1X2n+1 to remove nearby junctions
    j_window =5; % 2n+1X2n+1 to detect junctions
    for i=1:s(1)
        for j=1:s(2)
            dead_end = 0;
            if (i == 1 | i == s(1) | j == 1 | j == s(2))
                dead_end = 1;
            end
            [val,total_values] = check_edge(i,j,segments,1,s);% 1 -> 3x3
            if total_values == 2
                I(i,j,:) = [0,0,0]; % contour
                I2(i,j,:) = [0,0,0];
                if (dead_end == 0)
                    continue;
                end
            end
            if total_values == 1
                continue;
            end
            [val,total_values] = check_edge(i,j,segments,j_window,s);% 3-> 7x7
            
            if total_values ~= 2
                dead_end = 0;
            end
            if total_values == 1 | (total_values == 2 & dead_end == 0)
                continue;
            else if dead_end == 1 | total_values > 2
                    flag=0;
%                     nearby = [];
                    for p=i-j_removal:i+j_removal
                        for q=j-j_removal:j+j_removal
                            if p < 1 | p > s(1) | q < 1 | q > s(2)
                                continue
                            end
                            if(I(p,q,1) == 255 & I(p,q,2)+I(p,q,3) == 0)
%                                 nearby = [nearby;junc2(sprintf('%d %d',p,q))];
                                flag = 1;
                                break;
                            end
                        end
                        if flag == 1
                            break;
                        end
                    end
                    if(flag == 0) % no neary by junctions found. mark it !!
                        I2 = draw_dot(I2,[i,j],[255,255,0],2);
                        I(i,j,1) = 255;
                        I(i,j,2) = 0;
                        I(i,j,3) = 0;
                        count = count + 1;
                        %spix
                        for z=1:total_values
                            if isKey(spix,val(z)) == 0
                                spix(val(z)) = [i,j];
                            else
                                spix(val(z)) = [spix(val(z));i,j];
                            end
                        end
                        %junc1 count -> pixel
                        junc1(count) = sprintf('%d %d', i, j);
                        %junc2 pixel -> count
                        junc2(sprintf('%d %d', i, j)) = count;
                        %junc
                        junc(count) = val;
                        Dead_end(count) = dead_end;
                    else
%                         for z=1:total_values
%                             if isKey(spix,val(z)) == 0
%                                 spix(val(z)) = [i,j];
%                             else
%                                 spix(val(z)) = [spix(val(z));i,j];
%                             end
%                         end
                    end
                end
            end
        end
    end
    %     imwrite(I2,'result.bmp');
    % close all;
    % 'make_Graph'
    save('vars');
    'making graph..'
    imwrite(I2,sprintf('result/junction_%d.jpg',totalimages));
    G=make_graph(totalimages);
%     break;
    
end