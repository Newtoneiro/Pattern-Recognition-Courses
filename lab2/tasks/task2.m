% POINT 2
% Selecting features
plot2features(train, 2, 4) % - Clear clusters visible

train_selected_features = train(:, [1, 2, 4]);

pdfindep_para = para_indep(train_selected_features);
pdfmulti_para = para_multi(train_selected_features);
pdfparzen_para = para_parzen(train_selected_features, 0.001); 
% this window width should be included in your report!

test_selected_features = test(:, [1, 2, 4]);

base_ercf = zeros(1,3);
base_ercf(1) = mean(bayescls(test_selected_features(:,2:end), @pdf_indep, pdfindep_para) != test_selected_features(:,1));
base_ercf(2) = mean(bayescls(test_selected_features(:,2:end), @pdf_multi, pdfmulti_para) != test_selected_features(:,1));
base_ercf(3) = mean(bayescls(test_selected_features(:,2:end), @pdf_parzen, pdfparzen_para) != test_selected_features(:,1));
base_ercf % - very low errors