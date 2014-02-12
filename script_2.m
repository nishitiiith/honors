regionSize = 50;%input('Enter regionsize: ') ;
regularizer = 0.3;%input('Enter regualizer: ') ;

infile = input('Input filename:(excluding .jpg) ', 's');
I = imread(strcat(infile,'.jpg'));
im = im2single(I);
segments = vl_slic(im, regionSize, regularizer) ;
s = size(segments);
for i=2:s(1)-1
    i
    for j=2:s(2)-1
        val = segments(i,j);
        
        U = unique(segments(i-1:i+1,j-1:j+1));
% %         if size(U,1)>1
% %             I(i,j,:) = [0,0,0];
%         end   
%         [i,j]
    end
end
imwrite(I,strcat(infile,'_',num2str(regionSize),'_result_2.bmp'),'bmp')
