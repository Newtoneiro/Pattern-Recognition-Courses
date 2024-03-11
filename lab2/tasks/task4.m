% POINT 4
% Point 4 concerns only Parzen window classifier (on the full training set)

parzen_widths = [0.0001, 0.0005, 0.001, 0.005, 0.01];
parzen_res = zeros(1, columns(parzen_widths));

% YOUR CODE GOES HERE 
%

for i = 1:columns(parzen_widths)
    parzen_width = parzen_widths(i);
    pdfparzen_para = para_parzen(train, parzen_width);
    parzen_res(i) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
end

[parzen_widths; parzen_res]
% Plots are sometimes better than numerical results
semilogx(parzen_widths, parzen_res)