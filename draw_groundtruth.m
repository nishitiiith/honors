function I = draw_groundtruth(imagefile,matfile)
I = imread(imagefile);
load(matfile);
for i=1:size(structA,2)
%     i=2;
    if size(structA(i).pX,1) == 0
        break;
    end
%     i
        
    Y=int32(structA(i).pX);
    X=int32(structA(i).pY);
    if structA(i).Type == 'b'
        color=[0,0,255];
    else if structA(i).Type == 'r'
            color=[255,0,0];
        else if structA(i).Type == 'g'
                color = [0,255,0];
            else if structA(i).Type == 'c'
                    color=[0,255,255];
                end
            end
        end
    end
    Xn = ones(size(X));
    Yn = ones(size(Y));
    for i=1:size(Xn,1)
        Xn(i) = X(i);
        Yn(i) = Y(i);
    end
    for j=1:size(Xn,1)-1
        
        I=draw_line(I,[Xn(j),Yn(j)],[Xn(j+1),Yn(j+1)],color);
    end
    
% %     X
% %     Y
%     break;
end
save('groundtruth.mat');   
% imshow(I);