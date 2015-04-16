/*

Author : Samarth Khare

*/

clear;
clc;
[baseName, folder] = uigetfile({'*.csv';'*.*';},'Seleect Training Data Set');
fullFileName = fullfile(folder, baseName);
fid = fopen(fullFileName);

C = textscan(fid,'%f%f%f%s','delimiter',',');  % Import data
fclose(fid);
physchars = [C{1} C{2} C{3}]; % inputs to neural network


urban = strncmpi(C{4}, 'Urban', 1);
water= strncmpi(C{4}, 'Water', 1);
forest = strncmpi(C{4}, 'Forest', 1);
mangrove = strncmpi(C{4}, 'Mangrove', 1);
Land = strncmpi(C{4}, 'Land', 1);

class = double([ urban water forest mangrove Land]); 
physchars = physchars';
class = class';
rand('twister', 491218382);
net = newff(physchars,class,15);

[net,tr] = train(net,physchars,class);

 
testInputs = physchars(:,tr.testInd);
testTargets = class(:,tr.testInd);


out = sim(net,testInputs);  


[y_out,I_out] = max(out);
[y_t,I_t] = max(testTargets);

diff = [I_t - 5*I_out];


v_v =length(find(diff==-4));  
v_u=length(find(diff==-9));
v_f=length(find(diff==-14));
v_m=length(find(diff==-19));
v_w=length(find(diff==-24));


u_v =length(find(diff==-3));  
u_u=length(find(diff==-8));
u_f=length(find(diff==-13));
u_m=length(find(diff==-18));
u_w=length(find(diff==-23));


f_v =length(find(diff==-2));  
f_u=length(find(diff==-7));
f_f=length(find(diff==-12));
f_m=length(find(diff==-17));
f_w=length(find(diff==-22));


m_v =length(find(diff==-1));  
m_u=length(find(diff==-6));
m_f=length(find(diff==-11));
m_m=length(find(diff==-16));
m_w=length(find(diff==-21));


w_v =length(find(diff==0));  
w_u=length(find(diff==-5));
w_f=length(find(diff==-10));
w_m=length(find(diff==-15));
w_w=length(find(diff==-20));





 N = size(testInputs,2);               % Number of testing samples
 fprintf('Total testing samples: %d\n', N);
 
 cm=[v_v u_v f_v m_v w_v ;v_u u_u f_u m_u w_u ;v_f u_f f_f m_f w_f ;v_m u_m f_m m_m w_m ;v_w u_w f_w m_w w_w  ]
 

%%
% The classification matrix provides a comprehensive picture of the
% classification performance of the classifier. The ideal classification
% matrix is the one in which the sum of the diagonal is equal to the number
% of samples.
%
% It can also be understood in terms of percentages. The following matrix
% provides the same information as above but in terms of percentages. 

 cm_p = (cm ./ N) .* 100         % classification matrix in percentages

  fprintf('Percentage Correct classification   : %f%%\n', 100*(cm(1,1)+cm(2,2)+cm(3,3)+cm(4,4)+cm(5,5))/N);
  fprintf('Percentage Incorrect classification : %f%%\n', 100*(cm(1,2)+cm(1,3)+cm(1,4)+cm(1,5)+cm(2,1)+cm(2,3)+cm(2,4)+cm(2,5)+cm(3,1)+cm(3,2)+cm(3,4)+cm(3,5)+cm(4,1)+cm(4,2)+cm(4,3)+cm(4,5)+cm(5,1)+cm(5,2)+cm(5,3)+cm(5,4))/N);
