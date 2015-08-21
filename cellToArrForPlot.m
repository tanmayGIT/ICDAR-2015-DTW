function [totlArr,mytotarr] = cellToArrForPlot(cellArr)
totCellLen = length(cellArr);
totlArr = cell(1,1);
mytotarr = cell(1,1);
cnt = 1;
for p = 1:1:totCellLen
    if(~isempty( cellArr{p,1}))
        myArr = cellArr{p,1};
        width = 3;
        onlyArr = zeros(size(myArr,1),width);
        no_rel_doc = size(myArr{1,4},2);
        recal_cnt = 0;
        for i = 1:1:size(myArr,1)
            onlyArr(i,1) = myArr{i,1};
            onlyArr(i,2) = myArr{i,2};
            onlyArr(i,3) = myArr{i,3};
            if( myArr{i,2} > recal_cnt) % if the recall is increasing then this cell has retrieved TP
                recal_cnt = myArr{i,2};
                onlyArr(i,4) = 1; 
            else
                onlyArr(i,4) = 0; % if the recall is decresing then this cell has retrieved FP
            end
        end
        if(length(find(onlyArr(:,4))) == no_rel_doc)
%             disp('things are fine');
        else
%             disp('things are not fine');
        end
        totlArr{cnt,1} = onlyArr;
        onlyArr(:,4) = [];
        mytotarr{cnt,1} = onlyArr;
        totlArr{cnt,2} = no_rel_doc;
        cnt = cnt +1;
    end
end
return;
end