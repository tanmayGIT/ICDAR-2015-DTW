function GTinfo = getGT(name)
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
         
        GTinfo(1,1) = 2;
        GTinfo(2,1) = 36;
        
        GTinfo(1,2) = 15;
        GTinfo(2,2) = 6;
        
        GTinfo(1,3) = 22;
        GTinfo(2,3) = 31;
        
        GTinfo(1,4) = 8;
        GTinfo(2,4) = 18;
        
        GTinfo(1,5) = 11;
        GTinfo(2,5) = 7;
        
        GTinfo(1,6) = 3;
        GTinfo(2,6) = 15;
        
        GTinfo(1,7) = 12;
        GTinfo(2,7) = 29;
        
        GTinfo(1,8) = 5;
        GTinfo(2,8) = 18;
        
        GTinfo(1,9) = 14;
        GTinfo(2,9) = 6;
        
        GTinfo(1,10) = 17;
        GTinfo(2,10) = 26;
        
        GTinfo(1,11) = 20;
        GTinfo(2,11) = 2;
        
        GTinfo(1,12) = 20;
        GTinfo(2,12) = 30;
        
        GTinfo(1,13) = 10;
        GTinfo(2,13) = 23;
        
        GTinfo(1,14) = 9;
        GTinfo(2,14) = 4;
        
        GTinfo(1,15) = 16;
        GTinfo(2,15) = 41;
        
        GTinfo(1,16) = 21;
        GTinfo(2,16) = 3;
        
        GTinfo(1,17) = 13;
        GTinfo(2,17) = 24;
        
        GTinfo(1,18) = 4;
        GTinfo(2,18) = 32;
        
        GTinfo(1,19) = 6;
        GTinfo(2,19) = 7;
        
        GTinfo(1,20) = 22;
        GTinfo(2,20) = 37;
        
        GTinfo(1,21) = 7;
        GTinfo(2,21) = 3;
        
        GTinfo(1,22) = 11;
        GTinfo(2,22) = 6;
        
        GTinfo(1,23) = 16;
        GTinfo(2,23) = 17;
        
        GTinfo(1,24) = 16;
        GTinfo(2,24) = 7;
        
        GTinfo(1,25) = 1;
        GTinfo(2,25) = 15;
        
        GTinfo(1,26) = 18;
        GTinfo(2,26) = 6;
        
        GTinfo(1,27) = 19;
        GTinfo(2,27) = 23;
      
end
if(strcmp(name,'victoire'))
        GTinfo = zeros(2,1);
        
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
        
end
if(strcmp(name,'vaisseau'))
        GTinfo = zeros(2,1);
        
        GTinfo(1,1) = 667;
       
        
        GTinfo(1,2) = 624;
       
        
        GTinfo(1,3) = 797;
       
        
        GTinfo(1,4) = 357;
        
        
        GTinfo(1,5) = 195;
        
        
        GTinfo(1,6) = 412;
        
        
        GTinfo(1,7) = 302;
       
        
        GTinfo(1,8) = 157;     
        
        GTinfo(1,9) = 514;  
end
if(strcmp(name,'parmy'))
        GTinfo = zeros(2,1);
        
        GTinfo(1,1) = 1110;
       
        
        GTinfo(1,2) = 1373;
      
        
        GTinfo(1,3) = 1180;
       
        
        GTinfo(1,4) = 1231;
        
        
        GTinfo(1,5) = 616;
        
        
        GTinfo(1,6) = 243;
        
        
        GTinfo(1,7) = 427;
        
        
        GTinfo(1,8) = 565;
end
if(strcmp(name,'tantost'))
        GTinfo = zeros(2,1);
        
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
end
if(strcmp(name,'mortel'))
        GTinfo = zeros(3,1);
        
        GTinfo(1,1) = 7;
        GTinfo(2,1) = 53;
        
        GTinfo(1,2) = 3;
        GTinfo(2,2) = 14;
        
        GTinfo(1,3) = 1;
        GTinfo(2,3) = 6;
        
        GTinfo(1,4) = 7;
        GTinfo(2,4) = 39;
        
        GTinfo(1,5) = 17;
        GTinfo(2,5) = 62;
        
        GTinfo(1,6) = 14;
        GTinfo(2,6) = 21;
        
        GTinfo(1,7) = 10;
        GTinfo(2,7) = 56;
        
        GTinfo(1,8) = 11;
        GTinfo(2,8) = 61;
        
        GTinfo(1,9) = 15;
        GTinfo(2,9) = 31;
        
        GTinfo(1,10) = 2;
        GTinfo(2,10) = 2;
        
        GTinfo(1,11) = 8;
        GTinfo(2,11) = 32;
        
        GTinfo(1,12) = 12;
        GTinfo(2,12) = 4;
        
        GTinfo(1,13) = 4;
        GTinfo(2,13) = 40;
        
        GTinfo(1,14) = 3;
        GTinfo(2,14) = 13;
        
        GTinfo(1,15) = 15;
        GTinfo(2,15) = 47;
        
        GTinfo(1,16) = 8;
        GTinfo(2,16) = 67;
        
        GTinfo(1,17) = 8;
        GTinfo(2,17) = 9;
        
        GTinfo(1,18) = 4;
        GTinfo(2,18) = 65;    
