# 3. Canonical solution is 45 voting classifiers - one for each pair of digits - and making the final 
% decision with unanimity voting (only digits with 9 votes are classified; if the number of 
% votes is smaller classifier produces reject decision). You should report individual classifier 
% error rates as well as quality of the ensemble. Quite interesting insight into ensemble 
% operation can give you a confusion matrix. 

% training of the whole ensemble
ovo = trainOVOensemble(tvec, tlab, @perceptron);

% check your ensemble on train set
clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = unamvoting(tstv, ovo);
cfmx = confMx(tstl, clab)
compErrors(cfmx)