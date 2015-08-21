function [NwDataTest,blockEntry] = PAA_IterativeDeepning(Data_Target)
% returns image with half size of original image


[Target_Row, Target_Col] = size(Data_Target);
NwDataTest = zeros((abs(Target_Row/2)),Target_Col);
blockEntry = zeros((abs(Target_Row/2)),1);
cnt1 = 1;
if((mod(Target_Row,2))==0)
    for i = 1:2:Target_Row
        for j = 1:1:Target_Col
            NwDataTest(cnt1,j) = mean(Data_Target(i:i+1,j));
        end
        blockEntry(cnt1,1) = 2;
        cnt1 = cnt1 +1;
    end
else
    % For the odd number of rows, we averaged the last 3 cells of the
    % matrix
    for i = 1:2:Target_Row-3
        for j = 1:1:Target_Col
            NwDataTest(cnt1,j) = mean(Data_Target(i:i+1,j));
        end
        blockEntry(cnt1,1) = 2;
        cnt1 = cnt1 +1;
    end
    for j = 1:1:Target_Col
        NwDataTest(cnt1,j) = mean(Data_Target((Target_Row-2):Target_Row,j));
    end
    blockEntry(cnt1,1) = 3;

end

return;
end