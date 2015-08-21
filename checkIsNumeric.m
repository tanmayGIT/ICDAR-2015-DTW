function flag = checkIsNumeric(iChar)
flag = 0;
if(  (iChar == '0')||(iChar == '1')||(iChar == '2')||(iChar == '3')||(iChar == '4')||(iChar == '5')||(iChar == '6')...
        ||(iChar == '7')||(iChar == '8')||(iChar == '9') )
    flag = 1;
end
return;
end