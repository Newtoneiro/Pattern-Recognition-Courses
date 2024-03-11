% POINT 5
% In point 5 you should reduce TEST SET

apriori = [0.165 0.085 0.085 0.165 0.165 0.085 0.085 0.165];
parts = [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0];

% YOUR CODE GOES HERE 
%
errors = zeros(2, 3);

pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001);

errors(1, 1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
errors(1, 2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
errors(1, 3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));

reduced_test = reduce(test, parts);
errors(2, 1) = mean(bayescls(reduced_test(:,2:end), @pdf_indep, pdfindep_para) != reduced_test(:,1));
errors(2, 2) = mean(bayescls(reduced_test(:,2:end), @pdf_multi, pdfmulti_para) != reduced_test(:,1));
errors(2, 3) = mean(bayescls(reduced_test(:,2:end), @pdf_parzen, pdfparzen_para) != reduced_test(:,1));

printf("Errors without reduction: %f %f %f\n", errors(1, 1), errors(1, 2), errors(1, 3));
printf("Errors with reduction: %f %f %f\n", errors(2, 1), errors(2, 2), errors(2, 3));