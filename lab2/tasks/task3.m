% POINT 3
% Test reduce func

rdlab = unique(pdf_test(:,1));
reduced = reduce(pdf_test, [0.8 0.4]);
[rdlab'; sum(reduced(:,1) == rdlab')]

% ans =
%     1    2
%     8    4

% In the next point, the reduce function will be useful, which reduces the number of samples 
% in the individual classes (in this case, the reduction will be the same in all classes - 
% OF THE TRAINING SET)
% Because reduce has to draw samples randomly, the experiment should be repeated 5 times
% In the report, please provide only the mean value and the standard deviation 
% of the error coefficient

parts = [0.1, 0.25, 0.5];
rep_cnt = 5; % at least

% YOUR CODE GOES HERE 
%

mean_errors = zeros(length(parts), 3);
std_errors = zeros(length(parts), 3);

for partition_id = 1:columns(parts)
    partition = parts(partition_id)
    errors = zeros(3, rep_cnt);
    for rep = 1:rep_cnt
        reduced_train = reduce(train, partition * ones(1, 8));
        pdfindep_para = para_indep(reduced_train);
        pdfmulti_para = para_multi(reduced_train);
        pdfparzen_para = para_parzen(reduced_train, 0.001);

        errors(1, rep) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
        errors(2, rep) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
        errors(3, rep) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
    end
    mean_errors(partition_id, :) = mean(errors, 2);
    std_errors(partition_id, :) = std(errors');
end

% Display overall results
printf("\nOverall Mean Errors:\n");
disp(mean_errors);

printf("\nOverall Standard Deviations:\n");
disp(std_errors);

% note that for given experiment you should reduce all classes in the training
% set with the same reduction coefficient; assuming that class_count is the 
% number of different classes in the training set you can take 3/4 random samples
% of each class with:
% 	reduced_train = reduce(train, 0.75 * ones(1, class_count))
% 