locations= [1304 2312;3639 1315;4177 2244;3712 1399;3488 1535;3326 1556; 
                3238 1229;4196 1044;4312  790;4386  570;3007 1970;2562 1756; 
                 2788 1491;2381 1676;1332  695;3715 1678;3918 2179;4061 2370; 
                 3780 2212;3676 2578;4029 2838;4263 2931;3429 1908;3507 2376;              
                 3394 2643;3439 3201;2935 3240;3140 3550;2545 2357;2778 2826;2370 2975]; 
 
plot(locations(:,1),locations(:,2),'bo'); 
n= size(locations,1);%n表示问题∧规模（城市个数） 
distances = zeros(n); 
for count1=1:n, 
    for count2=1:count1, 
        x1 = locations(count1,1); 
        y1 = locations(count1,2); 
        x2 = locations(count2,1); 
        y2 = locations(count2,2); 
        distances(count1,count2)=sqrt((x1-x2)^2+(y1-y2)^2); 
        distances(count2,count1)=distances(count1,count2); 
    end; 
end; 
type tsp_create_permutations.m 
type tsp_crossover_permutation.m 
type tsp_mutate_permutation.m 
type tsp_fitness.m 
type tsp_traveling_salesman_plot.m 
FitnessFcn = @(x) tsp_fitness(x,distances); 
tsp_my_plot = @(options,state,flag) tsp_traveling_salesman_plot(options, ... 
            state,flag,locations); 
options = gaoptimset('PopulationType', 'custom','PopInitRange', ... 
                     [1;n]); 
options = gaoptimset(options,'CreationFcn',@tsp_create_permutations, ... 
                             'CrossoverFcn',@tsp_crossover_permutation, ... 
                             'MutationFcn',@tsp_mutate_permutation, ... 
                             'PlotFcn', tsp_my_plot, ... 
                             'Generations',1000,'PopulationSize',60, ... 
                             'StallGenLimit',200,'Vectorized','on'); 
numberOfVariables = n; 
[x,fval,reason,output] = ga(FitnessFcn,numberOfVariables,options)