%{
2017.05.20 BDP Assignment_5
%}

function main

import_data = importdata('trainingset.txt');

data = import_data.data(:, [1 2 3]);
%plot(data(:, 1), data(:, 2),'.');
%hold on;

test_data = importdata('testset.txt');
dataT = test_data.data(:, [1 2 3]);


tic;
[w1, w2] = Perceptron(data);  %Perceptron Algorithm
toc;

%display(w1);display(w2);
x = 3:8
y = - w1/w2 * x
plot(x, y, 'linewidth', 2, 'color', 'y'), gtext('r = 1');
grid on;hold on;

[mT nT] = size(dataT);
for ii = 1: mT
    resultT = w1 * dataT(ii, 1) + w2 * dataT(ii, 2);
    if resultT > 0
        plot(dataT(ii, 1), dataT(ii, 2),'.', 'Color', 'b');
        hold on;
    else
        plot(dataT(ii, 1), dataT(ii, 2),'.', 'Color', 'r');
        hold on;
    end

end

end



function [w1, w2] = Perceptron(data) 
    r = 1;
    [m n] = size(data);  
    w1 = 0; w2 = 100;
       
    while true    
        flag = 1;
        sum = 0;
        for i = 1: m
            result = w1 * data(i, 1) + w2 * data(i, 2);
            sum = sum + result;
            %display (result);
            y = data(i, 3);
            
            if result * y <= 0 
                w1 = w1 + r * data(i, 1) * y;
                w2 = w2 + r * data(i, 2) * y;
                flag = 0;          
            end
            %display(w1); display(w2);
        end
        %display(flag);
        if flag == 1 
            break;
        end
    end
end