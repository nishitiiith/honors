regionSize = 100;%input('Enter regionsiz: ') ;
regularizer = 0.3;%input('Enter regualizer: ') ;

infile = input('Input filename:(excluding .jpg) ', 's');
I = imread(strcat(infile,'.jpg'));
im = im2single(I);
segments = vl_slic(im, regionSize, regularizer) ;
s = size(segments);
for i=2:s(1)-1
    for j=2:s(2)-1
        val = segments(i,j);
        found = 0;
        val2 = -1;
        for l=i-1:i+1
            for k=j-1:j+1
                if segments(l,k) == val
                    continue;
                end
                if val2 == -1
                    
                    I(i,j,:) = [0,0,0];
                    found = 2;
                    val2 = segments(l,k);       
                end
                if found == 2
                    break;
                end
            end
            if found == 2
                break;
            end
        end
    end
end
for i=3:s(1)-2
    for j=3:s(2)-2
        val = segments(i,j);
        found = 0;
        val2 = -1;
        for l=i-2:i+2
            for k=j-2:j+2
                if segments(l,k) == val
                    continue;
                end
                if val2 == -1
%                     I(i,j,:) = [0,0,0];
%                     found = 1;
                    val2 = segments(l,k);
                else
                    if segments(l,k) ~= val2
                        I(i,j,:) = [255,0,0];
%                         for p=i-1:i+1
%                             for q=j-1:j+1
%                                 I(p,q,1)= 255;
%                                 I(p,q,2) = 0;
%                                 I(p,q,3) = 0;
%                             end
%                         end
                        found = 2;
                    end
                end
                if found == 2
                    break;
                end
            end
            if found == 2
                break;
            end
        end
    end
end
imwrite(I,strcat(infile,'_',num2str(regionSize),'_result_2.bmp'),'bmp')