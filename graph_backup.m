regionSize = 50;%input('Enter regionsiz: ') ;
regularizer = 1.0;%input('Enter regualizer: ') ;
files = dir(folder);
for totalimages=3:size(files,1)
    files(totalimages).name
    I = imread(strcat(folder,'/',files(totalimages).name));
    % infile = input('Input filename:(excluding .jpg) ', 's');
    % I = imread(infile);
    im = im2single(I);
    segments = bfs2(vl_slic(im, regionSize, regularizer)); % bfs2 is for avoiding duplicate superpixels    
    'superpixel segmentaiton done..'
    s = size(segments);
    junc1 = containers.Map(-1,'0 0');
    junc2 = containers.Map('0 0',-1);
    spix = containers.Map(-1,[1,2]); % label -> list of vertice
    junc = containers.Map(-1,[1,2,3,4]);
    Dead_end = containers.Map(-1,-1);
    val = [0,0,0,0];
    count = 0;
    j_window=3;
    
    boundary = 2; % (int)j_window/2  + 1
    for i=boundary:s(1)-boundary+1
        for j=boundary:s(2)-boundary+1
            found = 0;
            val(2) = -1;
            val(3) = -1;
            val(4) = -1;
            total_values = 1;
            val(1) = segments(i,j);
            for l=i-boundary+1:i+boundary-1
                for k=j-boundary+1:j+boundary-1
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
            dead_end = 0;
            
            if (i == boundary | j == boundary | i == s(1)-boundary+1 | j == s(2)-boundary+1) & total_values == 2
                dead_end = 1;
                total_values = 3;
            end
            if total_values == 1
                continue;
            else if total_values == 2
                    I(i,j,:) = [0,0,0];                     
                else if total_values > 2
                        if dead_end
                            total_values = 2;
                        end
                        flag=0;
                        for p=i-3:i+3
                            for q=j-3:j+3
                                if p < 1
                                    continue
                                end
                                if p > s(1)
                                    continue
                                end
                                if q < 1
                                    continue;
                                end
                                if q > s(2)
                                    continue;
                                end
                                if(I(p,q,1) == 255 & I(p,q,2)+I(p,q,3) == 0)
                                    flag = 1;
                                    break;
                                end
                            end
                            if flag == 1
                                break;
                            end
                        end
                        if(flag == 0)
                            I(i,j,:) = [255,0,0];
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
                            if dead_end == 1
                                Dead_end(count) = 1;
                            else
                                Dead_end(count) = 0;
                            end
                        end
                    end
                end
            end
        end
    end
    imwrite(I,'result.bmp');
    % close all;
    % 'make_Graph'
    save('vars');
    'making graph..'    
    G=make_graph(totalimages);
end