end
if(strcmp(name,'liberte'))
        GTinfo = zeros(3,1);
        
        GTinfo(1,1) = 3;
        GTinfo(2,1) = 2;
        
        GTinfo(1,2) = 1;
        GTinfo(2,2) = 14;
        
        GTinfo(1,3) = 15;
        GTinfo(2,3) = 62;
        
        GTinfo(1,4) = 14;
        GTinfo(2,4) = 47;
        
        GTinfo(1,5) = 22;
        GTinfo(2,5) = 35;
        
        GTinfo(1,6) = 2;
        GTinfo(2,6) = 3;
        
        GTinfo(1,7) = 6;
        GTinfo(2,7) = 57;
        
        GTinfo(1,8) = 5;
        GTinfo(2,8) = 28;
        
        GTinfo(1,9) = 4;
        GTinfo(2,9) = 18;
        
        GTinfo(1,10) = 12;
        GTinfo(2,10) = 56;
        
        GTinfo(1,11) = 17;
        GTinfo(2,11) = 34;
        
        GTinfo(1,12) = 20;
        GTinfo(2,12) = 40;
        
        GTinfo(1,13) = 7;
        GTinfo(2,13) = 26;
        
        GTinfo(1,14) = 19;
        GTinfo(2,14) = 22;
        
        GTinfo(1,15) = 21;
        GTinfo(2,15) = 48;
        
        GTinfo(1,16) = 11;
        GTinfo(2,16) = 43;
        
        GTinfo(1,17) = 13;
        GTinfo(2,17) = 3;
        
        GTinfo(1,18) = 14;
        GTinfo(2,18) = 64;
        
        GTinfo(1,19) = 18;
        GTinfo(2,19) = 21;
        
        GTinfo(1,20) = 16;
        GTinfo(2,20) = 22;     
end
if(strcmp(name,'cheual'))
        GTinfo = zeros(3,1);
        
        GTinfo(1,1) = 4;
        GTinfo(2,1) = 30;
        
        GTinfo(1,2) = 17;
        GTinfo(2,2) = 22;
        
        GTinfo(1,3) = 8;
        GTinfo(2,3) = 16;
        
        GTinfo(1,4) = 20;
        GTinfo(2,4) = 61;
        
        GTinfo(1,5) = 15;
        GTinfo(2,5) = 34;
        
        GTinfo(1,6) = 6;
        GTinfo(2,6) = 7;
        
        GTinfo(1,7) = 12;
        GTinfo(2,7) = 39;
        
        GTinfo(1,8) = 7;
        GTinfo(2,8) = 62;
        
        GTinfo(1,9) = 15;
        GTinfo(2,9) = 27;
        
        GTinfo(1,10) = 12;
        GTinfo(2,10) = 15;
        
        GTinfo(1,11) = 1;
        GTinfo(2,11) = 42;
        
        GTinfo(1,12) = 11;
        GTinfo(2,12) = 16;
        
        GTinfo(1,13) = 1;
        GTinfo(2,13) = 55;
        
        GTinfo(1,14) = 7;
        GTinfo(2,14) = 32;
        
        GTinfo(1,15) = 21;
        GTinfo(2,15) = 12;
        
        GTinfo(1,16) = 1;
        GTinfo(2,16) = 7;
        
        GTinfo(1,17) = 10;
        GTinfo(2,17) = 40;
        
        GTinfo(1,18) = 3;
        GTinfo(2,18) = 28;
        
        GTinfo(1,19) = 9;
        GTinfo(2,19) = 1;
        
        GTinfo(1,20) = 15;
        GTinfo(2,20) = 24;
        
        GTinfo(1,21) = 14;
        GTinfo(2,21) = 13;
        
        GTinfo(1,22) = 19;
        GTinfo(2,22) = 46;
        
        GTinfo(1,23) = 16;
        GTinfo(2,23) = 11;
        
        GTinfo(1,24) = 18;
        GTinfo(2,24) = 65;
        
end
if(strcmp(name,'Cicero'))
        GTinfo = zeros(3,1);
        
        GTinfo(1,1) = 20;
        GTinfo(2,1) = 63;
        
        GTinfo(1,2) = 9;
        GTinfo(2,2) = 40;
        
        GTinfo(1,3) = 22;
        GTinfo(2,3) = 11;
        
        GTinfo(1,4) = 14;
        GTinfo(2,4) = 45;
        
        GTinfo(1,5) = 11;
        GTinfo(2,5) = 43;
        
        GTinfo(1,6) = 5;
        GTinfo(2,6) = 14;
        
        GTinfo(1,7) = 12;
        GTinfo(2,7) = 41;
        
        GTinfo(1,8) = 8;
        GTinfo(2,8) = 30;
        
        GTinfo(1,9) = 4;
        GTinfo(2,9) = 40;
        
        GTinfo(1,10) = 15;
        GTinfo(2,10) = 20;
        
        GTinfo(1,11) = 3;
        GTinfo(2,11) = 54;
        
        GTinfo(1,12) = 13;
        GTinfo(2,12) = 4;
        
        GTinfo(1,13) = 23;
        GTinfo(2,13) = 23;
        
        GTinfo(1,14) = 2;
        GTinfo(2,14) = 21;
        
        GTinfo(1,15) = 10;
        GTinfo(2,15) = 71;
        
        GTinfo(1,16) = 5;
        GTinfo(2,16) = 43;
        
        GTinfo(1,17) = 1;
        GTinfo(2,17) = 26;
        
        GTinfo(1,18) = 19;
        GTinfo(2,18) = 43;
        
        GTinfo(1,19) = 21;
        GTinfo(2,19) = 36;
        
        GTinfo(1,20) = 4;
        GTinfo(2,20) = 50;
        
        GTinfo(1,21) = 17;
        GTinfo(2,21) = 4;
     
end
if(strcmp(name,'Chrestien'))
        GTinfo = zeros(2,1);
        
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
 
end
return;
    