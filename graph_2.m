
% orI = imread(strcat(infile,'.jpg'));
I = imread('result.bmp');
s = size(I);
orI = ones(size(I,1),size(I,2),3);
for i=6:(size(I,1)-5)
    for j=6:(size(I,2)-5)       
        if(I(i,j,1) == 255 & I(i,j,2)+I(i,j,3) == 0)
            for I2=i-3:i+3
                for J=j-3:j+3
                    I(I2,J,1) = 0;
                    I(I2,J,2) = 0;
                    I(I2,J,3) = 0;
                    
                end
            end
            orI(i,j,1) = 255;
            orI(i,j,2) = 0;
            orI(i,j,3) = 0;
            
        end
    end
end
imshow(orI,[]);
figure;
imshow(I,[]);