regionSize = 100;%input('Enter regionsiz: ') ;
regularizer = 1.0;%input('Enter regualizer: ') ;
infile = input('Input filename:', 's');
I = imread(infile);
im = im2single(I);
segments = vl_slic(im, regionSize, regularizer) ;
s = size(segments);
for i=2:s(1)-1
    for j=2:s(2)-1
        val = segments(i,j);
        found = 0;
        val2 = -1;
        U = unique(segments(i-1:i+1,j-1:j+1));
        if(size(U,1) == 2)
            I(i,j,1) = 0;
            I(i,j,2) = 0;
            I(i,j,3) = 0;           
            continue
        end
        if(size(U,1) == 3)
            for I=i-1:i+1
                for J=j-1:j+1
                    I(I,J,1) = 255;
                    I(I,J,2) = 0;
                    I(I,J,3) = 0;
                end
            end     
            continue
        end        
        if(size(U,1) == 4)
            for I=i-1:i+1
                for J=j-1:j+1
                    I(I,J,1) = 0;
                    I(I,J,2) = 0;
                    I(I,J,3) = 255;
                end
            end           
        end
    end
end
imwrite(I,'result_superpixel.jpg');