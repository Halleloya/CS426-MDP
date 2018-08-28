%{
2017.05.21 BDP Assignment_5
%}

function main

import_data = importdata('trainingset.txt');

data = import_data.data(:, [1 2 3]);
% plot(data(:, 1), data(:, 2),'.');
% hold on;
test_data = importdata('testset.txt');
dataT = test_data.data(:, [1 2 3]);

tic;
KNN(data, 9, dataT);  %KNN Algorithm
toc;




end



function KNN(data, K, dataT) 
    [m n] = size(data);  
    m1 = 0; m2 = 0;
    data1 = zeros(m , n-1);
    data2 = zeros(m , n-1);
    for i = 1: m
        if data(i, 3) == 1
            m1 = m1 + 1;
            data1(m1, 1: 2) = data(i, 1: 2);
        else
            m2 = m2 + 1;
            data2(m2, 1: 2) = data(i, 1: 2);
        end
    end
    
    data1 = data1(1:m1, 1:2);
    data2 = data2(1:m2, 1:2);
    
    plot(data1(:, 1), data1(:, 2),'*');
    hold on;

    plot(data2(:, 1), data2(:, 2),'^');
    hold on;

    bbb = []; 
    for a = 3: 0.01 : 7.5
        bb = 0;
        for b = 5.5: -0.01 : 0.5
            %testMargin = [a b];
            distance1 = zeros(1, m1);
            distance2 = zeros(1, m2);
            %display([a b]);
            for i = 1: m1
                distance1(1, i) = sqrt((a - data1(i, 1))^2 + (b - data1(i, 2))^2);
            end
            for i = 1: m2
                distance2(1, i) = sqrt((a - data2(i, 1))^2 + (b - data2(i, 2))^2);
            end
            distance1 = distance1(1, 1:m1);
            distance2 = distance2(1, 1:m2);
            distance1 = sort(distance1);
            distance2 = sort(distance2);
            
            xx = 1; yy = 1;
            while true
                if distance1(xx) < distance2(yy)
                    xx = xx + 1;
                else
                    yy = yy + 1;
                end
                if xx + yy == K + 2
                    if xx > yy
                        bb = b;%plot(a, b);
                        %display(bb);
                    end
                    %display(distance1); display(distance2);
                    %display(a); display(b);display(xx); display(yy);
                    break;
                end
            end
            
            %display(bbb);
        end
        bbb = [bbb bb];       
    end
    a = 3: 0.01 : 7.5;
    plot(a, bbb, '-', 'LineWidth', 2, 'Color', 'b'), gtext('K = 9');
    hold on;
    
    [mT nT] = size(dataT);  
     
    for iii = 1 : mT
        distance1T = zeros(1, m1);
        distance2T = zeros(1, m2);
        for i = 1: m1
            distance1T(1, i) = sqrt((dataT(iii, 1) - data1(i, 1))^2 + (dataT(iii, 2) - data1(i, 2))^2);
        end
        for i = 1: m2
            distance2T(1, i) = sqrt((dataT(iii, 1) - data2(i, 1))^2 + (dataT(iii, 2) - data2(i, 2))^2);
        end
        distance1T = distance1T(1, 1:m1);
        distance2T = distance2T(1, 1:m2);
        distance1T = sort(distance1T);
        distance2T = sort(distance2T);

        xx = 1; yy = 1;
        while true
            if distance1T(xx) < distance2T(yy)
                xx = xx + 1;
            else
                yy = yy + 1;
            end
            if xx + yy == K + 2
                if xx > yy
                    %plot(dataT(iii, 1), dataT(iii, 2),'.',  'color', 'b');
                    %hold on;
                else
                    %plot(dataT(iii, 1), dataT(iii, 2),'.', 'color', 'r');
                    %hold on;
                end
                %display(distance1); display(distance2);
                %display(a); display(b);display(xx); display(yy);
                break;
            end
        end

        %display(bbb);
    end    
end