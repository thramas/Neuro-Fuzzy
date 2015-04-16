/*

Author : Samarth Khare
Created : October 2014

*/


clear;
clc;

[baseName, folder] = uigetfile({'*.csv';'*.*';},'Seleect Training Data Set');
fullFileName = fullfile(folder, baseName);
fid = fopen(fullFileName); %training areas total no of classes are 5

C = textscan(fid,'%f%f%f%s','delimiter',',');  % Import data
fclose(fid);
physchars = [C{1} C{2} C{3}]; % inputs to neural network

[baseName, folder] = uigetfile({'*.png';'*.jpeg';'*.jpg';'*.*';'*.tiff';'*.tif'},'Select Image File');
fullFileName = fullfile(folder, baseName);
image=imread(fullFileName);
[x y z]=size(image);

urban = strncmpi(C{4}, 'Urban', 1);
water = strncmpi(C{4}, 'Water', 1);
forest = strncmpi(C{4}, 'Forest', 1);
mangrove = strncmpi(C{4}, 'Mangrove', 1);
Land = strncmpi(C{4}, 'Land', 1);

class = double([ urban water forest mangrove Land]); 
physchars = physchars';
class = class';
rand('twister', 491218382);
net = newff(physchars,class,15);%refer Matlab help or crab classification in help
[net,tr] = train(net,physchars,class);


a = image;
k=1;
for i=1:x %no. of columns
 %disp(i);
            for j=1:y %no. of rows
          
            
            r(k,1)=a(i,j,1);
            r(k,2)=a(i,j,2);
            r(k,3)=a(i,j,3);
              k=k+1; 
            end;
        end;
csvwrite('temp.csv',r);
fid1 = fopen('temp.csv');% entire image
C1 = textscan(fid1,'%f%f%f','delimiter',',');  % Import data
fclose(fid1);
physchars1 = [C1{1} C1{2} C1{3}]; 
physchars1 = physchars1';
testInputs = physchars1;


out = sim(net,testInputs);  


out=out';
  S=size(testInputs);
  length=S(2);
  %% Assigining color to each class
  lable1 = 0;
  lable2 = 0;
  lable3 = 0;
  lable4 = 0;
  lable5 = 0;
 for i=1:length
     i
    if  out(i,1,1)>out(i,2,1)&&out(i,1,1)>out(i,3,1)&&out(i,1,1)>out(i,4,1)&&out(i,1,1)>out(i,5,1)
        M(i,1)=1;
        M(i,2)=0;
        M(i,3)=0;
        M(i,4)=0;
        M(i,5)=0;

  
       
        r(i,1)=128;
        r(i,2)=128;
        r(i,3)=128;
        lable1 = lable1 + 1;
    end;
    if  out(i,2,1)>out(i,1,1)&&out(i,2,1)>out(i,3,1)&&out(i,2,1)>out(i,4,1)&&out(i,2,1)>out(i,5,1)
        

        M(i,1)=0;
        M(i,2)=1;
        M(i,3)=0;
        M(i,4)=0;
        M(i,5)=0;
        
        r(i,1)=0;
        r(i,2)=0;
        r(i,3)=255;
        lable2 = lable2 + 1;
    end;
    if  out(i,3,1)>out(i,1,1)&&out(i,3,1)>out(i,2,1)&&out(i,3,1)>out(i,4,1)&&out(i,3,1)>out(i,5,1)
        M(i,1)=0;
        M(i,2)=0;
        M(i,3)=1;
        M(i,4)=0;
        M(i,5)=0;
        
        r(i,1)=255;%Red
        r(i,2)=0;%green
        r(i,3)=0;%blue
        lable3 = lable3 + 1;;
    end;
    if  out(i,4,1)>out(i,1,1)&&out(i,4,1)>out(i,3,1)&&out(i,4,1)>out(i,2,1)&&out(i,4,1)>out(i,5,1)

        M(i,1)=0;
        M(i,2)=0;
        M(i,3)=0;
        M(i,4)=1;
        M(i,5)=0;
        
        r(i,1)=0;%Red
        r(i,2)=128;%Green
        r(i,3)=0;%Blue
        lable4 = lable4 + 1;
    end;
    if  out(i,5,1)>out(i,1,1)&&out(i,5,1)>out(i,3,1)&&out(i,5,1)>out(i,2,1)&&out(i,5,1)>out(i,4,1)

        M(i,1)=0;
        M(i,2)=0;
        M(i,3)=0;
        M(i,4)=0;
        M(i,5)=1;
        
        r(i,1)=128;%Red
        r(i,2)=128;%Green
        r(i,3)=0;%Blue
        lable5 = lable5 + 1;
    end;
    
end;    
%% Converting csv file into RGB image matrix
%394*967
% 180*388
  k=1;
        for i=1:x %no. of columns
 disp(i);
            for j=1:y %no. of rows
          
            
            a(i,j,1)=r(k,1);
            a(i,j,2)=r(k,2);
            a(i,j,3)=r(k,3);
              k=k+1; 
            end;
        end;
  imshow(a);


l1 = double((lable1/(x*y))*100);
l2 = (lable2/(x*y))*100;
l3 = double((lable3/(x*y))*100);
l4 = double((lable4/(x*y))*100);
l5 = double((lable5/(x*y))*100);

fprintf('Percentage of Gray(Lable1, Urban): %f\n',l1);
fprintf('Percentage of Blue(Lable2, Water): %f\n',l2);
fprintf('Percentage of Red(Lable3, Forest): %f\n',l3);
fprintf('Percentage of Green(Lable4, Mangrove): %f\n',l4);
fprintf('Percentage of Yellow(Lable5, Land): %f\n',l5);


 
