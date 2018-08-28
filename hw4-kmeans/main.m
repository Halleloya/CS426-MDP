%{
2017.05.14 BDP Assignment_4
%}

function main

import_data = importdata('dataset.txt');
num = size(import_data.data, 1);

figure;
hold on;
for i = 1: num 
    if import_data.data(i, 4) == 0   
         plot3(import_data.data(i, 1), import_data.data(i, 2), import_data.data(i, 3), 'r.', 'MarkerSize', 15); 
    elseif import_data.data(i, 4) == 1
         plot3(import_data.data(i, 1), import_data.data(i, 2), import_data.data(i, 3), 'g.', 'MarkerSize', 15); 
    else 
         plot3(import_data.data(i, 1), import_data.data(i, 2), import_data.data(i, 3), 'y.', 'MarkerSize', 15); 
    end
end
grid on;
    
data = import_data.data(:, [1 2 3]);
tic;
matrix = kMeans(data, 2);  %K-Means Algorithm
toc;

figure;
hold on;
for i = 1: num 
    if matrix(i, 4) == 1   
         plot3(matrix(i, 1), matrix(i, 2), matrix(i, 3), 'r.', 'MarkerSize', 15); 
    elseif matrix(i, 4) == 2
         plot3(matrix(i, 1), matrix(i, 2), matrix(i, 3), 'g.', 'MarkerSize', 15); 
    elseif matrix(i,4) == 3
         plot3(matrix(i, 1), matrix(i, 2), matrix(i, 3), 'y.', 'MarkerSize', 15); 
    else
         plot3(matrix(i, 1), matrix(i, 2), matrix(i, 3), 'b.', 'MarkerSize', 15); 
    end
end
grid on;

end



function matrix = kMeans(data, K)   
    [m n] = size(data);  
    matrix = [];
    center = zeros(K, n);
           
    for i = 1: n
       for j=1:K
            center(j,i) = data(round(rand()*m), i);  
       end      
    end
   
    while true
        center0 = center;           
        for i = 1: K
            cal{i} = [];     
            for j = 1: m
                cal{i} = [cal{i}; data(j, :) - center(i, :)];
            end
        end
        
        tmp = zeros(m, K);
        for i = 1: m      
            c = [];
            for j = 1: K
                c = [c; norm(cal{j}(i, :))];
            end
            [xx ctr] = min(c);
            tmp(i, ctr) = 1;     
        end
        
		%display(tmp);
        for i = 1: K          
           for j = 1: n
                center(i, j) = sum(tmp(:, i).*data(:,j)) / sum(tmp(:, i));
           end           
        end
        
        if norm(center0 - center) < 0.01  
            break;
        end
    end
    
    for i = 1: m
        cal = [];
        for j = 1: K
            cal = [cal; norm(data(i, :) - center(j, :))];
        end
        [xx ctr] = min(cal);
        matrix = [matrix; data(i, :) ctr];
    end
    
end