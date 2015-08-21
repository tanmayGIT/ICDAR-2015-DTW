function GTinfo = getGT_1(name)
% this function stores the information about GT of the components. We know in the saved image we ssave the image in the following
% format. "sorted index_image number_component number"

% initially we mannualy checked each image and get to know that which
% images are having the right match. So we get to know the following
% i)The sorted index
% ii) The image number
% iii) The component number

% so we come to know that which components in the complete component lists are matching with the required reference word


if(strcmp(name,'Francois'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 975;
    GTinfo(1,2) = 892;
    GTinfo(1,3) = 837;
    GTinfo(1,4) = 794;
    GTinfo(1,5) = 741;
    GTinfo(1,6) = 649;
    GTinfo(1,7) = 650;
    GTinfo(1,8) = 595;
    GTinfo(1,9) = 511;
    GTinfo(1,10) = 402;
    GTinfo(1,11) = 342;
    GTinfo(1,12) = 298;
    GTinfo(1,13) = 267;
    GTinfo(1,14) = 21;
    GTinfo(1,15) = 157;
    GTinfo(1,16) = 1370;
    GTinfo(1,17) = 1376;
    GTinfo(1,18) = 1264;
    GTinfo(1,19) = 1239;
    GTinfo(1,20) = 123;
    GTinfo(1,21) = 1198;
    GTinfo(1,22) = 1163;
    GTinfo(1,23) = 1085;
    GTinfo(1,24) = 1049;
    GTinfo(1,25) = 1010;
    GTinfo(1,26) = 247;%258;
    GTinfo(1,27) = 476;%296;
    
    
    
    
    GTinfo(3,1) = -10;
    GTinfo(3,2) = -10;
    GTinfo(3,3) = -10;
    GTinfo(3,4) = -10;
    GTinfo(3,5) = -10;
    GTinfo(3,6) = -10;
    GTinfo(3,7) = -10;
    GTinfo(3,8) = -10;
    GTinfo(3,9) = -10;
    GTinfo(3,10) = -10;
    GTinfo(3,11) = -10;
    GTinfo(3,12) = -10;
    GTinfo(3,13) = -10;
    GTinfo(3,14) = -10;
    GTinfo(3,15) = -10;
    GTinfo(3,16) = -10;
    GTinfo(3,17) = -10;
    GTinfo(3,18) = -10;
    GTinfo(3,19) = -10;
    GTinfo(3,20) = -10;
    GTinfo(3,21) = -10;
    GTinfo(3,22) = -10;
    GTinfo(3,23) = -10;
    GTinfo(3,24) = -10;
    GTinfo(3,25) = -10;
    GTinfo(3,26) = -10;%258;
    GTinfo(3,27) = -10;%296;
end
if(strcmp(name,'victoire'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 1354;
    GTinfo(1,2) = 279;
    GTinfo(1,3) = 979;
    GTinfo(1,4) = 873;
    GTinfo(1,5) = 498;
    GTinfo(1,6) = 315;
    GTinfo(1,7) = 543;
    GTinfo(1,8) = 600;
    GTinfo(1,9) = 837;
    GTinfo(1,10) = 201;
    GTinfo(1,11) = 113;
    GTinfo(1,12) = 7;
    GTinfo(1,13) = 672;
    GTinfo(1,14) = 162;
    GTinfo(1,15) = 61;
    GTinfo(1,16) = 724;
    GTinfo(1,17) = 788;
    GTinfo(1,18) = 422;
    GTinfo(3,18) = -15;
    GTinfo(1,19) = 1011;
    GTinfo(1,20) = 1058;
    GTinfo(1,21) = 1072;
    GTinfo(1,22) = 1354;
    GTinfo(1,23) = 1273;
    GTinfo(1,24) = 1202;
    GTinfo(1,25) = 1158;
end
if(strcmp(name,'vaisseau'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 667;
    GTinfo(1,2) = 624;
    GTinfo(1,3) = 797;
    GTinfo(1,4) = 357;
    GTinfo(1,5) = 195;
    GTinfo(1,6) = 412;
    GTinfo(1,7) = 302;
    GTinfo(1,8) = 157;
    GTinfo(1,9) = 514;
    GTinfo(1,10) = 47;
    GTinfo(1,11) = 829;
end
if(strcmp(name,'parmy'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 1110;
    GTinfo(1,2) = 1373;
    GTinfo(1,3) = 1180;
    GTinfo(1,4) = 1231;
    GTinfo(1,5) = 616;
    GTinfo(1,6) = 243;
    GTinfo(1,7) = 427;
    GTinfo(1,8) = 565;
    GTinfo(1,9) = 912;
    GTinfo(1,9) = -15;
    GTinfo(1,10) = 893;
    GTinfo(3,10) = -15;
    GTinfo(1,11) = 683;
    GTinfo(1,12) = 354;
    GTinfo(3,12) = -10;
    GTinfo(1,13) = 1031;
    GTinfo(1,14) = 1327;
    GTinfo(1,15) = 2;
    GTinfo(3,15) = -15;
    GTinfo(1,16) = 316;
    GTinfo(1,17) = 500;
    GTinfo(1,18) = 710;
    GTinfo(1,19) = 794;
    GTinfo(1,20) = 834;
    GTinfo(1,21) = 998;
end
if(strcmp(name,'tantost'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 418;
    GTinfo(1,2) = 294;
    GTinfo(1,3) = 408;
    GTinfo(1,4) = 37;
    GTinfo(1,5) = 76;
    GTinfo(1,6) = 425;
    GTinfo(1,7) = 593;
    GTinfo(1,8) = 337;
    GTinfo(1,9) = 544;
    GTinfo(1,10) = 391;
    GTinfo(1,11) = 193;
    GTinfo(1,12) = 752;
    GTinfo(1,13) = 630;
    GTinfo(1,14) = 721;
    GTinfo(1,15) = 356;
    GTinfo(1,16) = 204;
    GTinfo(1,17) = 745;
    GTinfo(1,18) = 120;
    GTinfo(1,19) = 519;
    GTinfo(1,20) = 384;
end
if(strcmp(name,'mortel'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 1072;
    GTinfo(1,2) = 1113;
    GTinfo(1,3) = 1214;
    GTinfo(1,4) = 1274;
    GTinfo(1,5) = 1434;
    GTinfo(1,6) = 152;
    GTinfo(1,7) = 189;
    GTinfo(1,8) = 190;
    GTinfo(1,9) = 293;
    GTinfo(1,10) = 321;
    GTinfo(1,11) = 562;
    GTinfo(1,12) = 576;
    GTinfo(1,13) = 6;
    GTinfo(1,14) = 603;
    GTinfo(1,15) = 628;
    GTinfo(1,16) = 661;
    GTinfo(1,17) = 664;
    GTinfo(1,18) = 90;
    GTinfo(1,19) = 917;
    GTinfo(1,20) = 929;
end
if(strcmp(name,'liberte'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 972;
    GTinfo(3,1) = -15;
    GTinfo(1,2) = 905;
    GTinfo(1,3) = 887;
    GTinfo(1,4) = 85;
    GTinfo(1,5) = 773;
    GTinfo(1,6) = 769;
    GTinfo(1,7) = 696;
    GTinfo(1,8) = 603;
    GTinfo(1,9) = 540;
    GTinfo(1,10) = 509;
    GTinfo(1,11) = 393;
    GTinfo(1,12) = 300;
    GTinfo(1,13) = 227;
    GTinfo(1,14) = 19;
    GTinfo(3,14) = -15;
    GTinfo(1,15) = 151;
    GTinfo(1,16) = 1321;
    GTinfo(1,17) = 1270;
    GTinfo(1,18) = 1087;
    GTinfo(1,19) = 1003;
    GTinfo(3,19) = -15;
    GTinfo(1,20) = 1039;
end
if(strcmp(name,'cheual'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 1005;
    GTinfo(1,2) = 1009;
    GTinfo(1,3) = 1016;
    GTinfo(1,4) = 1145;
    GTinfo(1,5) = 1264;
    GTinfo(1,6) = 129;
    GTinfo(1,7) = 1321;
    GTinfo(1,8) = 1419;
    GTinfo(1,9) = 166;
    GTinfo(1,10) = 1049;%240;
    GTinfo(1,11) = 306;
    GTinfo(1,12) = 442;
    GTinfo(1,13) = 473;
    GTinfo(1,14) = 51;
    GTinfo(1,15) = 554;
    GTinfo(1,16) = 644;
    GTinfo(1,17) = 65;
    GTinfo(1,18) = 679;
    GTinfo(1,19) = 766;
    GTinfo(1,20) = 791;
    GTinfo(1,21) = 9;
    GTinfo(1,22) = 925;
    GTinfo(1,23) = 1460;%21;
    GTinfo(1,24) = 407;%57;
end
if(strcmp(name,'Cicero'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 932;
    GTinfo(1,2) = 897;
    GTinfo(1,3) = 817;
    GTinfo(1,4) = 753;
    GTinfo(1,5) = 640;
    GTinfo(1,6) = 564;
    GTinfo(1,7) = 354;
    GTinfo(1,8) = 29;
    GTinfo(1,9) = 289;
    GTinfo(1,10) = 279;
    GTinfo(1,11) = 216;
    GTinfo(1,12) = 1720;
    GTinfo(1,13) = 1244;%787;
    GTinfo(1,14) = 1619;
    GTinfo(1,15) = 1562;
    GTinfo(1,16) = 1506;
    GTinfo(1,17) = 1405;
    GTinfo(1,18) = 1107;
    GTinfo(1,19) = 109;
    GTinfo(1,20) = 1064;
    GTinfo(1,21) = 325;
    
    
    GTinfo(3,1) = -10;
    GTinfo(3,2) = -10;
    GTinfo(3,3) = -10;
    GTinfo(3,4) = -10;
    GTinfo(3,5) = -10;
    GTinfo(3,7) = -10;
    GTinfo(3,8) = -10;
    GTinfo(3,9) = -10;
    GTinfo(3,10) = -10;
    GTinfo(3,11) = -10;
    GTinfo(3,12) = -10;
    GTinfo(3,13) = -10;
    GTinfo(3,14) = -10;
    GTinfo(3,15) = -10;
    GTinfo(3,16) = -10;
    GTinfo(3,17) = -10;
    GTinfo(3,18) = -10;
    GTinfo(3,19) = -10;
    GTinfo(3,20) = -10;
    GTinfo(3,21) = -10;
end
if(strcmp(name,'Chrestien'))
    GTinfo = zeros(3,1);
    GTinfo(1,1) = 1019;
    GTinfo(1,2) = 1224;
    GTinfo(1,3) = 846;
    GTinfo(1,4) = 521;
    GTinfo(1,5) = 415;
    GTinfo(1,6) = 40;
    GTinfo(1,7) = 1341;
    GTinfo(1,8) = 91;
    GTinfo(1,9) = 638;
    GTinfo(1,10) = 1099;
    GTinfo(1,11) = 761;
    GTinfo(1,12) = 334;
    GTinfo(1,13) = 1355;
    GTinfo(1,14) = 260;
    GTinfo(1,15) = 1159;
    GTinfo(1,16) = 922;
    
    
    GTinfo(3,1) = -10;
    GTinfo(3,2) = -10;
    GTinfo(3,3) = -10;
    GTinfo(3,4) = -10;
    GTinfo(3,5) = -10;
    GTinfo(3,7) = -10;
    GTinfo(3,8) = -10;
    GTinfo(3,9) = -10;
    GTinfo(3,10) = -10;
    GTinfo(3,11) = -10;
    GTinfo(3,12) = -10;
    GTinfo(3,13) = -10;
    GTinfo(3,14) = -10;
    GTinfo(3,15) = -10;
    GTinfo(3,16) = -10;
end
return;
