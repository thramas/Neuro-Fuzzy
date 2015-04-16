/*

Author : Samarth Khare

*/

a = imread('d:\testdata\water.png');
[x y z] = size(a);
k=1;
for i=1:x %no. of columns
 disp(i);
            for j=1:y %no. of rows
          
            
            r(k,1)=a(i,j,1);
            r(k,2)=a(i,j,2);
            r(k,3)=a(i,j,3);
              k=k+1; 
            end;
        end;
csvwrite('d:\water.csv',r);

a = imread('d:\testdata\forest.png');
[x y z] = size(a);
k=1;
for i=1:x %no. of columns
 disp(i);
            for j=1:y %no. of rows
          
            
            r(k,1)=a(i,j,1);
            r(k,2)=a(i,j,2);
            r(k,3)=a(i,j,3);
              k=k+1; 
            end;
        end;
csvwrite('d:\forest.csv',r);


a = imread('d:\testdata\land.png');
[x y z] = size(a);
k=1;
for i=1:x %no. of columns
 disp(i);
            for j=1:y %no. of rows
          
            
            r(k,1)=a(i,j,1);
            r(k,2)=a(i,j,2);
            r(k,3)=a(i,j,3);
              k=k+1; 
            end;
        end;
csvwrite('d:\land.csv',r);
a = imread('d:\testdata\urban.png');
[x y z] = size(a);
k=1;
for i=1:x %no. of columns
 disp(i);
            for j=1:y %no. of rows
          
            
            r(k,1)=a(i,j,1);
            r(k,2)=a(i,j,2);
            r(k,3)=a(i,j,3);
              k=k+1; 
            end;
        end;
csvwrite('d:\urban.csv',r);



