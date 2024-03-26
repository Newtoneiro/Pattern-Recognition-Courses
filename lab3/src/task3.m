# 3. Canonical solution is 45 voting classifiers - one for each pair of digits - and making the final 
% decision with unanimity voting (only digits with 9 votes are classified; if the number of 
% votes is smaller classifier produces reject decision). You should report individual classifier 
% error rates as well as quality of the ensemble. Quite interesting insight into ensemble 
% operation can give you a confusion matrix.

[tvec tlab tstv tstl] = readSets();

[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% shift labels by one to use labels directly as indices
tlab += 1;
tstl += 1;

% training of the whole ensemble
[ovo, err] = trainOVOensemble(tvec, tlab, @perceptron);
err

% check your ensemble on train set
clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = unamvoting(tstv, ovo);
cfmx = confMx(tstl, clab)
compErrors(cfmx)