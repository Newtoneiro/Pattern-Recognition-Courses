% POINT 6
% nn classificator

correct = 0;

for test_id = 1:rows(test)
    test_instance = test(test_id, 2:end);
    test_label = test(test_id, 1);
    
    % Find the nearest neighbor
    prediction = cls1nn(test_instance, train);
    
    if prediction == test_label
        correct = correct + 1;
    end
end

printf("Accuracy: %f\n", correct / rows(test))

% In point 6 we should consider data normalization

std(train(:,2:end))
std(test(:,2:end))

% The magnitudes of these values vary significantly, ranging from 10^(-10) to 10^(-3). Such variations in scale among features could impact the performance of some machine learning algorithms, particularly those sensitive to the scale of input features.

% Should we normalize?
% If YES remember to normalize BOTH training and testing sets

% YOUR CODE GOES HERE 
%

% Normalize the data
train_normalized = train;

for fid = 1:columns(train(:, 2:end))
    fid = fid + 1;
    train_normalized(:,fid) = (train(:,fid) - min(train(:,fid))) / (max(train(:,fid)) - min(train(:,fid)));
end

std(train_normalized(:,2:end)) % std = 1 for all features

% Normalize the test data
test_normalized = test;

for fid = 1:columns(test(:, 2:end))
    fid = fid + 1;
    test_normalized(:,fid) = (test(:,fid) - min(train(:,fid))) / (max(train(:,fid)) - min(train(:,fid)));
end

std(test_normalized(:,2:end)) % std = 1 for all features

% Test

errors = zeros(2, 3);

pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001);

errors(1, 1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
errors(1, 2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
errors(1, 3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));

pdfindep_para_n = para_indep(train_normalized);
pdfmulti_para_n = para_multi(train_normalized);
pdfparzen_para_n = para_parzen(train_normalized, 0.001);

errors(2, 1) = mean(bayescls(test_normalized(:,2:end), @pdf_indep, pdfindep_para_n) != test_normalized(:,1));
errors(2, 2) = mean(bayescls(test_normalized(:,2:end), @pdf_multi, pdfmulti_para_n) != test_normalized(:,1));
errors(2, 3) = mean(bayescls(test_normalized(:,2:end), @pdf_parzen, pdfparzen_para_n) != test_normalized(:,1));

printf("Errors without normalization: %f %f %f\n", errors(1, 1), errors(1, 2), errors(1, 3));
printf("Errors with normalization: %f %f %f\n", errors(2, 1), errors(2, 2), errors(2, 3));