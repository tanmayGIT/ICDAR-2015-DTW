function keepAllResult = subDemoForGW_ACPR_2(technique,seperateGTforAllRef)
noOfTimesExp = 5;
keepAllResult = cell(1,1);
for iu = 1:1:noOfTimesExp % number of random experiments, to be performed
    refGTInfo = seperateGTforAllRef{iu,1};
    allResult = DemoForGW_ACPR_2(technique,1,1,refGTInfo);
    keepAllResult{iu,1} = allResult;
end
return;
end